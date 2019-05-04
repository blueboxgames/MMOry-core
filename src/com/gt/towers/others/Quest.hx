package com.gt.towers.others;
import com.gt.towers.Player;
import com.gt.towers.battle.units.Card;
import com.gt.towers.constants.ResourceType;
import com.gt.towers.exchanges.ExchangeItem;
import com.gt.towers.socials.Challenge;
import com.gt.towers.utils.CoreUtils;
import com.gt.towers.utils.maps.IntIntMap;

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
	
#if java
	static public inline var MAX_QUESTS:Int = 4;
	static public var MAX_STEP:Array<Int> = [20, 8, 4, 100, 100, 20, 10, 10, 100, 100];

	static public function instantiate(type:Int, player:Player) : Quest
	{
		var key = Quest.getKey(player, type);
		return new Quest(player, type, key, Quest.getNextStep(player, type, key));
	}	
	
	static public function fill(player:Player):Void
	{
		if( player.quests == null )
			player.quests = new Array<Quest>();
		
		if( player.get_battleswins() < 3 )
			return;
		
		if( player.quests.length == 0 && player.get_battleswins() < 10 )
		{
			player.quests.push( Quest.instantiate(TYPE_3_BATTLES,		player) );
			player.quests.push( Quest.instantiate(TYPE_7_CARD_COLLECT,	player) );
			player.quests.push( Quest.instantiate(TYPE_8_CARD_UPGRADE,	player) );
			player.quests.push( Quest.instantiate(TYPE_9_BOOK_OPEN,		player) );
		}
		
		if( player.quests.length >= MAX_QUESTS )
			return;
		
		var i = player.quests.length > 0 ? player.quests[player.quests.length - 1].type : -1;
		if( i == 9 )
			i = 0;
		else
			i ++;
		while( i < 10 )
		{
			if( player.getQuestIndexByType(i) == -1 && i != 2 )
			{
				player.quests.push( Quest.instantiate(i, player));
				fill(player);
				return;
			}
			i ++;
		}
	}
	
	static public function getKey(player:Player, type:Int):Int
	{
		return switch ( type )
		{
			case 0 :	ResourceType.R1_XP;
			case 1 :	ResourceType.R2_POINT;
			//case 2 :	ResourceType.OPERATIONS;
			case 3 :	ResourceType.R12_BATTLES;
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
		return switch ( type )
		{
			case 0 :	1 + step;
			case 1 :	1 + step;
			//case 2 :	step * 10;
			case 3 :	CoreUtils.round( Math.pow(1.3, step) * 10) - 8;
			case 4 :	CoreUtils.round( Math.pow(1.4, step) * 7);
			case 5 :	CoreUtils.round( Math.pow(1.4, step) * 5);
			case 6 :	step * 5;
			case 7 :	Card.getTotalCollected(step, 0) - 1;
			case 8 :	step;
			case 9 :	CoreUtils.round( Math.pow(1.4, step) * 5) - 2;
			default: 	0;
		}
	}
	
	static function getNextStep(player:Player, type:Int, key:Int) : Int 
	{
		var i = 1;
		var current = getCurrent(player, type, key);
		while ( i <= MAX_STEP[type] )
		{
			if( getTarget(type, i) > current )
				return i;
			i ++;
		}
		return i;
	}
#end

	static public function getReward(type:Int, step:Int):IntIntMap
	{
		var ret:IntIntMap = new IntIntMap();
		ret.set(ResourceType.R1_XP,			CoreUtils.round( Math.pow(1.4, step) * 1));
		ret.set(ResourceType.R3_CURRENCY_SOFT,	CoreUtils.round( Math.pow(1.4, step) * 7));
		return ret;
	}
	
	static public function getExchangeItem(type:Int, step:Int) : ExchangeItem
	{
		var ret:ExchangeItem = new ExchangeItem(ResourceType.R40_QUESTS + type + 1);
		ret.outcomes = getReward(type, step);
		return ret;
	}

	static public function getCurrent(player:Player, type:Int, key:Int) : Int
	{
		//trace("getCurrent " + type + " " + key);
		return switch ( type )
		{
			case 0 :	player.get_level(player.get_xp());
			case 1 :	player.get_arena(player.get_point()) + 1;
			//case 2 :	player.getLastOperation();
			case 3 :	player.get_battlesCount();
			case 4 :	player.get_battleswins();
			case 5 :	player.getResource(ResourceType.R15_BATTLES_FRIENDLY);
			case 6 :	player.getResource(key);
			case 7 :	Card.getTotalCollected(player.cards.get(key).level, player.getResource(key));
			case 8 :	player.cards.get(key).level;
			case 9 :	player.getResource(key);
			default: 	0;
		}
	}
}
//'P' plays with card 'C' only
//'W' wins with card 'C'
//'W' wins with all buildings occupition