package com.gt.towers;
import com.gt.towers.utils.maps.IntIntIntMap;
import com.gt.towers.utils.maps.IntIntMap;
import com.gt.towers.utils.maps.IntStrMap;

/**
 * ...
 * @author Mansour Djawadi
 */
class InitData 
{
	public var id:Int;
	public var nickName:String;
	public var market:String;
	public var appVersion:Int;
	public var sessionsCount:Int;
	public var resources:IntIntMap;
	public var cardsLevel:IntIntMap;
	public var operations:IntIntMap;
	public var prefs:IntStrMap;
	public var decks:IntIntIntMap;
	
	public function new() 
	{
		resources = new IntIntMap();
		cardsLevel = new IntIntMap();
		operations = new IntIntMap();
		prefs = new IntStrMap();
		decks = new IntIntIntMap();
	}
}