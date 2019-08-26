package com.gerantech.mmory.core.exchanges;
import com.gerantech.mmory.core.Game;
import com.gerantech.mmory.core.constants.ExchangeType;
import com.gerantech.mmory.core.constants.ResourceType;
import com.gerantech.mmory.core.exchanges.ExchangeItem;
import com.gerantech.mmory.core.scripts.ScriptEngine;
import com.gerantech.mmory.core.socials.Challenge;
import com.gerantech.mmory.core.utils.maps.IntIntMap;

/**
 * ...
 * @author Mansour Djawadi
 */
class ExchangeUpdater 
{
	var now:Int;
	var expireTime:Int;
	var arena:Int;
	var game:Game;
	public var changes:java.util.List<ExchangeItem>;

	public function new(game:Game, now:Int) 
	{
		this.game = game;
		this.arena = game.player.get_arena(0);
		this.changes = new java.util.ArrayList();
		this.now = now;
		this.expireTime = this.getExpireTime();
	}

	function addItems() : Void
	{
		// _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_- GEM -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
		this.add(ExchangeType.C0_HARD, 0, 0, ResourceType.R5_CURRENCY_REAL + ":1",			ResourceType.R4_CURRENCY_HARD + ":1");
		this.add(ExchangeType.C1_HARD, 0, 0, ResourceType.R5_CURRENCY_REAL + ":2000",		ResourceType.R4_CURRENCY_HARD + ":" + Exchanger.realToHard(2000)		* 0.750);
		this.add(ExchangeType.C2_HARD, 0, 0, ResourceType.R5_CURRENCY_REAL + ":10000",	ResourceType.R4_CURRENCY_HARD + ":" + Exchanger.realToHard(10000)		* 0.875);
		this.add(ExchangeType.C3_HARD, 0, 0, ResourceType.R5_CURRENCY_REAL + ":20000",	ResourceType.R4_CURRENCY_HARD + ":" + Exchanger.realToHard(20000)		* 1.000);
		this.add(ExchangeType.C4_HARD, 0, 0, ResourceType.R5_CURRENCY_REAL + ":40000",	ResourceType.R4_CURRENCY_HARD + ":" + Exchanger.realToHard(40000)		* 1.125);
		this.add(ExchangeType.C5_HARD, 0, 0, ResourceType.R5_CURRENCY_REAL + ":100000",	ResourceType.R4_CURRENCY_HARD + ":" + Exchanger.realToHard(100000)	* 1.200);
		this.add(ExchangeType.C6_HARD, 0, 0, ResourceType.R5_CURRENCY_REAL + ":200000",	ResourceType.R4_CURRENCY_HARD + ":" + Exchanger.realToHard(200000)	* 1.250);

		// _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_- MONEY -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
		this.add(ExchangeType.C11_SOFT, 0, 0, ResourceType.R4_CURRENCY_HARD + ":" + Exchanger.softToHard(1000) * 1.2, 	ResourceType.R3_CURRENCY_SOFT + ":1000");
		this.add(ExchangeType.C12_SOFT, 0, 0, ResourceType.R4_CURRENCY_HARD + ":" + Exchanger.softToHard(5000) * 1.0, 	ResourceType.R3_CURRENCY_SOFT + ":5000");
		this.add(ExchangeType.C13_SOFT, 0, 0, ResourceType.R4_CURRENCY_HARD + ":" + Exchanger.softToHard(50000) * 0.9,	ResourceType.R3_CURRENCY_SOFT + ":50000");

		// -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_- TICKETS -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
		this.add(ExchangeType.C71_TICKET, 0, 0, ResourceType.R4_CURRENCY_HARD + ":0",		ResourceType.R6_TICKET		+ ":1");
		this.add(ExchangeType.C72_TICKET, 0, 0, ResourceType.R4_CURRENCY_HARD + ":50",	ResourceType.R6_TICKET		+ ":" + Exchanger.hardToTicket(50)    	* 1.20);
		this.add(ExchangeType.C73_TICKET, 0, 0, ResourceType.R4_CURRENCY_HARD + ":100",	ResourceType.R6_TICKET		+ ":" + Exchanger.hardToTicket(100)    	* 1.40);

		// -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_- EMOTES -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
		/*
		this.add(ExchangeType.C81_EMOTE, 0, 0, ResourceType.R5_CURRENCY_REAL + ":1000",	"0:1");
		this.add(ExchangeType.C82_EMOTE, 0, 0, ResourceType.R5_CURRENCY_REAL + ":1000",	"1:1");
		this.add(ExchangeType.C83_EMOTE, 0, 0, ResourceType.R5_CURRENCY_REAL + ":1000",	"2:1"); */

		// _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_- OTHER -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
		if( !game.exchanger.items.exists(ExchangeType.C42_RENAME) )
			this.add(ExchangeType.C42_RENAME,	0, 0,		"",	"" );
		if( !game.exchanger.items.exists(ExchangeType.C43_ADS) )
			this.add(ExchangeType.C43_ADS,			0, 0,		"",	"51:" + arena);
		if( !game.exchanger.items.exists(ExchangeType.C104_STARS) )
			this.add(ExchangeType.C104_STARS, 	0, now,	"",	"");

		// _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_- MAGIC -_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_
		this.add(ExchangeType.C121_MAGIC, 0, 0, ResourceType.R4_CURRENCY_HARD + ":" + Exchanger.fixedRound(Exchanger.toHard(Exchanger.estimateBookOutcome(ExchangeType.BOOK_55_PIRATE,	arena, game.player.splitTestCoef))),	ExchangeType.BOOK_55_PIRATE	+ ":" + arena);
		this.add(ExchangeType.C122_MAGIC, 0, 0, ResourceType.R4_CURRENCY_HARD + ":" + Exchanger.fixedRound(Exchanger.toHard(Exchanger.estimateBookOutcome(ExchangeType.BOOK_56_JUNGLE,	arena, game.player.splitTestCoef))),	ExchangeType.BOOK_56_JUNGLE	+ ":" + arena);
		this.add(ExchangeType.C123_MAGIC, 0, 0, ResourceType.R4_CURRENCY_HARD + ":" + Exchanger.fixedRound(Exchanger.toHard(Exchanger.estimateBookOutcome(ExchangeType.BOOK_58_AMBER,	arena, game.player.splitTestCoef))),	ExchangeType.BOOK_58_AMBER	+ ":" + arena);

		if (this.game.player.get_point() > 80 && this.game.player.getResource(ResourceType.R6_TICKET) < 6)
		{
			this.addBundle(1, ExchangeType.C31_BUNDLE, 0, this.expireTime + (3 * 24 * 3600), "5:1999", "6:123, 4:50");
		}
	}


