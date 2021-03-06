package com.gerantech.mmory.core.exchanges;

import com.gerantech.mmory.core.Game;
import com.gerantech.mmory.core.battle.units.Card;
import com.gerantech.mmory.core.constants.CardTypes;
import com.gerantech.mmory.core.constants.ExchangeType;
import com.gerantech.mmory.core.constants.MessageTypes;
import com.gerantech.mmory.core.constants.ResourceType;
import com.gerantech.mmory.core.exchanges.ExchangeItem;
import com.gerantech.mmory.core.scripts.ScriptEngine;
import com.gerantech.mmory.core.utils.maps.IntIntMap;
import com.gerantech.mmory.core.utils.maps.IntShopMap;
/**
 * ...
 * @author Mansour Djawadi
 */
#if flash
import com.gerantech.mmory.core.events.ExchangeEvent;
class Exchanger extends flash.events.EventDispatcher
{
#elseif java
class Exchanger 
{
#end
	var game:Game;
	public var items:IntShopMap;
#if java
	public var updater:ExchangeUpdater;
#end

	public function new(game:Game) 
	{
		#if flash
		super();
		#end
		this.game = game;
		items = new IntShopMap();
	}
	
	/**
	 * 
	 * @param	item
	 * @param	now
	 * @param	confirmedHards
	 * @return response (MessageTypes)
	 */
	public function exchange (item:ExchangeItem, now:Int, confirmedHards:Int=0):Int
	{
		if( item.category == ExchangeType.C20_SPECIALS && item.numExchanges > 0 )
			return MessageTypes.RESPONSE_NOT_ALLOWED;
		if( item.type == ExchangeType.C104_STARS && item.numExchanges < 10 )
			return MessageTypes.RESPONSE_NOT_ALLOWED;
		if( item.category == ExchangeType.C100_FREES )
			findRandomOutcome(item, now);
		else if( item.category == ResourceType.R30_CHALLENGE_NUMS )
			item.outcomes.set(item.type, 1);
		// provide requirements
		item.requirements = getRequierement(item, now);
		trace("item: " + item.toString());
		// start opening process
		if( item.category == ExchangeType.C110_BATTLES && item.getState(now) == ExchangeItem.CHEST_STATE_WAIT )
		{
			var res = isBattleBookReady(item.type, now);
			if( res == MessageTypes.RESPONSE_SUCCEED || res == MessageTypes.RESPONSE_ALREADY_SENT )
			{
				item.expiredAt = now + ScriptEngine.getInt(ScriptEngine.T91_PACK_DELAY, item.outcome);
				if( res == MessageTypes.RESPONSE_ALREADY_SENT )
				{
					item.requirements = new IntIntMap();
					item.requirements.set(ResourceType.R4_CURRENCY_HARD, timeToHard(item.expiredAt - now) );
					if( !game.player.has(item.requirements) )
					{
						item.expiredAt = 0;
						return MessageTypes.RESPONSE_NOT_ENOUGH_REQS;
					}
					return exchange(item, now, confirmedHards);
				}
				game.player.resources.reduceMap(item.requirements);
				item.requirements = new IntIntMap();
				return res;
			}
			return res;
		}
		
		var deductions = game.player.deductions(item.requirements);
		var needsHard = toHard(deductions);
		trace("confirmedHards:" + confirmedHards + " needsHard:" + needsHard + " deductions:" + deductions.toString() + " reqs:" + item.requirements.toString() + " outs:" + item.outcomes.toString());
		if( !game.player.has(item.requirements) && needsHard > confirmedHards )
			return MessageTypes.RESPONSE_NOT_ENOUGH_REQS;
		
		// provide reqs by hard
		if( confirmedHards > 0 )
		{
			game.player.resources.reduce(ResourceType.R4_CURRENCY_HARD, needsHard);
			game.player.addResources(deductions);
		}
		
		var outs = new IntIntMap();
		outs.increaseMap(item.outcomes);
#if java
		var outKeys = outs.keys();
		var o = 0;
		while ( o < outKeys.length )
		{
			if( ResourceType.isBook( outKeys[o] ) )
			{
				// trace("book", outKeys[o]);
				outs.increaseMap( getBookOutcomes( outKeys[o], outs.get(outKeys[o]), item.category == ExchangeType.C100_FREES ) );
				outs.remove( outKeys[o] );
			}
			o ++;
		}
		trace("outcomes: " + outs.toString());
#end
		
		// add outcomes
#if flash
		if( item.containBook() == -1 )// prevent adding outcomes witch contain book into player resources in client-side
#end
		game.player.addResources(outs);
		
		// consume reqs
		game.player.resources.reduceMap(item.requirements);

#if flash
		dispatchEvent(new com.gerantech.mmory.core.events.ExchangeEvent("complete", item));
#end
		
		// reset item
		var cooldown = ScriptEngine.getInt(ScriptEngine.T91_PACK_DELAY, item.type);
		if( item.category == ExchangeType.C100_FREES )
		{
			game.player.resources.increase(ResourceType.R22_BOOK_OPENED_FREE, 1);
			if( item.type == ExchangeType.C104_STARS )
				item.numExchanges = 0;
			else
				item.numExchanges = item.expiredAt < now ? 1 : item.numExchanges + 1;
			
			if( item.type == ExchangeType.C104_STARS )
				item.expiredAt = Math.round(Math.max(now, item.expiredAt + cooldown));
			else
				item.expiredAt = now + cooldown;
			
			item.outcome = 0;
			item.outcomes = new IntIntMap();
			item.requirements = new IntIntMap();
		}
		else if( item.category == ExchangeType.C110_BATTLES )
		{
			game.player.resources.increase(ResourceType.R21_BOOK_OPENED_BATTLE, 1);
			item.outcome = item.expiredAt = 0;
			item.outcomes = new IntIntMap();
			item.requirements = new IntIntMap();
		}
		else if( item.category == ExchangeType.C20_SPECIALS || item.category == ExchangeType.C30_BUNDLES || item.isIncreamental() )
		{
			if( item.type == ExchangeType.C43_ADS )
				item.expiredAt = now + cooldown;
			item.numExchanges ++;
		}
		
		item.createMapsStr();
		return MessageTypes.RESPONSE_SUCCEED;
	}

