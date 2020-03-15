package com.gerantech.mmory.core.battle;
import com.gerantech.mmory.core.battle.units.Card;
/**
 * ...
 * @author Mansour Djawadi
 */
class GameObject
{
#if java
	public var eventCallback:com.gerantech.mmory.core.events.EventCallback;
#end
	static public var NaN:Int = -1000000;
	static public var STATE_0_INITIALIZED:Int = 0;
	static public var STATE_1_DIPLOYED:Int = 1;
	static public var STATE_2_MORTAL:Int = 2;
	static public var STATE_3_WAITING:Int = 3;
	static public var STATE_4_MOVING:Int = 4;
	static public var STATE_5_SHOOTING:Int = 5;
	static public var STATE_8_DIPOSED:Int = 8;

	public var id:Int;
	public var x:Float;
	public var y:Float;
	public var z:Float = 0;
	public var card:Card;
	public var state:Int = -1;
	public var isDump:Bool;
	public var summonTime:Float = 0;
	public var battleField:BattleField;
	public var deltaX:Float;
	public var deltaY:Float;
	public function new(id:Int, battleField:BattleField, card:Card, side:Int, x:Float, y:Float, z:Float)
	{
		this.id = id;
		this.battleField = battleField;
		this.side = side;
		this.card = card;
		this.setPosition(x, y, z, true);
		this.setState(GameObject.STATE_0_INITIALIZED);
	}

	@:isVar
	public var side(default, set):Int;
	private function set_side(value:Int):Int {
		return this.side = value;
	}

	public function update() : Void
	{
	}

	public function setPosition(x:Float, y:Float, z:Float, forced:Bool = false) : Bool
	{
		if( !forced && ( x <= NaN || x == this.x ) && ( y <= NaN || y == this.y ) && ( z <= NaN || z == this.z ) )
			return false;
		if( x > NaN )
			this.x = x;
		if( y > NaN )
			this.y = y;
		if( z > NaN )
			this.z = z;
#if flash
		if( !forced )
			this.setState(GameObject.STATE_4_MOVING);
#end
		return true;
	}

	function setState(state:Int) : Bool
	{
		if( this.state == state )
			return false;
		this.state = state;
		this.fireEvent(id, com.gerantech.mmory.core.events.BattleEvent.STATE_CHANGE, state);
		return true;
	}

	function fireEvent (dispatcherId:Int, type:String, data:Any) : Void
	{
#if java
		if( eventCallback != null )
			eventCallback.dispatch(dispatcherId, type, data);
#end
	}

	public function dispose() : Void
	{
		setState(GameObject.STATE_8_DIPOSED);
	}

	public function disposed() : Bool
	{
		return state == GameObject.STATE_8_DIPOSED;
	}

	#if flash
	public function getSideX() : Float
	{
		return getSide_X(x);
	}
	public function getSideY() : Float
	{
		return getSide_Y(y);
	}
	public function getSide_X(x:Float) : Float
	{
		if ( battleField.side == 0 )
			return x;
		return BattleField.WIDTH - x;
	}
	public function getSide_Y(y:Float) : Float
	{
		if ( battleField.side == 0 )
			return y;
		return BattleField.HEIGHT - y;
	}
	#end
}