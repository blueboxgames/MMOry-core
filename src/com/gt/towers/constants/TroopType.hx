package com.gt.towers.constants;

/**
 * ...
 * @author Mansour Djawadi
 */
class TroopType 
{
	public static var NONE:Int = -1;
	
	public static var T_0:Int = 0;
	public static var T_1:Int = 1;
	public static var T_2:Int = 2;
	public static var T_3:Int = 3;

	public static function getColor(type:Int):Int
	{
		return switch(type)
		{
			case -1 : 0xFFFFFF;
			case 0  : 0x1C73B9;
			case 1  : 0xCE1C31;
			default : 0xFFFFFF;			
		}
	}
	public static var NUM_TYPES:Int = 2;
	
	public function new(){}
}