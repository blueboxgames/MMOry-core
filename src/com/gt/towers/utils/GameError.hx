package com.gt.towers.utils;

/**
 * ...
 * @author Mansour Djawadi
 */
class GameError 
{
	public var id:Int;
	public var message:String;
	public var object:Dynamic;

	public function new(id:Int, message:String, object:Dynamic=null) 
	{
		this.id = id;
		this.message = message;
		this.object = object;
	}
	
}