package com.gerantech.mmory.core.constants;

/**
 * ...
 * @author Mansour Djawadi
 */
class CardFeatureType 
{
	public function new() {}
	
#if flash
	private static var _all:com.gerantech.mmory.core.utils.lists.IntList;
	static public function getAll():com.gerantech.mmory.core.utils.lists.IntList
	{
		if( _all == null )
		{
			_all = new com.gerantech.mmory.core.utils.lists.IntList();
			
			_all.push( F03_QUANTITY );
			
			_all.push( F11_SPEED );
			_all.push( F12_HEALTH );
			_all.push( F13_SIZE_H );
			_all.push( F14_SIZE_V );
			
			_all.push( F22_BULLET_DAMAGE );
			_all.push( F23_BULLET_SHOOT_GAP );
			_all.push( F24_BULLET_SHOOT_DELAY );
			_all.push( F25_BULLET_RANGE_MIN );
			_all.push( F26_BULLET_RANGE_MAX );
			_all.push( F27_BULLET_DAMAGE_AREA );
			_all.push( F28_BULLET_EXPLODE_DElAY );
		}
		return _all;
	}
	
	static public function getRelatedTo(cardType:Int):com.gerantech.mmory.core.utils.lists.IntList
	{
		var ret = new com.gerantech.mmory.core.utils.lists.IntList();
		ret.push( F22_BULLET_DAMAGE );
		if( CardTypes.isSpell(cardType ) )
			return ret;
		ret.push( F23_BULLET_SHOOT_GAP );
		ret.push( F04_SUMMON_TIME );
		ret.push( F11_SPEED );
		ret.push( F12_HEALTH );
		ret.push( F26_BULLET_RANGE_MAX );
		return ret;
	}
	
	static public function getUIFactor(featureType:Int) : Float
	{
		return switch( featureType )
		{
			/*case 5 : 1000;
			case 12: 50;
			case 21: 50;
			case 23: 0.2;
			case 24: 0.2;*/
			case 4:	 0.001;
			case 11: 1000;
			case 12: 50;
			case 22: 100;
			case 23: 0.01;
			case 26: 0.5;
			default: 1;
		}
	}
	
	/*static public function getChangables(game:Game, type:Int, level:Int):com.gerantech.mmory.core.utils.lists.IntList
	{
		var ret = new com.gerantech.mmory.core.utils.lists.IntList();
		var all = getAll();
		var i = 0;
		while ( i < all.size() )
		{
			if ( game.calculator.get(all.get(i), type, level) != game.calculator.get(all.get(i), type, level + 1) )
				ret.push(all.get(i));
			i ++;
		}
		return ret;
	}*/
#end
}