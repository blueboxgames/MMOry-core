package com.gerantech.mmory.core.events;
/**
 * ...
 * @author Mansour Djawadi
 */

#if java
class BattleEvent 
#elseif flash
class BattleEvent extends flash.events.Event
#end
{
static public var STATE_CHANGE:String = "sc";
static public var PAUSE:String = "p";

#if java
public function new() {}
#elseif flash
public var data:Any;
public function new(type:String, data:Any = null)
{
	super(type, false, false);
	this.data = data;
}
#end
}