	public function findRandomOutcome(item:ExchangeItem, now:Int) : Void
	{
		var bookIndex = item.category == ExchangeType.C100_FREES ? game.player.getResource(ResourceType.R22_BOOK_OPENED_FREE) : getEarnedBattleBooks(now);
		item.outcome = ScriptEngine.getInt(item.category == ExchangeType.C100_FREES ? ScriptEngine.T97_PACK_FREE_TYPE : ScriptEngine.T98_PACK_BATTLE_TYPE, bookIndex);
		item.outcomes = new IntIntMap();
		item.outcomes.set(item.outcome, game.player.get_arena(0));
	}

	public function findItem(category:Int, state:Int, now:Int, exception:Int = -1) : ExchangeItem
	{
		var keys = items.keys();
		var i = keys.length - 1;
		var item:ExchangeItem;
		while ( i >= 0 )
		{
			item = items.get(keys[i]);
			// trace(item.category + " " + category + "   " + item.getState(now) + " " + state + "   " + item.type + " " + exception);
			if( item.category == category && item.getState(now) == state && item.type != exception )
				return items.get(keys[i]);
			i --;
		}
		return null;
	}
	
	public function isBattleBookReady(type:Int, now:Int) : Int
	{
		var item = items.get(type);
		if( item.category != ExchangeType.C110_BATTLES && item.getState(now) != ExchangeItem.CHEST_STATE_WAIT )
			return MessageTypes.RESPONSE_NOT_ALLOWED;
		
		if( item.category == ExchangeType.C110_BATTLES )
		{
			// check another slot is in process
			var busyBook = findItem(ExchangeType.C110_BATTLES, ExchangeItem.CHEST_STATE_BUSY, now, item.type);
			if( busyBook != null )
				return MessageTypes.RESPONSE_ALREADY_SENT;
			
			// not enough requierements
			if( item.getState(now) == ExchangeItem.CHEST_STATE_BUSY && game.player.get_hards() < timeToHard(item.expiredAt - now) )
				return MessageTypes.RESPONSE_NOT_ENOUGH_REQS;
		}
		else if( item.category == ExchangeType.C120_MAGICS )
		{
			if( !game.player.has(item.requirements) )
				return MessageTypes.RESPONSE_NOT_ENOUGH_REQS;
		}
		return MessageTypes.RESPONSE_SUCCEED;
	}
	
	static public function toReal(map:IntIntMap) : Int
	{
		return hardToReal(toHard(map));
	}
	
