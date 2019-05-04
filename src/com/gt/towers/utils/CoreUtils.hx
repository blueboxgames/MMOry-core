package com.gt.towers.utils;
import haxe.Int64;

/**
 * ...
 * @author Mansour Djawadi ...
 */
class CoreUtils 
{
	public function new(){}
	static public function round(value:Dynamic) : Int
	{
		if( value < 100 )
			return Math.round(value);
		if( value < 1000 )
			return Math.round(value / 10) * 10;
		if( value < 10000 )
			return Math.round(value / 100) * 100;
		if( value < 100000 )
			return Math.round(value / 1000) * 1000;
		if( value < 1000000 )
			return Math.round(value / 10000) * 10000;
		return Math.round(value / 100000) * 100000;
	}
	
	static public function floor(value:Dynamic) : Int
	{
		if( value < 100 )
			return Math.floor(value);
		if( value < 1000 )
			return Math.floor(value / 10) * 10;
		if( value < 10000 )
			return Math.floor(value / 100) * 100;
		if( value < 100000 )
			return Math.floor(value / 1000) * 1000;
		if( value < 1000000 )
			return Math.floor(value / 10000) * 10000;
		return Math.floor(value / 100000) * 100000;
	}
	
	static public function clamp(value:Float, min:Float, max:Float) : Float
	{
		return Math.min(max, Math.max(min, value));
	}
	
	static public function getDistance(sx:Float, sy:Float, dx:Float, dy:Float) : Float
	{
		return Math.sqrt(Math.pow(sx - dx, 2) + Math.pow((sy - dy) * 1.4285, 2) );
	}
	static public function getNormalDistance(sx:Float, sy:Float, dx:Float, dy:Float) : Float
	{
		return Math.sqrt(Math.pow(sx - dx, 2) + Math.pow((sy - dy), 2) );
	}
	
	static var GAP:Float = 40;
	static public function getXPosition(max:Int, i:Int, x:Float) : Float
	{
		if( max == 2 )
		{
			return switch ( i )
			{
				case 0: x - GAP;
				case 1: x + GAP;
				default : x;
			}
		}
		if( max == 3 )
		{
			return switch ( i )
			{
				case 0: x;
				case 1: x - GAP;
				case 2: x + GAP;
				default : x;
			}
		}
		if( max == 4 )
		{
			return switch ( i )
			{
				case 0: x - GAP;
				case 1: x + GAP;
				case 2: x - GAP;
				case 3: x + GAP;
				default : x;
			}
		}
		if( max == 6 )
		{
			return switch ( i )
			{
				case 0: x;
				case 1: x - GAP;
				case 2: x + GAP;
				case 3: x;
				case 4: x + (GAP * 2.0);
				case 5: x - (GAP * 2.0);
				default : x;
			}
		}
		return x;
	}
	
	static public function getYPosition(max:Int, i:Int, y:Float) : Float
	{
		if( max == 2 )
		{
			return switch ( i )
			{
				case 0: y;
				case 1: y;
				default : y;
			}
		}
		if( max == 3 )
		{
			return switch ( i )
			{
				case 0: y - GAP;
				case 1: y + GAP;	
				case 2: y + GAP;
				default : y;
			}
		}
		if( max == 4 )
		{
			return switch ( i )
			{
				case 0: y + GAP;
				case 1: y + GAP;	
				case 2: y - GAP;
				case 3: y - GAP;
				default : y;
			}
		}
		if( max == 6 )
		{
			return switch ( i )
			{
				case 0: y;
				case 1: y + GAP;
				case 2: y + GAP;
				case 3: y + (GAP * 2.0);
				case 4: y + (GAP * 2.0);
				case 5: y + (GAP * 2.0);
				default : y;
			}
		}
		return y;
	}
	
	static public function getRadString(rad:Float) : String
	{
		if( rad >= Math.PI * -0.125 && rad < Math.PI * 0.125 )
			return "000";
		if( rad <= Math.PI * -0.125 && rad > Math.PI * -0.375 )
			return "-45";
		if( rad <= Math.PI * -0.375 && rad > Math.PI * -0.625 )
			return "-90";
		if( rad <= Math.PI * -0.625 && rad > Math.PI * -0.875 )
			return "-35";
		if( rad >= Math.PI * 0.125 && rad < Math.PI * 0.375 )
			return "045";
		if( rad >= Math.PI * 0.375 && rad < Math.PI * 0.625 )
			return "090";
		if( rad >= Math.PI * 0.625 && rad < Math.PI * 0.875 )
			return "135";
		return "180";
	}
	
	static public function fix(input:Float, num:Int = 2) : Float
	{
		var x = Math.pow(10, num);
		return Math.round( input * x ) / x;
	}
	
	static function getTimer() : Int64
	{
	#if java
		return java.lang.System.currentTimeMillis();
	#elseif flash
		return flash.Lib.getTimer();
	#end
	}

}