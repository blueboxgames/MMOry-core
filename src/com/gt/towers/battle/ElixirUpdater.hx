package com.gt.towers.battle;

import com.gt.towers.socials.Challenge;
/**
 * ...
 * @author Mansour Djawadi
 */
class ElixirUpdater
{
	static public var INIT_VALUE:Int = 7;
    static public var MAX_VALUE:Int = 10;
	static public var SPEED:Float = 0.00033;

    public var bars:Array<Float>;
    public var reserved:Array<Int>;
	public var normalSpeeds:Array<Float>;
	public var finalSpeeds:Array<Float>;
#if java 
	public var callback:com.gt.towers.interfaces.IValueChangeCallback;
#end
    public function new (mode:Int)
    {
		this.reserved = [-1,-1];
		this.bars = new Array<Float>();
		this.normalSpeeds = new Array<Float>();
		this.finalSpeeds = new Array<Float>();
		this.normalSpeeds[0]	= this.normalSpeeds[1]	= SPEED * Challenge.getElixirSpeed(mode, false);
		this.finalSpeeds[0]		= this.finalSpeeds[1]	= SPEED * Challenge.getElixirSpeed(mode, true);
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
		// trace("bars: " + bars.toString() + "  normalSpeeds: rmalSpeeds.toString}
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