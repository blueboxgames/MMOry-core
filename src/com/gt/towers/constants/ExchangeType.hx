package com.gt.towers.constants;

/**
 * ...
 * @author Mansour Djawadi
 */

class ExchangeType
{
	public static var C0_HARD:Int = 0;
	public static var C1_HARD:Int = 1;
	public static var C2_HARD:Int = 2;
	public static var C3_HARD:Int = 3;
	public static var C4_HARD:Int = 4;
	public static var C5_HARD:Int = 5;
	public static var C6_HARD:Int = 6;

	static public var C10_SOFT:Int = 10;
	static public var C11_SOFT:Int = 11;
	static public var C12_SOFT:Int = 12;
	static public var C13_SOFT:Int = 13;

	static public var C70_TICKETS:Int = 70;
	static public var C71_TICKET:Int = 71;
	static public var C72_TICKET:Int = 72;
	static public var C73_TICKET:Int = 73;

	static public var C20_SPECIALS:Int = 20;
	static public var C21_SPECIAL:Int = 21;
	static public var C22_SPECIAL:Int = 22;
	static public var C23_SPECIAL:Int = 23;
	static public var C29_DAILY_BATTLES:Int = 29;

	static public var C30_BUNDLES:Int = 30;
	static public var C31_BUNDLE:Int = 31;
	static public var C32_BUNDLE:Int = 32;

	static public var C40_OTHERS:Int = 40;
	static public var C41_KEYS:Int = 41;
	static public var C42_RENAME:Int = 42;
	static public var C43_ADS:Int = 43;

	static public var C100_FREES:Int = 100;
	static public var C101_FREE:Int = 101;
	static public var C102_FREE:Int = 102;
	static public var C103_FREE:Int = 103;
	static public var C104_STARS:Int = 104;

	static public var C107_FREE:Int = 107;
	static public var C108_FREE:Int = 108;
	static public var C109_FREE:Int = 109;

	static public var C110_BATTLES:Int = 110;
	static public var C111_BATTLE:Int = 111;
	static public var C112_BATTLE:Int = 112;
	static public var C113_BATTLE:Int = 113;
	static public var C114_BATTLE:Int = 114;

	static public var C120_MAGICS:Int = 120;
	static public var C121_MAGIC:Int = 121;
	static public var C122_MAGIC:Int = 122;
	static public var C123_MAGIC:Int = 123;
	
	static public var BOOKS_50:Int = 50;
	static public var BOOK_51_METAL:Int = 51;
	static public var BOOK_52_KNIGHT:Int = 52;
	static public var BOOK_53_STARS:Int = 53;
	static public var BOOK_54_SEA:Int = 54;
	static public var BOOK_55_PIRATE:Int = 55;
	static public var BOOK_56_JUNGLE:Int = 56;
	static public var BOOK_57_TREASURE:Int = 57;
	static public var BOOK_58_AMBER:Int = 58;
	static public var BOOK_59_DRAGON:Int = 59;

	public function new() {}
	public static function getCategory(type:Int):Int
	{
		return Math.floor(type / 10) * 10;
	}

	public static function getCooldown(type:Int):Int
	{
		return switch ( type )
		{
			case 41		: 24	* 3600;
			case 43		: 2		* 3600;
			case 51		: 10		  ;
			case 52		: 3		* 3600;
			case 53		: 8		* 3600;
			case 54		: 12	* 3600;
			case 57		: 24	* 3600;
			case 59		: 24	* 3600;
			case 101	: 3		* 3600;
			case 104	: 24	* 3600;
			default : 0;
		}
	}

	public static function getNumSlots(type:Int):Int
	{
		return switch ( type )
		{
			case 51 : 2;
			case 52 : 3;
			case 53 : 4;
			case 54 : 5;
			case 55 : 5;
			case 56 : 6;
			case 57 : 6;
			case 58 : 7;
			case 59 : 7;
			default : 0;
		}
	}

	public static function getNumTotalCards(type:Int, arena:Int, coef:Float, rarity:Int):Int
	{
		var ret:Int = switch ( type )
		{
			case 51 : 3		+ 1		* arena;
			case 52 : 3		+ 1		* arena;
			case 53 : 10	+ 3		* arena;
			case 54 : 20	+ 6		* arena;
			case 55 : 35	+ 12	* arena;
			case 56 : 70	+ 24	* arena;
			case 57 : 80	+ 28	* arena;
			case 58 : 120	+ 36	* arena;
			case 59 : 150	+ 40	* arena;
			default : 0;
		}
		ret = Math.ceil(ret * coef * 0.8);
		
		if( rarity >= 1 )
		{
			ret = switch ( type )
			{
/*				case 51 : Math.round(ret * 0.09);
				case 52 : Math.round(ret * 0.15);
				case 53 : Math.round(ret * 0.49);
				case 54 : Math.round(Math.pow(ret * 0.065, 1.4));
*/				case 55 : Math.round(2.5 + Math.pow(ret * 0.065, 1.35));
				case 56 : Math.round(3.0 + Math.pow(ret * 0.065, 1.35));
				case 57 : Math.round(3.2 + Math.pow(ret * 0.065, 1.35));
				case 58 : Math.round(3.4 + Math.pow(ret * 0.065, 1.35));
				case 59 : Math.round(3.6 + Math.pow(ret * 0.065, 1.35));
				default : Math.round(Math.pow(ret * 0.065, 1.4));
			}
		}
		if( rarity >= 2 )
		{
			ret = type < 55 ? 0 : Math.round(ret * 0.18);
		}
		return ret;
	}

	public static function getNumSofts(type:Int, arena:Int, coef:Float):Int
	{
		return Math.round(Math.pow(getNumTotalCards(type, arena, coef, 0), 1.5) * 0.6);
	}

	public static function isMagic(type:Int) : Bool
	{
		return type == BOOK_55_PIRATE || type == BOOK_56_JUNGLE || type == BOOK_58_AMBER ;
	}
}