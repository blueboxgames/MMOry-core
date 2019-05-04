package com.gt.towers.constants;

/**
 * ...
 * @author Mansour Djawadi
 */
class MessageTypes 
{
    public static var M0_TEXT:Int = 0;
	
    public static var M10_COMMENT_JOINT:Int = 10;
    public static var M11_COMMENT_LEAVE:Int = 11;
    public static var M12_COMMENT_KICK:Int = 12;
    public static var M13_COMMENT_PROMOTE:Int = 13;
    public static var M14_COMMENT_DEMOTE:Int = 14;
    public static var M15_COMMENT_EDIT:Int = 15;
	public static var M16_COMMENT_JOIN_ACCEPT:Int = 16;
	public static var M17_COMMENT_JOIN_REJECT:Int = 17;
	public static var M18_COMMENT_BAN:Int = 18;

	public static var M20_DONATE:Int = 20;

	public static var M30_FRIENDLY_BATTLE:Int = 30;
	public static var M31_FRIENDLY_BATTLE:Int = 31;
	public static var M32_FRIENDLY_BATTLE:Int = 32;

	public static var M41_CONFIRM_JOIN:Int = 41;
	public static var M42_CONFIRM_INVITATION:Int = 42;

	public static var M50_URL:Int = 50;
	public static var M51_EMOTE:Int = 51;

	
	//public static var JOIN_LOBBY_REQUEST_SENT:Int = 1;
    //public static var JOIN_LOBBY_SUCCEED:Int = 0;
   // public static var JOIN_LOBBY_NOT_ALLOWED:Int = -1;
    public static var JOIN_LOBBY_MULTI_LOBBY_ILLEGAL:Int = -2;
	//public static var JOIN_LOBBY_REQUEST_ALREADY_SENT:Int = -3;
	
    public static var RESPONSE_SENT:Int = 1;
    public static var RESPONSE_SUCCEED:Int = 0;
    public static var RESPONSE_NOT_ALLOWED:Int = -1;
	public static var RESPONSE_ALREADY_SENT:Int = -3;
    public static var RESPONSE_NOT_FOUND:Int = -4;
    public static var RESPONSE_UNKNOWN_ERROR:Int = -5;
	
	public static var RESPONSE_NOT_ENOUGH_REQS:Int = -6;
	public static var RESPONSE_MUST_WAIT:Int = -7;

	
	
	public function new(){}
	
	static public function isComment(type:Int) : Bool
	{
		return type >= 10 && type < 20;
	}
	
	static public function isDonate(type:Int) : Bool
	{
		return type >= 20 && type < 30;
	}

	static public function isBattle(type:Int) : Bool
	{
		return type >= 30 && type < 40;
	}

	static public function isConfirm(type:Int) : Bool
	{
		return type >= 40 && type < 50;
	}	
	
	static public function isEmote(type:Int) : Bool
	{
		return type == 51;
	}
	
}