	public function add(type:Int, numExchanges:Int, expireAt:Int, reqStr:String, outStr:String) : Void
	{
		var item = new ExchangeItem(type, numExchanges, expireAt, reqStr, outStr);
		update(item);
		this.game.exchanger.items.set(type, item);
	}

	function addBundle(step:Int, type:Int, numExchanges:Int, expireAt:Int, reqStr:String, outStr:String) : Void
	{
		var outcomes = new IntIntMap(outStr);
		var requirements = new IntIntMap(reqStr);
		var offerStep = this.game.player.getResource(ResourceType.R26_OFFER_STEP);
		// trace("offerStep " + offerStep + " step " + step);
		if( offerStep >= step )
			return;
		var item = this.game.exchanger.items.exists(type) ? this.game.exchanger.items.get(type) : new ExchangeItem(type, 0);
		// trace("item.expiredAt " + item.expiredAt + " this.now " + this.now + " item.numExchanges " + item.numExchanges + " numExchanges " +  numExchanges);
		if( item.expiredAt >= this.now  )
			return;

		this.game.player.resources.increase(ResourceType.R26_OFFER_STEP, 1);

		item.expiredAt = expireAt;
		item.numExchanges = numExchanges;
		item.requirements = requirements;
		item.outcomes = outcomes;
		this.game.exchanger.items.set(type,  item);
		this.changes.add(item);
	}

