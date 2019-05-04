package com.gt.towers.battle.units;
import com.gt.towers.battle.BattleField;
import com.gt.towers.battle.GameObject;
import com.gt.towers.battle.units.Card;
import com.gt.towers.constants.CardTypes;
import com.gt.towers.events.BattleEvent;
import com.gt.towers.socials.Challenge;
import com.gt.towers.utils.Point2;

/**
 * @author Mansour Djawadi
 */
class Unit extends GameObject
{
    public var health:Float;
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
		this.summonTime = battleField.now + card.summonTime;
		this.immortalTime = this.summonTime;
		
		// fake health for tutorial
		if( side == 1 )
			this.health = card.health * 0.5 + Math.min(0.5, (battleField.games[0].player.get_battleswins() + 1) / 10) * card.health;
		else
			this.health = card.health;
		
		this.bulletId = id * 10000;
		this.movable = card.type != CardTypes.C201;
		if( !this.movable )
			return;
		this.target = new Point2(0, 0);
		var returnigPosition = battleField.field.tileMap.getTile(this.x, this.y);
		if( CardTypes.isHero(card.type) )
			this.defaultTarget = new Point2(returnigPosition.x, returnigPosition.y);
		else
			this.defaultTarget = new Point2(battleField.field.mode == Challenge.MODE_0_HQ ? BattleField.WIDTH * 0.5 : returnigPosition.x, side == 0 ? 0 : BattleField.HEIGHT);
	}
	
	override public function update() : Void
	{
		if( isDump || disposed() )
			return;
		
		if( summonTime > battleField.now )
			return;
		
		finalizeDeployment();
		finalizeImmortal();
		decide();
	}

	// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= deploy -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	function finalizeDeployment() : Void
	{
		if( summonTime == 0 )
			return;
		summonTime = 0;
		setState(GameObject.STATE_1_DIPLOYED);
	}
	function finalizeImmortal() : Void
	{
		if( immortalTime == 0 )
			return;
		if( immortalTime < battleField.now )
		{
			setState(GameObject.STATE_2_MORTAL);
			immortalTime = 0;
		}
	}
	

	// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= decide -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	function decide() 
	{
		//var log = "decide => id:" + id + " type: " + card.type;
		var enemyId = getNearestEnemy();
		if( enemyId > -1 )
		{
			var enemy = battleField.units.get(enemyId);
			var newEnemyFound = enemyId != cachedEnemy;
			if( newEnemyFound )
				cachedEnemy = enemyId;
			
			//log += " enemyId:" + enemyId;
			if( com.gt.towers.utils.CoreUtils.getDistance(this.x, this.y, enemy.x, enemy.y) <= card.bulletRangeMax )
			{
				if( attackTime < battleField.now )
				{
					attack(enemy);
					//log += "   " + health + " <=> " + enemy.health;
					//trace(log);
				}
				else
				{
					//log += "   wait" ;
					//trace(log);
					setState(GameObject.STATE_3_WAITING);
				}
				return;
			}
			
			if( !movable )
				return;
			
			if( newEnemyFound )
			{
				//log += " move to enemy." ;
				//trace(log);
				changeMovingTarget(enemy.x, enemy.y);
			}
			move();
			return;
		}
		if( !movable )
			return;
		
		if( !target.equalsPoint(defaultTarget) )
			changeMovingTarget(defaultTarget.x, defaultTarget.y);
		move();
	}
	
	// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= movement -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	function changeMovingTarget(x:Float, y:Float) : Void
	{
//		trace("changeMovingTarget  id: " + id + " type: " + card.type + "   " + target );
		this.target.x = x;
		this.target.y = y;
		findPath(x, y);
	}

	function findPath(targetX:Float, targetY:Float) : Void
	{
		Point2.disposeAll(path);
		if( !movable )
			return;
		
		if( this.x == targetX && this.y == targetY )
		{
			path = null;
			return;
		}
		path = battleField.field.tileMap.findPath(this.x, this.y, targetX, targetY, side == 0 ? 1 : -1);
		if( path == null || path.length == 0 )
			return;
		if( BattleField.DEBUG_MODE )
		{
			var i = 0;
			var len = path.length;
			var pthStr = "findPath  id: " + id + " side: " + side + " type: " + card.type + "  ";
			while ( i < len )
			{
				pthStr += (path[i].x + "," + path[i].y + " ");
				i ++;
			}
			fireEvent(id, "findPath", null);
			trace(pthStr);
		}
		estimateAngle();
	}

	function estimateAngle() : Void 
	{
		var angle:Float = Math.atan2(path[0].y - y, path[0].x - x);
        deltaX = Math.round(card.speed * Math.cos(angle) * 1000) / 1000;
        deltaY = Math.round(card.speed * Math.sin(angle) * 1000) / 1000;
		//trace("side:" + side + "  x:" + x + " " + path[0].x + " ,  y:" + y + " " + path[0].y + " ,  delta:" + deltaX + " " + deltaY);
	}
	