	static public function toHard(map:IntIntMap) : Int
	{
		var reqKeys = map.keys();
		var softs = 0;
		var hards = 0;
		var tickets = 0;
		var reals = 0;
		var i = 0;
		while ( i < reqKeys.length )
		{
			if( reqKeys[i] == ResourceType.R5_CURRENCY_REAL )
				reals += map.get(reqKeys[i]);
			else if( reqKeys[i] == ResourceType.R4_CURRENCY_HARD )
				hards += map.get(reqKeys[i]);
			else if( reqKeys[i] == ResourceType.R6_TICKET )
				tickets += map.get(reqKeys[i]);
			else if( reqKeys[i] == ResourceType.R3_CURRENCY_SOFT )
				softs += map.get(reqKeys[i]);
			else if( ResourceType.isCard(reqKeys[i])) 
				softs += cardToSoft(map.get(reqKeys[i]), ScriptEngine.getInt(ScriptEngine.T00_RARITY, reqKeys[i]));
			else if( ResourceType.isBook(reqKeys[i]))
				hards += toHard(estimateBookOutcome(reqKeys[i], map.get(reqKeys[i]), 1));
			i ++;
		}
		//trace("tickets " + tickets + " => " + ticketToHard(tickets));
		return softToHard(softs) + realToHard(reals) + ticketToHard(tickets) + hards ;
	}
	
	static public function toSoft(map:IntIntMap) : Int
	{
		var reqKeys = map.keys();
		var softs = 0;
		var hards = 0;
		var reals = 0;
		var i = 0;
		while ( i < reqKeys.length )
		{
			if( reqKeys[i] == ResourceType.R5_CURRENCY_REAL )
				reals += map.get(reqKeys[i]);
			else if( reqKeys[i] == ResourceType.R4_CURRENCY_HARD )
				hards += map.get(reqKeys[i]);
			else if( reqKeys[i] == ResourceType.R3_CURRENCY_SOFT )
				softs += map.get(reqKeys[i]);
			else if( ResourceType.isCard(reqKeys[i]) ) 
				softs += cardToSoft(map.get(reqKeys[i]), ScriptEngine.getInt(ScriptEngine.T00_RARITY, reqKeys[i]));
			
			i ++;
		}
		return hardToSoft( realToHard(reals) + hards ) + softs ;
	}
	
	
	static function ticketToHard(count:Int):Int
	{
		return count * 2;
	}
	static public function hardToTicket(count:Int):Int
	{
		return Math.ceil(count * 0.5);
	}
	static function realToTicket(count:Int):Int
	{
		return Math.ceil( count * 0.01 );
	}
	static public function realToHard(count:Int):Int
	{
		return Math.ceil( count * 0.04 );
	}
	static public function hardToReal(count:Int):Int
	{
		return Math.ceil( count / 0.04 );
	}
	static public function softToHard(count:Int):Int
	{
		return Math.ceil( count * 0.05 );
	}
	static public function hardToSoft(count:Int):Int
	{
		return Math.ceil( count / 0.05 );
	}
	static public function timeToHard(count:Int):Int
	{
		return Math.ceil( count / 600 );
	}
	static public function cardToSoft(count:Int, rarity:Int) : Int
	{
		return count * Card.PRICE[rarity]; 
	}
	static public function fixedRound(count:Int) : Int
	{
		if( count < 1000 )
			return 10 * Math.round(count * 0.1);
		else if( count < 10000 )
			return 100 * Math.round(count * 0.01);
		else
			return 1000 * Math.round(count * 0.001);
	}
	
	public function collectStars(stars:Int, now:Int) : Int
	{
		var item = items.get(ExchangeType.C104_STARS);
		if( item.expiredAt > now )
			return MessageTypes.RESPONSE_MUST_WAIT;
		if( item.numExchanges >= 10 )
			return MessageTypes.RESPONSE_ALREADY_SENT;
		item.numExchanges = Math.floor(Math.min(10, item.numExchanges + stars));
		return MessageTypes.RESPONSE_SUCCEED;
	}
	
	public function getEarnedBattleBooks(now:Int) : Int
	{
		var i = 0;
		var numClosed = 0;
		var keys = items.keys();
		while ( i < keys.length )
		{
			if( items.get(keys[i]).category == ExchangeType.C110_BATTLES && items.get(keys[i]).getState(now) != ExchangeItem.CHEST_STATE_EMPTY )
				numClosed ++;
			i ++;
		}
		return game.player.getResource(ResourceType.R21_BOOK_OPENED_BATTLE) + numClosed;
	}
	
	static public function estimateBookOutcome(type:Int, arena:Int, id:Int) : IntIntMap
	{
		var cards = ScriptEngine.getInt(ScriptEngine.T93_PACK_CARDS, type, arena, 0, id);
		var ret = new IntIntMap();
		ret.set(CardTypes.C101, cards);
		ret.set(ResourceType.R4_CURRENCY_HARD, ScriptEngine.getInt(ScriptEngine.T94_PACK_SOFTS, cards));
		ret.set(ResourceType.R4_CURRENCY_HARD, ScriptEngine.getInt(ScriptEngine.T95_PACK_HARDS, type));
		return ret;
	}
	
