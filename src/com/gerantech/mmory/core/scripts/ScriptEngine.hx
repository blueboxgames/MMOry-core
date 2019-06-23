package com.gerantech.mmory.core.scripts;

import hscript.Expr.Error;

/**
 * ...
 * @author Mansour Djawadi
 */
class ScriptEngine
{
	static public var T00_RARITY:Int = 0;
	static public var T01_AVAILABLE_AT:Int = 1;
	static public var T02_ELIXIR_SIZE = 2;
	static public var T03_QUANTITY = 3;
	static public var T04_SUMMON_TIME = 4;
	//static public var T05_BIRTH_RATE = 5;
	
	static public var T11_SPEED:Int = 11;
	static public var T12_HEALTH:Int = 12;
	static public var T13_SIZE_H:Int = 13;
	static public var T14_SIZE_V:Int = 14;
	static public var T15_FOCUS_RANGE:Int = 15;
	static public var T16_EXPLOSIVE:Int = 16;
	
	static public var T21_BULLET_SPEED:Int = 21;
	static public var T22_BULLET_DAMAGE:Int = 22;
	static public var T23_BULLET_SHOOT_GAP:Int = 23;
	static public var T24_BULLET_SHOOT_DELAY:Int = 24;
	static public var T25_BULLET_RANGE_MIN:Int = 25;
	static public var T26_BULLET_RANGE_MAX:Int = 26;
	static public var T27_BULLET_DAMAGE_AREA:Int = 27;
	static public var T28_BULLET_EXPLODE_DElAY:Int = 28;
	static public var T29_BULLET_FORCE_KILL:Int = 29;

	static public var T41_CHALLENGE_MODE:Int = 41;
	static public var T42_CHALLENGE_TYPE:Int = 42;
	static public var T43_CHALLENGE_UNLOCKAT:Int = 43;
	static public var T44_CHALLENGE_CAPACITY:Int = 44;
	static public var T45_CHALLENGE_WAITTIME:Int = 45;
	static public var T46_CHALLENGE_DURATION:Int = 46;
	static public var T47_CHALLENGE_ELIXIRSPEED:Int = 47;
	static public var T48_CHALLENGE_REWARDCOEF:Int = 48;
	static public var T51_CHALLENGE_JOIN_REQS:Int = 51;
	static public var T52_CHALLENGE_RUN_REQS:Int = 52;

	static public var T61_BATTLE_NUM_TUTORS:Int = 61;
	static public var T62_BATTLE_NUM_COVERS:Int = 62;
	static public var T63_BATTLE_NUM_ROUND:Int = 63;
	static public var T64_BATTLE_SUMMON_POS:Int = 64;

	static var script:String;
	static var version:Float;
	static var program:Dynamic;
	static var interp:hscript.Interp;

	static public function initialize(_script:String) 
	{
		script = _script;
		program = new hscript.Parser().parseString(script);
		interp = new hscript.Interp();
		interp.variables.set("Math", Math); // share the Math class
		version = get(-2, 0);
	}
	
	static public function get(type:Int, ?arg0:Dynamic, ?arg1:Dynamic = null, ?arg2:Dynamic = null, ?arg3:Dynamic = null) : Dynamic
	{
		interp.variables.set("__type", type);
		interp.variables.set("__arg0", arg0);
		if( arg1 != null )
			interp.variables.set("__arg1", arg1);
		if( arg2 != null )
			interp.variables.set("__arg2", arg2);
		if( arg3 != null )
			interp.variables.set("__arg3", arg3);
		
		try { return interp.execute(program);	}
		catch(e:Error) { trace("Error exp execute in type: " + type + ", args0: " + arg0 + ", arg1: " + arg1 + ", arg2: " + arg2 + ", arg3: " + arg3); }
		return null;
	}
	
	static public function getInt(type:Int, arg0:Dynamic, arg1:Dynamic = null, arg2:Dynamic = null, arg3:Dynamic = null) : Int
	{
		return Math.round(get(type, arg0, arg1, arg2, arg3));
	}
	
	static public function getBool(type:Int, ?arg0:Dynamic, ?arg1:Dynamic = null, ?arg2:Dynamic = null, ?arg3:Dynamic = null) : Bool
	{
		return cast(get(type, arg0, arg1, arg2, arg3), Bool);
	}
}