package com.gt.towers.constants;

/**
 * ...
 * @author Mansour Djawadi
 */

class ResourceType 
{
	public static var R1_XP:Int = 1;
	public static var R2_POINT:Int = 2;
	public static var R3_CURRENCY_SOFT:Int = 3;
	public static var R4_CURRENCY_HARD:Int = 4;
	public static var R5_CURRENCY_REAL:Int = 5;
	public static var R6_TICKET:Int = 6;
	public static var R7_MAX_POINT:Int = 7;

	public static var R11_OPERATIONS:Int = 11;
	public static var R12_BATTLES:Int = 12;
	public static var R13_BATTLES_WINS:Int = 13;
	public static var R15_BATTLES_FRIENDLY:Int = 15;
	public static var R16_WIN_RATE:Int = 16;
	public static var R17_STARS:Int = 17;
	
	public static var R21_BOOK_OPENED_BATTLE:Int = 21;
	public static var R22_BOOK_OPENED_FREE:Int = 22;
	
	public static var R30_CHALLENGES:Int = 30;
	public static var R40_QUESTS:Int = 40;
	
	public function new() {}
	static public function getName(type:Int) : String
	{
			 if( type == R1_XP )			return "XP";
		else if( type == R2_POINT )			return "Point";
		else if( type == R3_CURRENCY_SOFT ) return "Coins";
		else if( type == R4_CURRENCY_HARD ) return "Gems";
		else if( type == R5_CURRENCY_REAL ) return "Real";
		else if( type == R17_STARS )		return "Stars";
		else return "TYPE_" + type;
	}
	
	static public function isCard(type:Int) 
	{
		return (type >= 100); 
	}
	static public function isBook(type:Int) 
	{
		return type >= 50 && type < 60;
	}
}