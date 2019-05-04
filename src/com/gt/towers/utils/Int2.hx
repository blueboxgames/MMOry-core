package com.gt.towers.utils;

/**
 * ...
 * @author 
 */
class Int2 
{
	public var i:Int;
	public var j:Int;
	public function new(i:Int, j:Int) 
	{
		this.i = i;
		this.j = j;
	}
	
	public function equal(other:Int2) : Bool
	{
		return Int2.equalValues(this.i, other.i, this.j, other.j);
	}
	
	static public function equalValues(i:Int, i1:Int, j:Int, j1:Int) 
	{
		return i == i1 && j == j1;
	}
	
	public function toString() : String
	{
		return ("i:" + i + ", j:" + j + ")");
	}
}