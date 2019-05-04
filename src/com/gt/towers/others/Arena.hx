package com.gt.towers.others;
import com.gt.towers.utils.lists.IntList;

/**
 * ...
 * @author Mansour Djawadi
 */
class Arena 
{
	public var index:Int;
	public var min:Int;
	public var max:Int;
	public var minWinStreak:Int;
	public function new(index:Int, min:Int, max:Int, minWinStreak:Int)
	{
		this.index = index;
		this.min = min;
		this.max = max;
		this.minWinStreak = minWinStreak;
	}
}