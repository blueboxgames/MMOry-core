package com.gerantech.mmory.core.battle.units;
import com.gerantech.colleagues.Shape;
import com.gerantech.colleagues.Colleague;
import com.gerantech.mmory.core.utils.CoreUtils;
import com.gerantech.mmory.core.battle.BattleField;
import com.gerantech.mmory.core.battle.GameObject;
import com.gerantech.mmory.core.battle.units.Card;
import com.gerantech.mmory.core.constants.CardTypes;
import com.gerantech.mmory.core.events.BattleEvent;

/**
 * @author Mansour Djawadi
 */
class Unit extends Colleague
{
	public var health:Float;
	public var cardHealth:Float;
	public var bulletId:Int = 0;
	var attackTime:Float = 0;
	var cachedEnemy:Int = -1;
	var cachedTargetX:Float = 0;
	var cachedTargetY:Float = 0;
	var targetIndex:Int = -1;
	var defaultTargetIndex:Int;
	var immortalTime:Float;

	public function new(id:Int, battleField:BattleField, card:Card, side:Int, x:Float, y:Float, z:Float) 
	{
		super(id, battleField, card, side, x, y, z);
		this.shape = Shape.create_circle(card.sizeH);

		this.shape.colleague = this;
		this.shape.initialize();
		if( card.speed <= 0 )
	    this.setStatic();
		this.summonTime = this.battleField.now + this.card.summonTime;
		this.immortalTime = this.summonTime;
		
		// fake health for tutorial
		var h:Float = this.card.health;
		if( card.game.player.isBot() && battleField.games[0].player.get_battleswins() < 7 )
			h = (0.2 + Math.min(0.8, (battleField.games[0].player.get_battleswins() + 1) / 10)) * h;
		this.cardHealth = h;
		this.setHealth(h);
		
		this.bulletId = id * 10000;
		this.defaultTargetIndex = CardTypes.isHero(card.type) ? id : 1 - this.side;
	}
	
	override public function update() : Void
	{
		if( this.isDump || this.disposed() )
			return;
		
		if( this.summonTime > this.battleField.now )
			return;
		
		if( this.card.selfDammage != 0 )
			this.setHealth(this.health - this.card.selfDammage * this.battleField.deltaTime);
		this.finalizeDeployment();
		this.finalizeImmortal();
		this.decide();
	}

	// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= deploy -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	private function finalizeDeployment() : Void
	{
		if( this.summonTime == 0 )
			return;
		this.summonTime = 0;
		this.setState(GameObject.STATE_1_DIPLOYED);
	}
	private function finalizeImmortal() : Void
	{
		if( this.immortalTime == 0 )
			return;
		if( this.immortalTime < this.battleField.now )
		{
			this.setState(GameObject.STATE_2_MORTAL);
			this.immortalTime = 0;
		}
	}
	
	// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= decide -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	private function decide() 
	{
		var enemyId = this.getNearestEnemy();
		if( enemyId > -1 )
		{
			var enemy = this.battleField.units.get(enemyId);
			var newEnemyFound = this.cachedEnemy != enemyId;
			this.cachedEnemy = enemyId;

			if( this.attackTime < this.battleField.now )
			{
				// if( id == 6)trace("attack " + CoreUtils.getDistance(this.x, this.y, enemy.x, enemy.y) + " " + (this.card.bulletRangeMax + enemy.card.sizeH + card.sizeH));
				if( CoreUtils.getDistance(this.x, this.y, enemy.x, enemy.y) <= this.card.bulletRangeMax + enemy.card.sizeH + card.sizeH )
				{
				// if( id == 6)trace("attack " + enemyId);
					this.attack(enemy);	
					return;
				}
			}
			else
			{
				// if( id == 6)trace("wait " + enemyId);
				this.setState(GameObject.STATE_3_WAITING);
				return;
			}
			
			if( this.card.speed <= 0 )
				return;
			if( newEnemyFound )
			{
				// if( id == 6)trace("move " + enemyId);
				// log += " move to enemy." ;
				// trace(log);
				this.targetIndex = -1;
				this.deltaX = this.deltaY = 0;
				this.cachedTargetX = enemy.x;
				this.cachedTargetY = enemy.y;
				this.estimateAngle(enemy.x, enemy.y);
			}
			this.move();
			return;
		}

		if( this.card.speed <= 0 )
			return;
		this.findTarget();
		this.move();
		// log += this.card.speed + "		dx:" + deltaX + " dy:" + deltaY;
		// trace(log);
	}
	private function findTarget():Void
	{
		if( this.targetIndex > -1 )
			return;
		
		if( CardTypes.isHero(card.type) )
		{
			this.targetIndex = this.defaultTargetIndex;
			this.cachedTargetX = this.battleField.field.targets[this.targetIndex * 2];
			this.cachedTargetY = this.battleField.field.targets[this.targetIndex * 2 + 1];
			this.estimateAngle(this.cachedTargetX, this.cachedTargetY);
			return;
		}
		
		var dis = 2000.0;
		var i:Int = 0;
		var tx:Float = 0;
		var ty:Float = 0;
		var len = this.battleField.field.targets.length;
		while (i < len)
		{
			if( i == side )
			{
				i += 2;
				continue;
			}
			tx = this.battleField.field.targets[i];
			ty = this.battleField.field.targets[i + 1];
			i += 2;
			if( (side == 0 && y < ty + 1) || (side == 1 && y > ty - 1) )
				continue;
			var d = CoreUtils.getDistance(tx, ty, x, y);
			if( dis > d )
			{
				this.targetIndex = Math.floor(i / 2);
				this.cachedTargetX = tx;
				this.cachedTargetY = ty;
				dis = d;
			}
		}

		if( dis == 2000.0 )
			this.targetIndex = this.defaultTargetIndex;
		this.estimateAngle(this.cachedTargetX, this.cachedTargetY);
		// trace("[" + cachedTargetX + " " + cachedTargetY + "] => dx:" + deltaX + " dy:" + deltaY);
	}

