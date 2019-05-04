package com.gt.towers.utils;

/**
 * ...
 * @author Mansour Djawadi
 */
class Point3 extends Point2
{
	public var z:Float;

	public function new(x:Float, y:Float, z:Float = 0) 
	{
		super(x, y);
		this.z = z;
	}
	
	public function scale(value:Float) : Point3
	{
		this.x *= value;
		this.y *= value;
		this.z *= value;
		return this;
	}

	public function p3_equals(x:Float, y:Float, z:Float) : Bool
	{
		return this.x == x && this.y == y && this.z == z;
	}
	
	public function p3_equalsPoint(point:Point3) : Bool
	{
		return p3_equals(point.x, point.y, point.z);
	}
	
	public function toString() : String
	{
		return "( x:" + x + ", y:" + y + ", z:" + z + " )";
	}
}