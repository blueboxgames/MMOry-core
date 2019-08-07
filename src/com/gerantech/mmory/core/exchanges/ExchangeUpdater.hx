package com.gerantech.mmory.core.exchanges;
import com.gerantech.mmory.core.constants.PrefsTypes;
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
	var arena:Int;
	var game:Game;
	public var changes:java.util.List<ExchangeItem>;

	public function new(game:Game) 
	{
		this.game = game;
		this.arena = game.player.get_arena(0);
		this.changes = new java.util.ArrayList();
		this.now = cast(java.lang.System.currentTimeMillis() / 1000, Int);
		this.add();
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
		this.add(ExchangeType.C71_TICKET, 0, 0, ResourceType.R4_CURRENCY_HARD + ":10",	ResourceType.R6_TICKET + ":" + Exchanger.hardToTicket(10)     * 1.00);
		this.add(ExchangeType.C72_TICKET, 0, 0, ResourceType.R4_CURRENCY_HARD + ":50",	ResourceType.R6_TICKET + ":" + Exchanger.hardToTicket(50)     * 1.20);
		this.add(ExchangeType.C73_TICKET, 0, 0, ResourceType.R4_CURRENCY_HARD + ":100",	ResourceType.R6_TICKET + ":" + Exchanger.hardToTicket(100)    * 1.40);

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

		this.addBundle(1, ExchangeType.C31_BUNDLE, 0, this.now + (8 * 3600), "5:1999", "6:123");
		// this.addBundle(2, ExchangeType.C31_BUNDLE, 1, this.now + (8 * 3600), "5:1999", "6:123");
	}


	public function add(type:Int, numExchanges:Int, expireAt:Int, reqStr:String, outStr:String) : Void
	{
			game.exchanger.items.set(ExchangeType.C31_BUNDLE,  new ExchangeItem(ExchangeType.C31_BUNDLE, 1, now + 8 * 3600, "5:1999", "6:123"));
		}
	}

	public function update( item:ExchangeItem ) : Void
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
				item.expiredAt = now + 86400;
				item.numExchanges = 0;
			}
			return;
		}
		
		if( item.expiredAt < now )
		{
			if( item.type == ExchangeType.C23_SPECIAL )
			{
				if( game.player.cards.keys().length > 0 && game.player.getResource(ResourceType.R6_TICKET) > 15 )
					item.outcome = game.player.cards.getRandomKey();
				else
					item.outcome = ResourceType.R6_TICKET;
			}
			else if( item.type == ExchangeType.C22_SPECIAL )
			{
				item.outcome = ResourceType.R4_CURRENCY_HARD;
			}
			else if( item.type == ExchangeType.C21_SPECIAL )
			{
				item.outcome = ResourceType.R3_CURRENCY_SOFT;
			}
			
			item.expiredAt = now + 86400;
			item.numExchanges = 0;
			item.outcomes = new IntIntMap();
			item.outcomes.set(item.outcome, getOutcomeQuantity(item));
			createOutcomeString(item);
		}
		else if( item.outcomes.values()[0] <= 0 )
		{
			item.outcomes.set(item.outcome, getOutcomeQuantity(item));
			createOutcomeString(item);
		}
		
		item.requirements = new IntIntMap();
		item.requirements.set(getRequirementType(item), getPrice(item));
	}
	
	function createOutcomeString(item:ExchangeItem) : Void
	{
		item.createMapsStr();
		changes.add(item);
	}
	
	function getOutcomeQuantity(item:ExchangeItem):Int 
	{
		if( ResourceType.isCard(item.outcome) )
			return Math.ceil(arena / (ScriptEngine.getInt(0, item.outcome) * 2 + 1) );
		
		if( ResourceType.isBook(item.outcome) )
			return 1;
		
		if( item.outcome == ResourceType.R6_TICKET )
		{
			var rand = Math.ceil(Math.random() * 2);
			
			if( Challenge.getUnlockAt(game, 3) <= game.player.get_point() )
				return 15 + rand;
			if( Challenge.getUnlockAt(game, 2) <= game.player.get_point() )
				return 12 + rand;
			return 10 + rand;
		}
		
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
			case 4	: ResourceType.R5_CURRENCY_REAL;
			case 5	: ResourceType.R4_CURRENCY_HARD;
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