package com.gerantech.mmory.core.battle.units;
import com.gerantech.mmory.core.socials.Challenge;
import com.gerantech.mmory.core.utils.CoreUtils;
import com.gerantech.mmory.core.battle.BattleField;
import com.gerantech.mmory.core.battle.GameObject;
import com.gerantech.mmory.core.battle.units.Card;
import com.gerantech.mmory.core.constants.CardTypes;
import com.gerantech.mmory.core.events.BattleEvent;
import com.gerantech.mmory.core.utils.Point2;

/**
 * @author Mansour Djawadi
 */
class Unit extends GameObject
{
	public var health:Float;
	public var cardHealth:Float;
	public var bulletId:Int = 0;
	var target:Point2;
	var defaultTarget:Point2;
	var attackTime:Float = 0;
	var cachedEnemy:Int = -1;
	var path:Array<Point2>;
	var immortalTime:Float;

	public function new(id:Int, battleField:BattleField, card:Card, side:Int, x:Float, y:Float, z:Float) 
	{
		super(id, battleField, card, side, x, y, z);
		//trace(card.toString() );
		this.summonTime = this.battleField.now + this.card.summonTime;
		this.immortalTime = this.summonTime;
		
		// fake health for tutorial
		var h:Float = this.card.health;
		if( side > 0 && battleField.games[0].player.get_battleswins() < 5 )
			h = h * 0.5 + ((battleField.games[0].player.get_battleswins() + 1) / 10) * h;
		this.cardHealth = h;
		this.setHealth(h);
		
		this.bulletId = id * 10000;
		if( this.card.speed <= 0 )
			return;
		this.target = new Point2(0, 0);
		var returnigPosition = this.battleField.field.tileMap.getTile(this.x, this.y);
		if( CardTypes.isHero(card.type) )
			this.defaultTarget = new Point2(returnigPosition.x, returnigPosition.y);
		else
			this.defaultTarget = new Point2(battleField.field.mode == Challenge.MODE_0_HQ ? BattleField.WIDTH * 0.5 : CoreUtils.clamp(returnigPosition.x, 320, 640), side == 0 ? 0 : BattleField.HEIGHT);
	}
	
	override public function update() : Void
	{
		if( this.isDump || this.disposed() )
			return;
		
		if( this.summonTime > this.battleField.now )
			return;
		
		if( this.card.selfDammage != 0 )
			this.setHealth(this.health - this.card.selfDammage);
		this.finalizeDeployment();
		this.finalizeImmortal();
		this.decide();
	}

	// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= deploy -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	function finalizeDeployment() : Void
	{
		if( this.summonTime == 0 )
			return;
		this.summonTime = 0;
		this.setState(GameObject.STATE_1_DIPLOYED);
	}
	function finalizeImmortal() : Void
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
	function decide() 
	{
		//var log = "decide => id:" + id + " type: " + this.card.type;
		var enemyId = getNearestEnemy();
		if( enemyId > -1 )
		{
			var enemy = this.battleField.units.get(enemyId);
			var newEnemyFound = enemyId != this.cachedEnemy;
			if( newEnemyFound )
				this.cachedEnemy = enemyId;
			
			//log += " enemyId:" + enemyId;
			if( com.gerantech.mmory.core.utils.CoreUtils.getDistance(this.x, this.y, enemy.x, enemy.y) <= this.card.bulletRangeMax )
			{
				if( this.attackTime < this.battleField.now )
				{
					this.attack(enemy);
					// log += "   " + health + " <=> " + enemy.health;
					// trace(log);
				}
				else
				{
					// log += "   wait" ;
					// trace(log);
					this.setState(GameObject.STATE_3_WAITING);
				}
				return;
			}
			
			if( this.card.speed <= 0 )
				return;
			
			if( newEnemyFound )
			{
				// log += " move to enemy." ;
				// trace(log);
				this.changeMovingTarget(enemy.x, enemy.y);
			}
			this.move();
			return;
		}
		if( this.card.speed <= 0 )
			return;
		
		if( !this.target.equalsPoint(this.defaultTarget) )
			this.changeMovingTarget(this.defaultTarget.x, this.defaultTarget.y);
		this.move();
	}
	
	// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= movement -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	function changeMovingTarget(x:Float, y:Float) : Void
	{
		// trace("changeMovingTarget  id: " + id + " type: " + this.card.type + "   " + target );
		this.target.x = x;
		this.target.y = y;
		this.findPath(x, y);
	}

