package com.gerantech.mmory.core.battle.bullets;
import com.gerantech.mmory.core.battle.GameObject;
import com.gerantech.mmory.core.battle.units.Card;
import com.gerantech.mmory.core.battle.units.Unit;
import com.gerantech.mmory.core.constants.CardTypes;

/**
 * ...
 * @author Mansour Djawadi
 */ 
class Bullet extends GameObject
{
	public var unit:Unit;
	public var target:Unit;
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

	public function new(battleField:BattleField, unit:Unit, target:Unit, id:Int, card:Card, side:Int, x:Float, y:Float, z:Float, fx:Float, fy:Float, fz:Float) 
	{
		super(id, battleField, card, side, x, y, z);
		this.unit = unit;
		this.target = target;
		this.summonTime = battleField.now + card.bulletShootDelay;
		this.sx = this.x;
		this.sy = this.y;
		this.sz = this.z;
		this.fx = fx;
		this.fy = fy;
		this.fz = fz;
		this.createPath();
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
		
		// prevent shooting while unit disposed.
		if( !card.explosive && unit != null && unit.disposed() )
		{
			dispose();
			return;
		}
		summonTime = 0;
		setState(GameObject.STATE_1_DIPLOYED);
	}
	
	function move() : Void
	{
		if( explodeTime > -1 )
			return;
		if( target != null && !target.disposed() )
		{
			this.fx = target.x;
			this.fy = target.y;
			this.fz = target.z;
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