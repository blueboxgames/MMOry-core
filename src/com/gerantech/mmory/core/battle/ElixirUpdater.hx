package com.gerantech.mmory.core.battle;

import com.gerantech.mmory.core.scripts.ScriptEngine;

/**
 * ...
 * @author Mansour Djawadi
 */
class ElixirUpdater
{
	static public var INIT_VALUE:Int = 6;
	static public var MAX_VALUE:Int = 10;
	static public var SPEED:Float = 0.00020;

	public var bars:Array<Float>;
	public var reserved:Array<Int>;
	public var normalSpeeds:Array<Float>;
	public var finalSpeeds:Array<Float>;
#if java 
	public var callback:com.gerantech.mmory.core.interfaces.IValueChangeCallback;
#end
	public function new (mode:Int)
	{
		this.reserved = [-1,-1];
		this.bars = new Array<Float>();
		this.normalSpeeds = new Array<Float>();
		this.finalSpeeds = new Array<Float>();
		this.normalSpeeds[0]	= this.normalSpeeds[1]	= SPEED * ScriptEngine.getInt(ScriptEngine.T47_CHALLENGE_ELIXIRSPEED, mode, false);
		this.finalSpeeds[0]		= this.finalSpeeds[1]	= SPEED * ScriptEngine.getInt(ScriptEngine.T47_CHALLENGE_ELIXIRSPEED, mode, true);
	}

	public function init() : Void
	{
		updateAt(0, INIT_VALUE);
		updateAt(1, INIT_VALUE);
	}

	public function update(deltaTime:Int, isFinalMode:Bool) : Void
	{
		// -=-=-=-=-=-=-=-=-=-=-  INCREASE ELIXIRS  -=-=-=-=-=-=-=-=-=-=-=-
		this.updateAt(0, this.bars[0] + (isFinalMode ? this.finalSpeeds[0] : this.normalSpeeds[0]) * deltaTime);
		this.updateAt(1, this.bars[1] + (isFinalMode ? this.finalSpeeds[1] : this.normalSpeeds[1]) * deltaTime);
	  // trace("bars: " + bars.toString() + "  normalSpeeds: " + normalSpeeds.toString());
	}

	public function updateAt(side:Int, value:Float) : Void
	{
		this.bars[side] = Math.min(MAX_VALUE, value);
#if java 
		var res:Int = Math.floor(this.bars[side]);
		if( this.reserved[side] != res )
		{
			if( this.callback != null )
				this.callback.update(side, this.reserved[side], res);
			this.reserved[side] = res;
		}
#end
	}
}