	function findPath(targetX:Float, targetY:Float) : Void
	{
		Point2.disposeAll(this.path);
		if( this.card.speed <= 0 )
			return;
		
		if( this.x == targetX && this.y == targetY )
		{
			this.path = null;
			return;
		}
		this.path = this.battleField.field.tileMap.findPath(this.x, this.y, targetX, targetY, side == 0 ? 1 : -1);
		if( this.path == null || this.path.length == 0 )
			return;
		if( BattleField.DEBUG_MODE )
		{
			var i = 0;
			var len = path.length;
			var pthStr = "findPath  id: " + id + " side: " + side + " type: " + this.card.type + "  ";
			while ( i < len )
			{
				pthStr += (this.path[i].x + "," + this.path[i].y + " ");
				i ++;
			}
			this.fireEvent(id, "findPath", null);
			trace(pthStr);
		}
		this.estimateAngle();
	}

	function estimateAngle() : Void 
	{
		var angle:Float = Math.atan2(this.path[0].y - y, this.path[0].x - x);
		this.deltaX = Math.round(this.card.speed * Math.cos(angle) * 1000) / 1000;
		this.deltaY = Math.round(this.card.speed * Math.sin(angle) * 1000) / 1000;
		//trace("side:" + side + "  x:" + x + " " + path[0].x + " ,  y:" + y + " " + path[0].y + " ,  delta:" + deltaX + " " + deltaY);
	}
	
//	var tracetime:Float;
	function move() : Void
	{
		if( this.card.speed <= 0 || this.path == null || this.path.length == 0 )
			return;
		
		var cx:Float = this.deltaX * this.battleField.deltaTime;
		var cy:Float = this.deltaY * this.battleField.deltaTime;
		/*var log = "";
		if( this.battleField.now > tracetime )
			log = "move   id: " + id + " type: " + this.card.type + " path:" + this.path.length + "   px:" + path[0].x + " x:" + x + " cx:" + cx + "   py:" + path[0].y + " y:" + y + " cy:" + cy;*/
		cx = (Math.abs(this.path[0].x - x) < Math.abs(cx) || cx == 0) ? GameObject.NaN : (x + cx);
		cy = (Math.abs(this.path[0].y - y) < Math.abs(cy) || cy == 0) ? GameObject.NaN : (y + cy);
		/*if( this.battleField.now > tracetime )
		{
			log += "   ccx:" + cx + " ccy:" + cy;
			trace( log );
			tracetime = this.battleField.now + 1000;
		}*/
		
		if( cx == GameObject.NaN && cy == GameObject.NaN )
		{
			if( this.path.length > 1 )
			{
				this.path.shift();
				this.estimateAngle();
			}
			#if flash
			else
			{
				this.setState(GameObject.STATE_3_WAITING);
			}
			#end
			return;
		}
		this.setPosition(cx, cy, GameObject.NaN);
	}
	
	// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= attack -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	function getNearestEnemy() : Int
	{
		if ( this.cachedEnemy != -1 && this.battleField.units.exists(this.cachedEnemy) && !this.battleField.units.get(this.cachedEnemy).disposed() )
		{
			if( com.gerantech.mmory.core.utils.CoreUtils.getDistance(this.x, this.y, this.battleField.units.get(this.cachedEnemy).x, this.battleField.units.get(this.cachedEnemy).y) <= this.card.focusRange )
				return this.cachedEnemy;
		}
		
		var distance:Float = this.card.focusRange;
		var ret:Int = -1;
		var u:Unit;
		var i = 0;
		var keys = this.battleField.units.keys();
		var len = keys.length;
		while ( i < len )
		{
			u = this.battleField.units.get(keys[i++]);
			if( u == null || u.disposed() || u.summonTime != 0 )
				continue;

			// prevent axis units for building target cards 
			if( !this.card.focusUnit && u.card.speed > 0 && CardTypes.isTroop(u.card.type) )
				continue;
			
			// configure vertical angle vision 
			if( this.card.focusHeight > u.z )
				continue;

			if( (this.card.bulletDamage >= 0 && this.side != u.side) || (this.card.bulletDamage < 0 && this.side == u.side && u.card.type != CardTypes.C109 && u.card.type < CardTypes.C201 && u.health < u.card.health) )
			{
				var dis = com.gerantech.mmory.core.utils.CoreUtils.getDistance(this.x, this.y, u.x, u.y);
				if( dis <= distance )
				{
					distance = dis;
					ret = u.id;
				}
			}
		}
		return ret;
	}
	
	function attack(enemy:Unit) : Void
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

	function setHealth(health:Float) : Float
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
		Point2.disposeAll(this.path);
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