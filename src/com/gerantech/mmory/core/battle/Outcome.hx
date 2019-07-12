package com.gerantech.mmory.core.battle;


import com.gerantech.mmory.core.exchanges.ExchangeItem;
import com.gerantech.mmory.core.scripts.ScriptEngine;
import com.gerantech.mmory.core.constants.ExchangeType;
import com.gerantech.mmory.core.others.Arena;
import com.gerantech.mmory.core.utils.maps.IntIntMap;
import com.gerantech.mmory.core.constants.ResourceType;

/**
 * Created by ManJav on 2/13/2018.
 */
class Outcome
{
#if java
	static var MIN_POINTS:Int = 2;
	static var COE_POINTS:Int = 2;

	static public function get(game:Game, type:Int, mode:Int, friendlyMode:Int, stars:Int, ratio:Float, now:Int) : IntIntMap
  	{
		var ret = new IntIntMap();
		if( friendlyMode > 0 )
    	{
			ret.set(ResourceType.R15_BATTLES_FRIENDLY, 1);
			return ret;
		}
		var league = game.arenas.get(game.player.get_arena(0));

		// points
		var point = getPoint(type, stars, league.index, ratio);
		trace("mode:" + mode + " type:" + type + " point:" + point);

		if( game.player.isBot() )
			return ret;

		// battle stats
		ret.set(ResourceType.R12_BATTLES, 1);
		ret.set(ResourceType.R16_WIN_RATE, getWinRate(game, league, stars, ratio));
		if( league.index > 0 )
			ret.set(ResourceType.R17_STARS, stars);

		if( ratio > 1 )
		{
			// num wins
			ret.set(ResourceType.R13_BATTLES_WINS, 1);
			ret.set(ResourceType.R30_CHALLENGES, mode + 1);

			// soft-currency
			var sc = Math.max(0, stars) + Math.min(league.index * 2, Math.max(0, game.player.get_point() - game.player.get_softs())) * mode;
			var softs:Int = 2 * cast(sc, Int);
			if( softs != 0 )
				ret.set(ResourceType.R3_CURRENCY_SOFT, softs);

			/*int dailyBattles = game.exchanger.items.exists(ExchangeType.C29_DAILY_BATTLES) ? game.exchanger.items.get(ExchangeType.C29_DAILY_BATTLES).numExchanges : 0;
				if( mode == 0 && dailyBattles > 10 )
				{
					point = (int) (point * Math.pow(10f / dailyBattles, 0.2));
					soft = (int) (soft * Math.pow(10f / dailyBattles, 0.8));
			}*/
			ret.set(ResourceType.R3_CURRENCY_SOFT, softs);

			// random book
			var emptySlotsType = getEmptySlots(game, now);
			if( emptySlotsType.length > 0 )
			{
				var randomEmptySlotIndex = game.player.get_battleswins() == 0 ? 0 : Math.floor(Math.random() * emptySlotsType.length);
				var emptySlot = game.exchanger.items.get(emptySlotsType[randomEmptySlotIndex]);
				game.exchanger.findRandomOutcome(emptySlot, now);
				ret.set(emptySlot.outcome, emptySlot.type);
			}
		}
		if( point != 0 )
			ret.set(ResourceType.R2_POINT, point);
		return ret;
	}

	static function getPoint(type:Int, stars:Int, league:Int, ratio:Float) : Int
	{
		if( league == 0 )
			return ratio > 1 ? 1 : 0;
		var challengeCoef:Float = ScriptEngine.get(ScriptEngine.T48_CHALLENGE_REWARDCOEF, type);
		return Math.round((MIN_POINTS + stars * COE_POINTS) * challengeCoef * (ratio > 1 ? 1 : -1));
	}
	
  static function getWinRate(game:Game, league:Arena, stars:Int, ratio:Float) : Int
  {
		var ret = stars > 0 ? 1 : -1;
		if( league.index == 0 )
			return ret;
		var winRate = game.player.getResource(ResourceType.R16_WIN_RATE);
		if( ratio > 1 && ret < 0 )
			ret *= stars;
		if( ret < 0 && winRate < league.minWinRate )
			ret = 0;
		return ret;
	}

	static  function getEmptySlots(game:Game, now:Int) : Array<Int>
  {
		var ret = new Array<Int>();
    var i = 0;
    var k = 0;
		var keys = game.exchanger.items.keys();
    while( i < keys.length )
    {
      k = keys[i];
      if (game.exchanger.items.get(k).category == ExchangeType.C110_BATTLES 	&& game.exchanger.items.get(k).getState(now) == ExchangeItem.CHEST_STATE_EMPTY)
        ret.push(game.exchanger.items.get(k).type);
      i ++;
    }
		return ret;
	}
#end
}
