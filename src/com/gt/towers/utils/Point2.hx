package com.gt.towers.utils;

/**
 * ...
 * @author Mansour Djawadi
 */
class Point2
{
	public var x:Float;
	public var y:Float;
	public function new(x:Float, y:Float) 
	{
		this.x = x;
		this.y = y;
	}

	public function equals(x:Float, y:Float) : Bool
	{
		return this.x == x && this.y == y;
	}
	
	public function equalsPoint(point:Point2) : Bool
	{
		return equals(point.x, point.y);
	}
	
	/*public function scale(value:Float) : Point2
	{
		this.x *= value;
		this.y *= value;
		return this;
	}*/
	
	static public function dispose(point2:Point2) : Void
	{
	}
	
	static public function disposeAll(path:Array<Point2>) : Void
	{
	}
	
}