	function update( item:ExchangeItem ) : Void
	{
		if( item.category == ExchangeType.C20_SPECIALS )
			updateSpecials(item);
	}
	
	function updateSpecials(item:ExchangeItem) : Void
	{
		if( item.type == ExchangeType.C29_DAILY_BATTLES )
		{
			if( item.expiredAt < now )
			{
				item.expiredAt = this.expireTime;
				item.numExchanges = 0;
			}
			return;
		}
		
		if( item.expiredAt < this.now )
		{
			var ticketNeeds = 0;
			if( item.type == ExchangeType.C23_SPECIAL )
			{
				ticketNeeds = ScriptEngine.getInt(ScriptEngine.T53_CHALLENGE_TICKET_CAPACITY, Challenge.getLastIndex(game));
				if( ticketNeeds > 0 )
					item.outcome = ResourceType.R6_TICKET;
				else
					item.outcome = game.player.cards.getRandomKey();
			}
			else if( item.type == ExchangeType.C22_SPECIAL )
			{
				item.outcome = ResourceType.R4_CURRENCY_HARD;
			}
			else if( item.type == ExchangeType.C21_SPECIAL )
			{
				item.outcome = ResourceType.R3_CURRENCY_SOFT;
			}
			
			item.expiredAt = this.expireTime;
			item.numExchanges = 0;
			item.outcomes = new IntIntMap();
			item.outcomes.set(item.outcome, getOutcomeQuantity(item, ticketNeeds));
			createOutcomeString(item);
		}
		else if( item.outcomes.values()[0] <= 0 )
		{
			item.outcomes.set(item.outcome, getOutcomeQuantity(item, 0));
			createOutcomeString(item);
		}
		
		item.requirements = new IntIntMap();
		item.requirements.set(getRequirementType(item), getPrice(item));
	}
	
	function createOutcomeString(item:ExchangeItem) : Void
	{
		item.createMapsStr();
		this.changes.add(item);
	}
	
	function getExpireTime() : Int
	{
		var date = Date.now();
		return now + (24 - date.getHours()) * 3600 - date.getMinutes() * 60 - date.getSeconds();	
	}

	function getOutcomeQuantity(item:ExchangeItem, tickets:Int):Int 
	{
		if( ResourceType.isCard(item.outcome) )
			return Math.ceil(arena / (ScriptEngine.getInt(0, item.outcome) * 2 + 1) );
		
		if( ResourceType.isBook(item.outcome) )
			return 1;
		
		if( item.outcome == ResourceType.R6_TICKET )
			return Math.ceil(Math.random() * 2) + tickets;
		
		return switch ( item.outcome )
		{
			case 3	: 10 * ( arena + 1 );
			case 4	: 1 * Math.ceil( (arena + 1) * 0.3 );
			case 5	: 1 * Math.ceil( (arena + 1) * 0.3 );
			default	: 10;
		}
	}
	
	function getRequirementType(item:ExchangeItem) : Int 
	{
		if( item.category == ExchangeType.C30_BUNDLES )
			return ResourceType.R5_CURRENCY_REAL;
		
		if( ResourceType.isCard(item.outcome) )
			return ResourceType.R3_CURRENCY_SOFT;
		return switch ( item.outcome )
		{
			case 3	: ResourceType.R4_CURRENCY_HARD;
			case 4	: ResourceType.R4_CURRENCY_HARD;
			case 5	: ResourceType.R4_CURRENCY_HARD;
			case 6	: ResourceType.R4_CURRENCY_HARD;
			default	: ResourceType.R3_CURRENCY_SOFT;
		}
	}
	
	function getPrice(item:ExchangeItem):Int 
	{
		var count = item.outcomes.values()[0];
		if( ResourceType.isCard(item.outcome) )
			return Math.round(Exchanger.toSoft(item.outcomes) * 0.2);
		else if( (item.outcome == ResourceType.R3_CURRENCY_SOFT && count <= 100) || (item.outcome == ResourceType.R4_CURRENCY_HARD && count <= 5) )
			return 0;
		return Math.round(Exchanger.toSoft(item.outcomes) * 0.2);
	}
}