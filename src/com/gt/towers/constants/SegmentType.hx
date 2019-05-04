package com.gt.towers.constants;
import com.gt.towers.utils.lists.IntList;

/**
 * ...
 * @author Mansour Djawadi
 */
class SegmentType 
{

	public function new() {}
	
	public static var S0_SHOP:Int = 0;
	public static var S1_DECK:Int = 1;
	public static var S2_HOME:Int = 2;
	public static var S3_SOCIALS:Int = 3;
	public static var S4_INBOX:Int = 4;
	
	public static var S10_LOBBY_MAIN:Int = 10;
	public static var S11_LOBBY_SEARCH:Int = 11;
	public static var S12_LOBBY_CREATE:Int = 12;
	public static var S13_FRIENDS:Int = 13;
	public static var S14_LOBBY_PUBLIC:Int = 14;
	
	public static function getDashboardsSegments():IntList
	{
		var ret:IntList = new IntList();
		ret.push( S0_SHOP );
		ret.push( S1_DECK );
		ret.push( S2_HOME );
		ret.push( S3_SOCIALS );
		ret.push( S4_INBOX );
		return ret;
	}
	
	public static function getSocialSegments(hasRoom:Bool):IntList
	{
		var ret:IntList = new IntList();
		ret.push( hasRoom ? S10_LOBBY_MAIN : S11_LOBBY_SEARCH);
		ret.push( hasRoom ? S11_LOBBY_SEARCH : S12_LOBBY_CREATE );
		ret.push( S13_FRIENDS );
		ret.push( S14_LOBBY_PUBLIC );
		return ret;
	}

}