package com.gerantech.mmory.core.others;
import com.gerantech.mmory.core.utils.Int3;
/**
 * ...
 * @author Mansour Djawadi
 */
class Arena 
{
	public var index:Int;
	public var min:Int;
	public var max:Int;
	public var minWinRate:Int;
	public var rewards:Array<Int3>;
	public function new(index:Int, min:Int, max:Int, minWinRate:Int, rewards:String = null)
	{
		this.index = index;
		this.min = min;
		this.max = max;
		this.minWinRate = minWinRate;
#if flash
		this.rewards = new Array<Int3>();
		if( rewards == null || rewards == "" )
			return;

		var list:Array<String> = rewards.split(",");
		var len:Int = list.length;
		var kayVal:Array<String>;
		for( i in 0...len )
		{
			kayVal = list[i].split(":");
			this.rewards.push(new Int3(Std.parseInt(kayVal[0]), Std.parseInt(kayVal[1]), Std.parseInt(kayVal[2])));
		}
#end
	}
}