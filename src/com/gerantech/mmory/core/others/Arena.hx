package com.gerantech.mmory.core.others;
/**
 * ...
 * @author Mansour Djawadi
 */
class Arena 
{
	static public var STEP:Int;
	public var index:Int;
	public var min:Int;
	public var max:Int;
	public var minWinRate:Int;
	public var rewards:Array<TrophyReward>;
	public function new(game:Game, index:Int, min:Int, max:Int, minWinRate:Int, rewards:String = null)
	{
		this.index = index;
		this.min = min;
		this.max = max;
		this.minWinRate = minWinRate;
		this.rewards = new Array<TrophyReward>();
		if( rewards == null || rewards == "" )
			return;

		var list:Array<String> = rewards.split(",");
		var len:Int = list.length;
		var kayVal:Array<String>;
		for( i in 0...len )
		{
			kayVal = list[i].split(":");
			this.rewards.push(new TrophyReward(game, index, i, Std.parseInt(kayVal[0]), Std.parseInt(kayVal[1]), Std.parseInt(kayVal[2]), STEP));
			if( index > 0 )
				STEP ++;
		}
	}
	public function lastReward():TrophyReward
	{
		return this.rewards[this.rewards.length - 1];
	}

	public function calculateStep(maxPoint:Int) : Int
	{
		for( reward in this.rewards )
			if( reward.point > maxPoint )
				return reward.step - 1;
		return lastReward().step; 
	}
}