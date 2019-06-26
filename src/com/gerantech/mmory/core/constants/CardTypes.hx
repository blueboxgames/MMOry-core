package com.gerantech.mmory.core.constants;


import com.gerantech.mmory.core.scripts.ScriptEngine;

/**
 * ...
 * @author Babak Sheikh Salimi
 */
class CardTypes 
{
	static public var AVAILABLITY_EXISTS:Int = 0;
	static public var AVAILABLITY_WAIT:Int = -1;
	static public var AVAILABLITY_NOT:Int = -2;

	public static var INITIAL:Int = 102;

	public static var IMPROVE:Int = -2;
	public static var NONE:Int = -1;

	// troops
	public static var C101:Int = 101;
	public static var C102:Int = 102;
	public static var C103:Int = 103;
	public static var C104:Int = 104;
	public static var C105:Int = 105;
	public static var C106:Int = 106;
	public static var C107:Int = 107;
	public static var C108:Int = 108;
	public static var C109:Int = 109;
	public static var C110:Int = 110;
	public static var C111:Int = 111;
	public static var C112:Int = 112;
	public static var C113:Int = 113;
	public static var C114:Int = 114;
	public static var C115:Int = 115;
	public static var C116:Int = 116;
	public static var C117:Int = 117;
	public static var C118:Int = 118;
	public static var C119:Int = 119;
	public static var C120:Int = 120;
	public static var C121:Int = 121;
	public static var C122:Int = 122;
	public static var C123:Int = 123;
	public static var C124:Int = 124;
	public static var C125:Int = 125;
	public static var C126:Int = 126;
	public static var C127:Int = 127;
	public static var C128:Int = 128;
	public static var C129:Int = 129;
	
	// spells
	public static var C151:Int = 151;
	public static var C152:Int = 152;
	public static var C153:Int = 153;
	public static var C154:Int = 154;
	//public static var C155:Int = 155;
	//public static var C156:Int = 156;
	//public static var C157:Int = 157;
	//public static var C158:Int = 158;
	//public static var C159:Int = 159;

	// buildings
	public static var C201:Int = 201;

	// heros
	public static var C221:Int = 221;
	
	public function new() {}
		
	public static function getRarityColor(rarity:Int) : Int
	{
		return [0xFFFFFF, 0xFFCC00, 0xAA00AA][rarity];
	}

	public static function get_category(type:Int):Int
	{
		return Math.floor(type / 50) * 50;
	}
	
	/**public static function get_special_ability(type:Int):Int
	{
		
		 *  Speed		= 0
		 *  Health		= 1
		 * 	Power		= 2
		 * 	Generation	= 3
		 
		return type / 10;
	}*/
	
	static public function isTroop(type:Int) : Bool
	{
		return type < 150;
	}
	
	static public function isSpell(type:Int) : Bool
	{
		return type > 150 && type < 200;
	}

	static public function isBuilding(type:Int) : Bool
	{
		return type > 200 && type < 220;
	}

	static public function isHero(type:Int) : Bool
	{
		return type > 220;
	}

// #if flash
/* static private var _all:Array<Int>;
	static public function getAll():Array<Int>
	{
		if( _all == null )
		{
			_all = new Array<Int>();
			var ret = new Array<Int>();
			var i = 0;
			while ( i < 131 )
			{
				ret.push(i);
				i ++;
			}
			i = 151;
			while ( i <= 154 )
			{
				ret.push(i);
				i ++;
			}
		}
		return ret;
	} */

	static public function getRelatedTo(cardType:Int) : Array<Int> 
	{
		var ret = new Array<Int>();
		ret.push(ScriptEngine.T22_BULLET_DAMAGE);
		if( CardTypes.isSpell(cardType) )
			return ret;
		ret.push(ScriptEngine.T23_BULLET_SHOOT_GAP);
		ret.push(ScriptEngine.T04_SUMMON_TIME);
		ret.push(ScriptEngine.T11_SPEED);
		ret.push(ScriptEngine.T12_HEALTH);
		ret.push(ScriptEngine.T26_BULLET_RANGE_MAX);
		return ret;
	}

	static public function getUIFactor(featureType:Int):Float
	{
		return switch (featureType)
		{
			/*case 5 : 1000;
				case 12: 50;
				case 21: 50;
				case 23: 0.2;
				case 24: 0.2; */
			case 4: 0.001;
			case 11: 1000;
			case 12: 50;
			case 22: 100;
			case 23: 0.01;
			case 26: 0.5;
			default: 1;
		}
	}
// #end
}