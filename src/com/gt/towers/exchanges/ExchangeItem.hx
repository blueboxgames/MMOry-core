package com.gt.towers.exchanges;
import com.gt.towers.constants.ExchangeType;
import com.gt.towers.constants.ResourceType;
import com.gt.towers.utils.maps.IntIntMap;

/**
 * ...
 * @author Mansour Djawadi
 */
class ExchangeItem
{
	public var type:Int;
	public var numExchanges:Int;
	public var expiredAt:Int;
	public var outcome:Int;
	public var outcomes:IntIntMap;
	public var outcomesStr:String;
	public var category:Int;
	public var bonus:Int = 0;
	public var discount:Float = 1;
	public var enabled:Bool = true;
	public var requirements:IntIntMap;
	public var requirementsStr:String;

	public function new(type:Int, numExchanges:Int = 1, expiredAt:Int = 0, reqsStr:String = "", outsStr:String = "") 
	{
		this.type = type;
		this.numExchanges = numExchanges;
		this.expiredAt = expiredAt;
		this.outcome = Std.parseInt(outsStr.split(":")[0]);
		this.outcomesStr = outsStr;
		this.requirementsStr = reqsStr;
		this.category = ExchangeType.getCategory(type);
		this.requirements = new IntIntMap(reqsStr);
		this.outcomes = new IntIntMap(outsStr);
	}
	
	public static var CHEST_STATE_EMPTY:Int = -1;
	public static var CHEST_STATE_WAIT:Int = 0;
	public static var CHEST_STATE_BUSY:Int = 1;
	public static var CHEST_STATE_READY:Int = 2;
	public function getState(now:Int):Int
	{
		if( type == ExchangeType.C104_STARS )
		{
			if( expiredAt > now )
				return CHEST_STATE_BUSY;
			return numExchanges >= 10 ? CHEST_STATE_READY : CHEST_STATE_WAIT;
		}
		
		if( outcome == 0 && category == ExchangeType.C110_BATTLES )
			return CHEST_STATE_EMPTY;
		else if( expiredAt == 0 )
			return CHEST_STATE_WAIT;
		else if( expiredAt > now )
			return CHEST_STATE_BUSY;
		return CHEST_STATE_READY;
	}

	public function isBook():Bool
	{
		return category >= 100 && category < 130;
	}
	
	public function isIncreamental() 
	{
		return type == ExchangeType.C42_RENAME || type == ExchangeType.C43_ADS;
	}
	
	public function containBook() : Int
	{
		var outs = outcomes.keys();
		var step = outs.length - 1;
		while ( step >= 0 )
		{
			if( ResourceType.isBook( outs[step] ) )
				return outs[step];
			step --;
		}
		return -1;
	}
	
	public function createMapsStr() : Void
	{
		outcomesStr = outcomes.toString();
		requirementsStr = requirements.toString();
	}
	
}