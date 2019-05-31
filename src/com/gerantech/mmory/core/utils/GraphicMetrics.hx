package com.gerantech.mmory.core.utils;
import com.gerantech.mmory.core.utils.Point3;
/**
 * ...
 * @author Mansour Djawadi
 */
class GraphicMetrics
{
	public function new () { }
	static public function getSpellStartPoint(type:Int) : Point3 
	{
		var x:Float = switch( type )
		{
			default : 		0;
		}
		
		var y:Float = switch( type )
		{
			case	152	:	 1000;
			default : 		 0;
		}
		
		var z:Float = switch( type )
		{
			case	151	:	-1000;
			default : 		 0;
		}
		var ret =  new Point3(x, y, z);
		//trace("type:" + type + " rotation:" + rotation + " ret:" + ret);
		return ret;
	}
}