//	var tracetime:Float;
	function move() : Void
	{
		if( !movable || path == null || path.length == 0 )
			return;
		
		var cx:Float = deltaX * battleField.deltaTime;
		var cy:Float = deltaY * battleField.deltaTime;
		/*var log = "";
		if( battleField.now > tracetime )
			log = "move   id: " + id + " type: " + card.type + " path:" + this.path.length + "   px:" + path[0].x + " x:" + x + " cx:" + cx + "   py:" + path[0].y + " y:" + y + " cy:" + cy;*/
		cx = (Math.abs(path[0].x - x) < Math.abs(cx) || cx == 0) ? GameObject.NaN : (x + cx);
		cy = (Math.abs(path[0].y - y) < Math.abs(cy) || cy == 0) ? GameObject.NaN : (y + cy);
		/*if( battleField.now > tracetime )
		{
			log += "   ccx:" + cx + " ccy:" + cy;
			trace( log );
			tracetime = battleField.now + 1000;
		}*/
		
		if( cx == GameObject.NaN && cy == GameObject.NaN )
		{
			if( path.length > 1 )
			{
				path.shift();
				estimateAngle();
			}
			#if flash
			else
			{
				setState(GameObject.STATE_3_WAITING);
			}
			#end
			return;
		}
		setPosition(cx, cy, GameObject.NaN);
	}
	
	// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= attack -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	function getNearestEnemy() : Int
	{
		if ( cachedEnemy != -1 && battleField.units.exists(cachedEnemy) && !battleField.units.get(cachedEnemy).disposed() )
		{
			if( com.gt.towers.utils.CoreUtils.getDistance(this.x, this.y, battleField.units.get(cachedEnemy).x, battleField.units.get(cachedEnemy).y) <= card.focusRange )
				return cachedEnemy;
		}
		
		var distance:Float = card.focusRange;
		var ret:Int = -1;
		var u:Unit;
		var i = 0;
		var keys = battleField.units.keys();
		var len = keys.length;
		while ( i < len )
		{
			u = battleField.units.get(keys[i++]);
			if( u == null || u.disposed() || u.summonTime != 0 )
				continue;
			
			if( (card.bulletDamage >= 0 && this.side != u.side) || (card.bulletDamage < 0 && this.side == u.side && u.card.type != CardTypes.C109 && u.card.type < CardTypes.C201 && u.health < u.card.health) )
			{
				var dis = com.gt.towers.utils.CoreUtils.getDistance(this.x, this.y, u.x, u.y);
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
		setState(GameObject.STATE_5_SHOOTING);
#if java
		battleField.addBullet(this, side, x, y, enemy);
#end
		fireEvent(id, BattleEvent.ATTACK, enemy);
		attackTime = battleField.now + card.bulletShootGap;
	}
	
	public function hit(damage:Float) : Void
	{
		if( disposed() || ( battleField.now < immortalTime && !card.explosive ) )
			return;
		
		health = Math.min(health - damage, card.health);
		if( health <= 0 )
			dispose();
		//trace("type:" + card.type + " id:" + id + " damage:" + damage + " health:" + health);
		fireEvent(id, BattleEvent.HIT, damage);
	}

	public override function dispose() : Void
	{
		if( disposed() )
			return;
		Point2.disposeAll(path);
		if( card.explosive && !isDump )
			attack(this);
		super.dispose();
	}
	
	#if java
	public function toString():String
	#elseif flash
	public override function toString():String
	#end
	{
		return "type:" + card.type + " x:" + x + " y:" + y + " side:" + side + " level:" + card.level + " elixirSize:" + card.elixirSize + " summonTime:" + card.summonTime + " health:" + health + " speed:" + card.speed + " bulletDamage:" + card.bulletDamage + " bulletFireGap:" + card.bulletShootGap + " bulletRangeMax:" + card.bulletRangeMax;
	}
}