	function getRequierement(item:ExchangeItem, now:Int) : IntIntMap
	{
		//if( item.category < ExchangeType.C40_OTHERS && (item.requirements != null && item.requirements.keys().length > 0) )
		//	return item.requirements;
		
		var ret = new IntIntMap();
		if( item.type == ExchangeType.C42_RENAME )
		{
			ret.set(ResourceType.R4_CURRENCY_HARD, 20 * item.numExchanges);
		}
		else if( item.category == ExchangeType.C110_BATTLES )
		{
			if( item.getState(now) == ExchangeItem.CHEST_STATE_BUSY )
				ret.set(ResourceType.R4_CURRENCY_HARD, timeToHard(item.expiredAt - now) );
			//else if( item.getState(now) == ExchangeItem.CHEST_STATE_WAIT )
			//	ret.set(ResourceType.KEY, ExchangeType.getKeyRequierement(item.outcome));
		}
		else if( ( item.type == ExchangeType.C43_ADS || item.category == ExchangeType.C100_FREES ) && item.expiredAt > now )
		{
			ret.set(ResourceType.R4_CURRENCY_HARD, timeToHard(item.expiredAt - now) * item.numExchanges);
		}
		if( ret.keys().length == 0 )
			return item.requirements;
		
		return ret;
	}
	
	#if java
	function getBookOutcomes(type:Int, arena:Int, isDaily:Bool = false) : IntIntMap
	{
		var ret = new IntIntMap();
		var numSlots = ScriptEngine.getInt(ScriptEngine.T92_PACK_SLOTS, type);
		var numRares = ScriptEngine.getInt(ScriptEngine.T93_PACK_CARDS, type, arena, 1, game.player.id);
		var numEpics = ScriptEngine.getInt(ScriptEngine.T93_PACK_CARDS, type, arena, 2, game.player.id);
		var totalCards = ScriptEngine.getInt(ScriptEngine.T93_PACK_CARDS, type, arena, 0, game.player.id);
		var numCommons = totalCards - numRares - numEpics;
		var opened = game.player.getResource(ResourceType.R21_BOOK_OPENED_BATTLE);
		// trace("type:" + type + " opened:" + opened + " numSlots:" + numSlots + " numRares:" + numRares + " numEpics:" + numEpics + " totalCards:" + totalCards);
		var numCards:Int = 0;
		var rarity:Int;
		while( numSlots > 0 )
		{
			if( opened == 0 )
			{
				ret.set(CardTypes.INITIAL, 1);
				break;
			}
			
			if( numEpics > 0 )
			{
				rarity = 2;
				numCards = numEpics;
				numEpics = 0;
			}
			else if( numRares > 0 )
			{
				rarity = 1;
				numCards = numRares;
				numRares = 0;
			}
			else
			{
				rarity = 0;
				numCards = numSlots > 1 ? Math.ceil(numCommons / numSlots) : numCommons;
				numCommons -= numCards;
			}

			// trace("addNewCard => numSlots:" + numSlots + " rarity:" + rarity + " isDaily:" + isDaily + " numCards:" + numCards + " numCommons:" + numCommons);
			this.addRandomSlot(ret, numCards, rarity);
			numSlots --;
		}	
		
		// hards
		if( isDaily )
			ret.set(ResourceType.R4_CURRENCY_HARD, ScriptEngine.getInt(ScriptEngine.T95_PACK_HARDS, type));
		
		// softs
		var softDec = ScriptEngine.getInt(ScriptEngine.T94_PACK_SOFTS, totalCards) * 0.1;
		ret.set(ResourceType.R3_CURRENCY_SOFT, Math.floor(softDec * 9 + Math.random() * softDec * 2));
		
		return ret;
	}

	function addRandomSlot(map:IntIntMap, count:Int, rarity:Int) : Void
	{
		if( game.player.cards.keys().length <= map.keys().length )
			return;
		var random = game.player.getRandomCard(rarity);
		if( random == -1 )
		{
			if( rarity > 0 )
				addRandomSlot(map, count, rarity - 1);
			return;
		}
		
		if( map.exists(random) )
		{
			addRandomSlot(map, count, Std.int(Math.max(0, rarity - 1)));
			return;
		}
		
		map.set(random, count);
	}
	#end
}