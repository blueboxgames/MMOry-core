package com.gerantech.mmory.core.battle.bullets;
import com.gerantech.mmory.core.battle.GameObject;
import com.gerantech.mmory.core.battle.units.Card;
import com.gerantech.mmory.core.constants.CardTypes;

/**
 * ...
 * @author Mansour Djawadi
 */ 
class Bullet extends GameObject
{
	public var targetId:Int = -1;
	var sx:Float;
	var sy:Float;
	var sz:Float;
	var fx:Float;
	var fy:Float;
	var fz:Float;
	var dx:Float;
	var dy:Float;
	var dz:Float;
	var deltaZ:Float;
	var explodeTime:Float = -1;

	public function new(battleField:BattleField, id:Int, card:Card, side:Int, x:Float, y:Float, z:Float, fx:Float, fy:Float, fz:Float) 
	{
		super(id, battleField, card, side, x, y, z);
		this.summonTime = battleField.now + card.bulletShootDelay;
		this.sx = this.x;
		this.sy = this.y;
		this.sz = this.z;
		this.fx = fx;
		this.fy = fy;
		this.fz = fz;
		createPath();
	}
	
	function createPath() 
	{
		dx = fx - sx;
		dy = fy - sy;
		dz = fz - sz;
		var angle:Float = Math.atan2(dy, dx);
		deltaX = card.bulletSpeed * Math.cos(angle);
		deltaY = card.bulletSpeed * Math.sin(angle);
		if( dy != 0 )
			deltaZ = deltaY / dy * dz;
		else if( dx != 0 )
			deltaZ = deltaX / dx * dz;
		else
			deltaZ = card.bulletSpeed;
		
		//if( card.type == 151)
			//trace("==>id" + id + " x" + x + " y:" + y + " z:" + z + " fx:" + fx + " fy:" + fy + " fz:" + fz + " dx:" + dx + " dy:" + dy + " dz:" + dz + " deltaX:" + deltaX + " deltaY:" + deltaY + " deltaZ:" + deltaZ);
	}

	override public function update() : Void
	{
		if( disposed() )
			return;
		if( summonTime > battleField.now )
			return;
		
		finalizeDeployment();
		move();
		if( explodeTime > -1 && explodeTime < battleField.now )
			explode();
	}

	// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-= deploy -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
	function finalizeDeployment() : Void
	{
		if( summonTime == 0 )
			return;
		summonTime = 0;
		// prevent shooting while projectile is dead.
		var unitId:Int = Std.int((id - id % 10000) / 10000);
		if( !CardTypes.isSpell(card.type) && !card.explosive && !battleField.units.exists(unitId) )
		{
			dispose();
			return;
		}
		setState(GameObject.STATE_1_DIPLOYED);
	}
	
	function move() : Void
	{
		if( explodeTime > -1 )
			return;
		if( card.bulletForceKill && this.battleField.units.exists(targetId) )
		{
			this.fx = battleField.units.get(targetId).x;
			this.fy = battleField.units.get(targetId).y;
			this.fz = battleField.units.get(targetId).z;
			createPath();
		}
		setPosition(dx != 0 ? x + deltaX : GameObject.NaN, dy != 0 ? y + deltaY : GameObject.NaN, dz != 0 ? z + deltaZ : GameObject.NaN);
		if( (deltaX >= 0 && x >= fx || deltaX < 0 && x <= fx) && (deltaY >= 0 && y >= fy || deltaY < 0 && y <= fy) && (deltaZ >= 0 && z >= fz || deltaZ < 0 && z <= fz) )
			hit();
	}	
	
	function hit() 
	{
		x = fx;
		y = fy;
		z = fz;
		explodeTime = battleField.now + card.bulletExplodeDelay;
	}
	
	function explode() 
	{
		setState(GameObject.STATE_5_SHOOTING);
		battleField.explodeBullet(this);
		dispose();
	}
}