	private function estimateAngle(x:Float, y:Float) : Void 
	{
		if( y - this.y == 0 && x - this.x == 0 )
		{
			this.deltaX = this.deltaY = 0;
			return;
		}
		var angle:Float = Math.atan2(y - this.y, x - this.x);
		this.deltaX = Math.round(this.card.speed * Math.cos(angle) * 100000) / 100000;
		this.deltaY = Math.round(this.card.speed * Math.sin(angle) * 100000) / 100000;
		// trace("t:" + card.type + " angle:" + angle + "  x:" + x + " " + this.x + " ,  y:" + y + " " + this.y + " ,  delta:" + deltaX + " " + deltaY);
	}

	private function move() : Void
	{
		if( this.deltaX == 0 && this.deltaY == 0 )
		{
			#if flash
			this.setState(GameObject.STATE_3_WAITING);
			#end
			return;
		}

		// turn to new target
		if( (deltaX >= 0 && x >= cachedTargetX || deltaX < 0 && x <= cachedTargetX) && (deltaY >= 0 && y >= cachedTargetY || deltaY < 0 && y <= cachedTargetY) )
		{
			// last target
			if( this.targetIndex == this.defaultTargetIndex )
				return;
			this.targetIndex = -1;
			this.findTarget();
		}

		var cx:Float = this.deltaX * this.battleField.deltaTime;
		var cy:Float = this.deltaY * this.battleField.deltaTime;
		this.setPosition(x + cx, y + cy, GameObject.NaN);
	}
	
	// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= attack -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	private function getNearestEnemy() : Int
	{
		if( this.cachedEnemy != -1 && this.battleField.units.exists(this.cachedEnemy) && !this.battleField.units.get(this.cachedEnemy).disposed() )
		{
			if( CoreUtils.getDistance(this.x, this.y, this.battleField.units.get(this.cachedEnemy).x, this.battleField.units.get(this.cachedEnemy).y) <= this.card.focusRange )
				return this.cachedEnemy;
		}

		var ret:Int = -1;
		var distance:Float = this.card.focusRange;
		for( u in this.battleField.units )
		{
			// prevent disposed and deploying units
			if( u == null || u.disposed() || u.summonTime != 0 )
				continue;
			// prevent team-mates
			if( this.card.bulletDamage >= 0 && this.side == u.side )
				continue;
			// prevent axis units for building target cards 
			if( !this.card.focusUnit && u.card.speed > 0 && CardTypes.isTroop(u.card.type) )
				continue;
			// configure vertical angle vision 
			if( this.card.focusHeight > u.z )
				continue;
			// prevent healing of enemy, buildings, self and full-health
			if( this.card.bulletDamage < 0 && (this.side != u.side || u.card.speed <= 0 || u.id == this.id || u.health >= u.cardHealth) )
				continue;			
			var dis = CoreUtils.getDistance(this.x, this.y, u.x, u.y);
			if( dis <= distance )
			{
				distance = dis;
				ret = u.id;
			}
		}
		return ret;
	}
	
	private function attack(enemy:Unit) : Void
	{
		this.setState(GameObject.STATE_5_SHOOTING);
#if java
		this.battleField.addBullet(this, side, x, y, enemy);
#end
		this.fireEvent(id, BattleEvent.ATTACK, enemy);
		this.attackTime = this.battleField.now + this.card.bulletShootGap;
	}
	
	public function hit(damage:Float) : Void
	{
		if( this.disposed() || ( this.battleField.now < this.immortalTime && !this.card.explosive ) )
			return;
		
		this.setHealth(this.health - damage);
		//trace("type:" + this.card.type + " id:" + id + " damage:" + damage + " health:" + health);
		this.fireEvent(id, BattleEvent.HIT, damage);
	}

	private function setHealth(health:Float) : Float
	{
		if( health > this.cardHealth )
			health = this.cardHealth;
		
		var diff = this.health - health;
		if( diff == 0 )
			return diff;
		this.health = health;
		
		if( this.health <= 0 )
			this.dispose();

		return diff;
	}

	public override function dispose() : Void
	{
		if( this.disposed() )
			return;
		if( this.card.explosive && !this.isDump )
			this.attack(this);
		super.dispose();
	}
	
	#if java
	public function toString():String
	#elseif flash
	public override function toString():String
	#end
	{
		return "type:" + this.card.type + " x:" + this.x + " y:" + this.y + " side:" + this.side + " level:" + this.card.level + " elixirSize:" + this.card.elixirSize + " summonTime:" + this.card.summonTime + " health:" + this.health + " speed:" + this.card.speed + " bulletDamage:" + this.card.bulletDamage + " bulletFireGap:" + this.card.bulletShootGap + " bulletRangeMax:" + this.card.bulletRangeMax;
	}
}