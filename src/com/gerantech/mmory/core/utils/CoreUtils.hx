package com.gerantech.mmory.core.utils;
import com.gerantech.mmory.core.battle.BattleField;
import haxe.Int64;

/**
 * ...
 * @author Mansour Djawadi ...
 */
class CoreUtils 
{
	public function new(){}
	static public function round(value:Float) : Int
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
	
	static public function getDistance(x1:Float, y1:Float, x2:Float, y2:Float) : Float
	{
		return Math.sqrt((x1 - x2) * (x1 - x2) + ((y1 - y2) / BattleField.CAMERA_ANGLE) * ((y1 - y2) / BattleField.CAMERA_ANGLE) );
	}
	static public function getNormalDistance(x1:Float, y1:Float, x2:Float, y2:Float) : Float
	{
		return Math.sqrt( (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) );
	}
	
	static var GAP:Float = 40;
	static public function getXPosition(max:Int, i:Int, x:Float) : Float
	{
		if( max == 1 )
			return x;
		if( max == 2 )
		{
			return switch ( i )
			{
				case 0: x - GAP;
				case 1: x + GAP;
				default : x;
			}
		}
		if( max <= 3 )
		{
			return switch ( i )
			{
				case 0: x;
				case 1: x - GAP;
				case 2: x + GAP;
				default : x;
			}
		}
		if( max <= 4 )
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
		if( max <= 6 )
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

	    if( max <= 12 )
        {
            return switch ( i )
			{
				case 0: x;
				case 1: x - (GAP * 1.8);
				case 2: x - (GAP * 3.2);
				case 3: x + (GAP * 1.8);
				case 4: x;
				case 5: x;
				case 6: x;
				case 7: x - (GAP * 1.5);
				case 8: x - (GAP * 1.3);
				case 9: x - (GAP * 1.7);
				case 10: x - (GAP * 3.1);
				case 11: x + (GAP * 1.6);
				default : x;
			}
        }

		return x;
	}
	
	static public function getYPosition(max:Int, i:Int, y:Float) : Float
	{
		if( max == 1 )
			return y;
		if( max == 2 )
		{
			return switch ( i )
			{
				case 0: y;
				case 1: y;
				default : y;
			}
		}
		if( max <= 3 )
		{
			return switch ( i )
			{
				case 0: y - GAP;
				case 1: y + GAP;	
				case 2: y + GAP;
				default : y;
			}
		}
		if( max <= 4 )
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
		if( max <= 6 )
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
		if( max <= 12 )
		{
			return switch ( i )
			{
				case 0: y;
				case 1: y;
				case 2: y;
				case 3: y;
				case 4: y + (GAP * 1.5);
				case 5: y - (GAP * 1.1);
				case 6: y - (GAP * 1.3);
				case 7: y + (GAP * 1.9);
				case 8: y - (GAP * 1.6);
				case 9: y - (GAP * 1.4);
				case 10: y - (GAP * 1.3);
				case 11: y - (GAP * 1.7);
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
	
	static public function fix(input:Float, precision:Int = 2) : Float
	{
		return Math.round( input * Math.pow(10, precision) ) / Math.pow(10, precision);
	}
	
	static public function getTimer() : Int64
	{
	#if java
		return java.lang.System.currentTimeMillis();
	#elseif flash
		return flash.Lib.getTimer();
	#end
	}

}