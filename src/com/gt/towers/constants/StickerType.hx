package com.gt.towers.constants;

/**
 * ...
 * @author Mansour Djawadi
 */
class StickerType 
{
	public function new() {}
	
	public static var S0_LUCKKY:Int = 0;
	public static var S1_THANKS:Int = 1;
	public static var S2_THREAT:Int = 2;
	public static var S3_WELL_PLAYED:Int = 3;
	//public static var S4_OOPS:Int = 4;
	//public static var S5_ALL_YOU_GOT:Int = 5;
	public static var S6_HAHAHA:Int = 6;
	public static var S7_REVENGE:Int = 7;
	public static var S8_CURSED:Int = 8;
	
	//public static var S9_I_AFRAID:Int = 9;
	public static var S10_DO_YOU_ANY:Int = 10;
	public static var S11_NOVICE:Int = 11;
	public static var S12_PRACTICE:Int = 12;
	//public static var S13_DISCONNECTED:Int = 13;
	public static var S14_PROFESSIONAL:Int = 14;
	public static var S15_DONT_FORCE:Int = 15;
	public static var S16_I_SEE_YOU_SMALL:Int = 16;
	
#if flash
	public static function getAll(friendlyMode:Int) : Array<Int>
	{
		var ret = new Array<Int>();
		
		ret.push( S0_LUCKKY );
		ret.push( S1_THANKS );
		ret.push( S2_THREAT );
		ret.push( S3_WELL_PLAYED );
		//ret.push( S4_OOPS );
		//ret.push( S5_ALL_YOU_GOT );
		ret.push( S6_HAHAHA );
		ret.push( friendlyMode > 0 ? S7_REVENGE : S8_CURSED );
		//ret.push( S9_I_AFRAID );
		ret.push( S10_DO_YOU_ANY );
		ret.push( S11_NOVICE );
		ret.push( S12_PRACTICE );
		//ret.push( S13_DISCONNECTED );
		ret.push( S14_PROFESSIONAL );
		ret.push( S15_DONT_FORCE );
		ret.push( S16_I_SEE_YOU_SMALL );
		
		return ret;
	}
	
#elseif java
	public static function getRandomStart(ratio:Float, game:Game) : Int
	{
		var ret = new Array();
		if( ratio < 0 )
		{
			ret.push( S0_LUCKKY );
			//ret.push( S4_OOPS );
			ret.push( S8_CURSED );
			//ret.push( S9_I_AFRAID );
			ret.push( S14_PROFESSIONAL );
		}
		else if( ratio > 0 )
		{
			ret.push( S2_THREAT );
			//ret.push( S5_ALL_YOU_GOT );
			ret.push( S6_HAHAHA );
			//ret.push( S9_I_AFRAID );
			ret.push( S10_DO_YOU_ANY );
			ret.push( S11_NOVICE );
			ret.push( S12_PRACTICE );
			ret.push( S15_DONT_FORCE );
			ret.push( S16_I_SEE_YOU_SMALL );
		}
		else
		{
			ret.push( S1_THANKS );
			ret.push( S3_WELL_PLAYED );
		}
		return getRandom(ret);
	}

	public static function getAnswer( sticker : Int ) : Int
	{
		return switch( sticker )
		{
			case 0	:	getRandom([S6_HAHAHA, S12_PRACTICE, S16_I_SEE_YOU_SMALL]);
			case 1	: 	getRandom([S1_THANKS, S3_WELL_PLAYED]);
			case 2	: 	getRandom([/*S4_OOPS, */S6_HAHAHA, S8_CURSED/*, S9_I_AFRAID*/, S12_PRACTICE, S14_PROFESSIONAL, S15_DONT_FORCE, S16_I_SEE_YOU_SMALL]);
			case 3	: 	getRandom([S1_THANKS, S12_PRACTICE]);
			case 4	: 	getRandom([S2_THREAT, S3_WELL_PLAYED, /*S4_OOPS, */S10_DO_YOU_ANY, S15_DONT_FORCE]);
			case 5	: 	getRandom([S2_THREAT, S16_I_SEE_YOU_SMALL]);
			case 6	: 	getRandom([S2_THREAT, /*S5_ALL_YOU_GOT, */S14_PROFESSIONAL, S16_I_SEE_YOU_SMALL]);
			case 8	: 	getRandom([S2_THREAT, S6_HAHAHA, S12_PRACTICE, S15_DONT_FORCE]);
			case 9	: 	getRandom([S2_THREAT, S6_HAHAHA, S12_PRACTICE, S15_DONT_FORCE, S16_I_SEE_YOU_SMALL]);
			case 10	:	getRandom([/*S5_ALL_YOU_GOT, */S6_HAHAHA, S14_PROFESSIONAL, S16_I_SEE_YOU_SMALL]);
			case 11	:	getRandom([S0_LUCKKY, /*S4_OOPS, */S6_HAHAHA/*, S9_I_AFRAID*/, S12_PRACTICE, S14_PROFESSIONAL, S15_DONT_FORCE, S16_I_SEE_YOU_SMALL]);
			case 12	:	getRandom([/*S4_OOPS, */S6_HAHAHA, S10_DO_YOU_ANY, S11_NOVICE, S14_PROFESSIONAL, S15_DONT_FORCE, S16_I_SEE_YOU_SMALL]);
			case 13	:	getRandom([/*S4_OOPS, */S10_DO_YOU_ANY, S15_DONT_FORCE]);
			case 14	:	getRandom([S2_THREAT, /*S5_ALL_YOU_GOT, */S6_HAHAHA, S10_DO_YOU_ANY, S11_NOVICE, S12_PRACTICE, S16_I_SEE_YOU_SMALL]);
			case 15	:	getRandom([S3_WELL_PLAYED, S6_HAHAHA, S8_CURSED, /*S9_I_AFRAID, */S10_DO_YOU_ANY, S11_NOVICE, S12_PRACTICE, S14_PROFESSIONAL, S15_DONT_FORCE, S16_I_SEE_YOU_SMALL]);
			case 16	:	getRandom([S3_WELL_PLAYED, S6_HAHAHA, S8_CURSED, /*S9_I_AFRAID, */S10_DO_YOU_ANY, S11_NOVICE, S12_PRACTICE, S14_PROFESSIONAL, S15_DONT_FORCE, S16_I_SEE_YOU_SMALL]);
			default :	S3_WELL_PLAYED;
		}
	}
	private static function getRandom(array: Array<Int>) : Int
	{
		return array[ Math.floor( Math.random() * array.length )];
	}
#end
}