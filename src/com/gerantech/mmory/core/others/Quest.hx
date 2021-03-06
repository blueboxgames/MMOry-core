package com.gerantech.mmory.core.others;
import com.gerantech.mmory.core.Player;
import com.gerantech.mmory.core.battle.units.Card;
import com.gerantech.mmory.core.constants.PrefsTypes;
import com.gerantech.mmory.core.constants.ResourceType;
import com.gerantech.mmory.core.exchanges.ExchangeItem;
import com.gerantech.mmory.core.socials.Challenge;
import com.gerantech.mmory.core.utils.CoreUtils;
import com.gerantech.mmory.core.utils.maps.IntIntMap;

/**
 * ...
 * @author Mansour Djawadi
 */
class Quest 
{
	public var id:Int;
	public var key:Int;
	public var type:Int;
	public var target:Int;
	public var current:Int;
	public var nextStep:Int;
	public var rewards:IntIntMap;

#if java
	public function new(player:Player, type:Int, key:Int, nextStep:Int) 
	{
		this.current = Quest.getCurrent(player, type, key);
		this.target = Quest.getTarget(type, nextStep);
		this.rewards = Quest.getReward(type, nextStep);
#elseif flash
	public function new(id:Int, type:Int, key:Int, nextStep:Int, current:Int, target:Int, rewards:IntIntMap) 
	{
		this.current = current;
		this.target = target;
		this.rewards = rewards;
		this.id = id;
#end
		this.type = type;
		this.key = key;
		this.nextStep = nextStep;
	}
	
	public function passed() : Bool
	{
		return current >= target;
	}




	static public var TYPE_0_LEVELUP:Int = 0;
	static public var TYPE_1_LEAGUEUP:Int = 1;
	//static public var TYPE_2_OPERATIONS:Int = 2;
	static public var TYPE_3_BATTLES:Int = 3;
	static public var TYPE_4_BATTLE_WINS:Int = 4;
	static public var TYPE_5_FRIENDLY_BATTLES:Int = 5;
	static public var TYPE_6_CHALLENGES:Int = 6;
	static public var TYPE_7_CARD_COLLECT:Int = 7;
	static public var TYPE_8_CARD_UPGRADE:Int = 8;
	static public var TYPE_9_BOOK_OPEN:Int = 9;
	static public var TYPE_10_RATING:Int = 10;
	static public var TYPE_11_TELEGRAM:Int = 11;
	static public var TYPE_12_INSTAGRAM:Int = 12;
	static public var TYPE_13_FRIENDSHIP:Int = 13;
	
#if java
	static public inline var MAX_QUESTS:Int = 4;
	static public var MAX_STEP:Array<Int> = [30, 30, 4, 100, 100, 100, 100, 100, 100, 100, 1, 1, 1, 1];
	static public function instantiate(player:Player, type:Int) : Quest
	{
		var key = Quest.getKey(player, type);
		return new Quest(player, type, key, Quest.getNextStep(player, type, key));
	}	
	
	
	static public function getKey(player:Player, type:Int):Int
	{
		if( type >= 10 )
			return 20 + type;

		return switch ( type )
		{
			case 0 :	ResourceType.R1_XP;
			case 1 :	ResourceType.R2_POINT;
			//case 2 :	ResourceType.OPERATIONS;
			case 3 :	ResourceType.R12_BATTLES_NUMS;
			case 4 :	ResourceType.R13_BATTLES_WINS;
			case 5 :	ResourceType.R15_BATTLES_FRIENDLY;
			case 6 :	Challenge.getlowestJoint(player);
			case 7 :	player.cards.getLowestLevel();
			case 8 :	player.cards.getLowestCard();
			case 9 :	ResourceType.R22_BOOK_OPENED_FREE;
			default: 	0;
		}
	}
	
	static public function getTarget(type:Int, step:Int) : Int
	{
		if( type >= 10 && type < 13 )
			return 1;
		
		return switch ( type )
		{
			case 0 :	1 + step;
			case 1 :	1 + step;
			//case 2 :	step * 10;
			case 3 :	CoreUtils.round( Math.pow(1.3, step) * 20) - 8;
			case 4 :	CoreUtils.round( Math.pow(1.4, step) * 14);
			case 5 :	CoreUtils.round( Math.pow(1.4, step) * 10);
			case 6 :	(step + 1) * 10;
			case 7 :	Card.getTotalCollected(step + 2, 0);
			case 8 :	step + 2;
			case 9 :	CoreUtils.round( Math.pow(1.4, step) * 10) - 2;
			case 10 :	1;
			case 11 :	1;
			case 12 :	1;
			case 13 :	5;
			default: 	0;
		}
	}
	
	static function getNextStep(player:Player, type:Int, key:Int) : Int 
	{
		var step = 1;
		var current = getCurrent(player, type, key);
		while ( step <= MAX_STEP[type] )
		{
			// trace("getNextStep => t:" + type + " k:" + key + " current:" + current + " step:" + step + " target:" + getTarget(type, step));
			if( getTarget(type, step) > current )
				return step;
			step ++;
		}
		return step;
	}
#end

static public function progressive(type:Int) : Bool { return type < 10 || type > 12; }
static public function getReward(type:Int, step:Int):IntIntMap
	{
		var ret:IntIntMap = new IntIntMap();
		ret.set(ResourceType.R1_XP,			CoreUtils.round( Math.pow(1.4, step) * 1));
		if(type >= TYPE_10_RATING )
			ret.set(ResourceType.R4_CURRENCY_HARD,	type == TYPE_13_FRIENDSHIP ? 50 : 10);
		else
			ret.set(ResourceType.R3_CURRENCY_SOFT,	CoreUtils.round( Math.pow(1.4, step) * 5));
		return ret;
	}
	
	static public function getExchangeItem(type:Int, step:Int) : ExchangeItem
	{
		var ret:ExchangeItem = new ExchangeItem(-1, 0);
		ret.outcomes = getReward(type, step);
		return ret;
	}

	static public function getCurrent(player:Player, type:Int, key:Int) : Int
	{
		//trace("getCurrent " + type + " " + key);
		return switch ( type )
		{
			case 0 :	player.get_level(player.get_xp());
			case 1 :	player.get_arena(player.get_point());
			//case 2 :	player.getLastOperation();
			case 3 :	player.get_battlesCount();
			case 4 :	player.get_battleswins();
			case 5 :	player.getResource(ResourceType.R15_BATTLES_FRIENDLY);
			case 6 :	player.getResource(key);
			case 7 :	Card.getTotalCollected(player.cards.get(key).level, player.getResource(key));
			case 8 :	player.cards.get(key).level;
			case 9 :	player.getResource(key);
			case 10 :	player.prefs.getAsInt(PrefsTypes.OFFER_30_RATING);
			case 11 :	player.prefs.getAsInt(PrefsTypes.OFFER_31_TELEGRAM);
			case 12 :	player.prefs.getAsInt(PrefsTypes.OFFER_32_INSTAGRAM);
			case 13 :	player.getResource(ResourceType.R27_FRIENDS);
			default: 	0;
		}
	}

	public function toString():String
	{
		return "{id: " + id + ", type:" + type + ", current:" + current + ", target:" + target + ", nextStep:" + nextStep + "}";
	}
}

//'P' plays with card 'C' only
//'W' wins with card 'C'
//'W' wins with all buildings occupition