package com.gt.towers.constants;

/**
 * ...
 * @author Mansour Djawadi
 */
class PrefsTypes 
{
	public static var SETTINGS_1_MUSIC:Int = 1;
	public static var SETTINGS_2_SFX:Int = 2;
	public static var SETTINGS_3_NOTIFICATION:Int = 3;
	public static var SETTINGS_4_LOCALE:Int = 4;
	public static var SETTINGS_5_REMOVE_ADS:Int = 5;
	
    public static var OFFER_30_RATING:Int = 30;
    public static var OFFER_31_TELEGRAM:Int = 31;
    public static var OFFER_32_INSTAGRAM:Int = 32;
    public static var OFFER_33_FRIENDSHIP:Int = 33;
	
	public static var AUTH_41_GOOGLE:Int = 41;
	public static var AUTH_42_GAMECENTER:Int = 42;
	public static var AUTH_43_TELEGRAM:Int = 43;
	
	public static var OTHERS_91_LOBBY:Int = 91;

	
	public static var TUTOR:Int = 101;
	
	public static var T_000_FIRST_RUN:Int = 0;
	public static var T_001_START:Int = 1;
	public static var T_002_FIRST_SUMMON:Int = 2;
	public static var T_003_FIRST_STAR:Int = 3;
	public static var T_004_SECOND_STAR:Int = 4;
	public static var T_007_WIN:Int = 7;	
	
	public static var T_011_SLOT_FOCUS:Int = 11;
	public static var T_012_SLOT_OPENED:Int = 12;
	public static var T_013_BOOK_OPENED:Int = 13;
	public static var T_015_DECK_FOCUS:Int = 15;
	public static var T_016_DECK_SHOWN:Int = 16;
	public static var T_017_CARD_OPENED:Int = 17;
	public static var T_018_CARD_UPGRADED:Int = 18;
	public static var T_019_RETURN_TO_BATTLE:Int = 19;
	
	public static var T_71_SELECT_NAME_FOCUS:Int = 71;
	public static var T_72_NAME_SELECTED:Int = 72;

	public static var T_73_CHALLENGES_SHOWN:Int = 73;
	public static var T_74_CHALLENGE_SELECTED:Int = 74;

	public function new() {}
	public static function isSettings(type:Int) : Bool
	{
		return type >= 0 && type < 10;
	}
	public static function isOffer(type:Int) : Bool
	{
		return type >= 30 && type < 40;
	}
}