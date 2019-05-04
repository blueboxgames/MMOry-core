package com.gt.towers.battle.tilemap;
import com.gt.towers.utils.Int2;

/**
 * ...
 * @author Mansour Djawadi
 */
class Tile extends Int2
{
	public var cost:Float;
	public var last:Int;
	public var x:Float;
	public var y:Float;
	public function new(i:Int, j:Int, cost:Float, last:Int) 
	{
		super(i, j);
		this.cost = cost;
		this.last = last;
	}
	
	public function update(i:Int, j:Int, cost:Float, last:Int) : Tile
	{
		this.i = i;
		this.j = j;
		this.cost = cost;
		this.last = last;
		return this;
	}
	
	override public function toString() : String
	{
		return "(i:" + i + ", j:" + j + ", cost:" + cost + ", last:" + last + ", x:" + x + ", y:" + y + ")";
	}
}