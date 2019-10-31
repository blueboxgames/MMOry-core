package com.gerantech.mmory.core;
import com.gerantech.mmory.core.exchanges.ExchangeItem;
import com.gerantech.mmory.core.others.TrophyReward;
import com.gerantech.mmory.core.constants.MessageTypes;
import com.gerantech.mmory.core.Game;
import com.gerantech.mmory.core.battle.units.Card;
import com.gerantech.mmory.core.constants.CardTypes;
import com.gerantech.mmory.core.constants.PrefsTypes;
import com.gerantech.mmory.core.constants.ResourceType;
import com.gerantech.mmory.core.others.Quest;
import com.gerantech.mmory.core.scripts.ScriptEngine;
import com.gerantech.mmory.core.utils.maps.IntCardMap;
import com.gerantech.mmory.core.utils.maps.IntIntIntMap;
import com.gerantech.mmory.core.utils.maps.IntIntMap;
import com.gerantech.mmory.core.utils.maps.IntStrMap;

/**
 * @author Mansour Djawadi
 */
class Player
{
	static var FIRST_CARDS:Int = 8;
	public var id:Int;
	public var createAt:Int;
	public var lastLogin:Int;
	public var admin:Bool = false;
	public var tutorialMode:Int = 0;
	public var hasOperations:Bool = true;
	public var invitationCode:String;
	public var prefs:IntStrMap;
	public var quests:Array<Quest>;
	public var resources:IntIntMap;
	public var operations:IntIntMap;
	public var cards:IntCardMap;
	public var nickName:String = "no_nickName";
	public var decks:IntIntIntMap;
	public var selectedDeckIndex:Int = 0;
	public var splitTestCoef:Float = 1;

	private var game:Game;
#if java
	public var resourceIds:java.util.Map<java.lang.Integer, java.lang.Integer>;
#elseif flash
	public var challenges:com.gerantech.mmory.core.utils.maps.IntChallengeMap;
#end

	public function new(game:Game, initData:InitData)
	{
		this.game = game;
		id = initData.id;
		admin = isAdmin(id);
		nickName = initData.nickName;
		splitTestCoef = (id > 10010 && id % 2 == 0) ? 0.5 : 1;
		
		// add player resources, operations data
		resources = initData.resources;
		resources.set(ResourceType.R5_CURRENCY_REAL, 2147483647);
		operations = initData.operations;
		decks = initData.decks;
		
		// add player buildings data
		cards = new IntCardMap(false);
		var i:Int = 0;
		var kies = initData.cardsLevel.keys();
		while ( i < kies.length )
		{
			cards.set(kies[i], new Card( game, kies[i], initData.cardsLevel.get( kies[i] ) ) );
			i++;
		}
		
		// add prefs
		prefs = new com.gerantech.mmory.core.utils.maps.IntStrMap();
		#if flash
		prefs.set(com.gerantech.mmory.core.constants.PrefsTypes.SETTINGS_1_MUSIC, "true");
		prefs.set(com.gerantech.mmory.core.constants.PrefsTypes.SETTINGS_2_SFX, "true");
		prefs.set(com.gerantech.mmory.core.constants.PrefsTypes.SETTINGS_3_NOTIFICATION, "true");
		prefs.set(com.gerantech.mmory.core.constants.PrefsTypes.SETTINGS_4_LOCALE, "0");
		prefs.set(com.gerantech.mmory.core.constants.PrefsTypes.SETTINGS_5_ADS, "true");
		
		prefs.set(com.gerantech.mmory.core.constants.PrefsTypes.OFFER_30_RATING, "15");
		prefs.set(com.gerantech.mmory.core.constants.PrefsTypes.OFFER_31_TELEGRAM , "20");
		prefs.set(com.gerantech.mmory.core.constants.PrefsTypes.OFFER_32_INSTAGRAM, "25");
		prefs.set(com.gerantech.mmory.core.constants.PrefsTypes.OFFER_33_FRIENDSHIP, "30");
		#end
		
		i = 0;
		kies = initData.prefs.keys();
		while ( i < kies.length )
		{
			prefs.set(kies[i], initData.prefs.get(kies[i]) );
			i++;
		}
	}
	
	public function getLastOperation():Int
	{
		var lastOperation = 0;
		/*var oKeys = operations.keys();
		var totalOperations = FieldProvider.operations.keys().length;
		while ( lastOperation < oKeys.length )
		{
			if( operations.get( oKeys[lastOperation] ) == 0 )
				return lastOperation;
			lastOperation ++;
		}
		
		if( lastOperation == totalOperations )
			return lastOperation - 1 ;
		*/
		return lastOperation ;
	}
	
	public function unlocked_social():Bool { return get_arena(get_point()) > 0; }
	public function unlocked_challenge():Bool { return get_arena(get_point()) > 1; }
	public function getResource(type:Int):Int { return resources.exists(type) ? resources.get(type) : 0; }
	public function get_xp():Int { return resources.get(ResourceType.R1_XP); }
	public function get_point():Int { return resources.get(ResourceType.R2_POINT); }
	public function get_softs():Int { return resources.get(ResourceType.R3_CURRENCY_SOFT); }
	public function get_hards():Int { return resources.get(ResourceType.R4_CURRENCY_HARD); }
	public function get_battlesCount():Int { return resources.get(ResourceType.R12_BATTLES); }
	public function get_battleswins():Int { return resources.get(ResourceType.R13_BATTLES_WINS); }
	public function get_winRate():Int { return resources.get(ResourceType.R16_WIN_RATE); }
	public function get_level(xp:Int):Int
	{
		if( xp == 0 )
			xp = get_xp();
		var index = 0;
		while ( index < game.levels.length )
		{
			if( game.levels[index] >= xp )
				return index;
			index ++;
		}
		return index;
	}
	
	public function get_arena(point:Int) : Int
	{
		if( point == 0 )
			point = get_point();
			
		var arenaKeys = game.arenas.keys();
		var arena = arenaKeys.length - 1;
		while ( arena >= 0 )
		{
			if( point > game.arenas.get( arenaKeys[arena] ).max )
				break;
			arena --;
		}
		return cast(Math.min(arena + 1, arenaKeys.length - 1), Int);
	}
	
	/**
	 * 
	 * @param	selectedArena
	 * @param	mode => 0: all<br/>1: avalables<br/>2: unavailables 
	 * @return
	 */
	public function availabledCards(point:Int, mode:Int = 0) : Array<Int>
	{
		var ret = new Array<Int>();
		var unlocks = Card.get_unlockes(game);
		var keys = unlocks.keys();
		var len:Int = keys.length;
		for (i in 0...len) 
			if( (mode == 0) || (mode == 1 && unlocks.get(keys[i]) <= point) || (mode == 2 && unlocks.get(keys[i]) > point) )
				ret.push(keys[i]);
		
		return ret;
	}
	
	public function getAvailablity(type:Int) : Int
	{
		if( !ResourceType.isCard(type) )
			return CardTypes.AVAILABLITY_EXISTS;
		if( cards.exists(type) )
			return CardTypes.AVAILABLITY_EXISTS;
		return Card.get_unlockat(game, type) < get_point() ? CardTypes.AVAILABLITY_WAIT : CardTypes.AVAILABLITY_NOT;
	}


	public function getSelectedDeck():IntIntMap
	{
		return decks.get(selectedDeckIndex);
	}
	
	public function has(map:IntIntMap) : Bool
	{
		var i:Int = 0;
		var keis = map.keys();
		while ( i < keis.length )
		{
			if( map.get(keis[i]) > resources.get(keis[i]) )
				return false;
			i ++;
		}
		return true;
	}
	
	public function deductions(map:IntIntMap) : IntIntMap
	{
		var ret = new IntIntMap();
		var keis = map.keys();
		var i = 0;
		while ( i < keis.length )
		{
			var remain = map.get(keis[i]) - resources.get(keis[i]);
			if( remain > 0 )
				ret.set(keis[i], remain);
			i ++;
		}
		return ret;
	}
	
	public function addResources(bundle:IntIntMap) : Void
	{
		var keys = bundle.keys();
		var len = keys.length;
		for (i in 0...len) 
			addCard(keys[i]);
		resources.increaseMap(bundle);
	}

	public function addCard(type:Int) : Void
	{
		if( ResourceType.isCard(type) && !cards.exists(type) )
		{
			if( getSelectedDeck().keys().length < 8 && !getSelectedDeck().existsValue(type) )
				getSelectedDeck().set(getSelectedDeck().keys().length, type);
			cards.set(type, new Card(game, type, 1) );
		}
	}
	
	public function getRandomCard(rarity:Int):Int
	{
		var keys = cards.keys();
		var i = keys.length - 1;
		var targets = new IntIntMap();
		while ( i >= 0 )
		{
			if( ScriptEngine.getInt(ScriptEngine.T00_RARITY, keys[i]) == rarity )
				targets.set(keys[i], 0);
			i --;
		}
		
		if( targets.keys().length == 0 )
		{
			trace("player " + id + " has not any card with " + rarity + " rarity.");
			return -1;
		}
		
		return targets.getRandomKey();
	}
	
	public function getTutorStep() : Int { return prefs.getAsInt(PrefsTypes.TUTOR); }
	public function inSlotTutorial() : Bool { return getTutorStep() >= PrefsTypes.T_011_SLOT_FOCUS && getTutorStep() < PrefsTypes.T_013_BOOK_OPENED; }
	public function inDeckTutorial() : Bool { return getTutorStep() >= PrefsTypes.T_013_BOOK_OPENED && getTutorStep() < PrefsTypes.T_018_CARD_UPGRADED; }
	public function villageEnabled() : Bool { return !inTutorial();/*get_arena(0) > 0;*/ }
	public function emptyDeck() : Bool { return !cards.exists(CardTypes.C101) || cards.get(CardTypes.C101).level <= 1 ; }
	public function isBot() : Bool { return id < 10000; }
	public static function isAdmin(id:Int) : Bool {return (id < 10010 || id == 28034 || id == 28076); }
	public function inTutorial() : Bool
	{
		if( isBot() )
			return false;
	#if java
		if( tutorialMode == 0 && getLastOperation() < 3 )
			return true;
		if( tutorialMode == 1 && get_battleswins() < 2 )
			return true;
	#elseif flash
		if( tutorialMode == 0 && getLastOperation() < 3 && getTutorStep() < PrefsTypes.T_71_SELECT_NAME_FOCUS )
			return true;
		if( tutorialMode == 1 && get_battleswins() < 2 )
			return true;
	#end
		return false;
	}

	public function achieveReward(league:Int, index:Int) : Int
	{
		var reward:TrophyReward = game.arenas.get(league).rewards[index];
		if( get_point() < reward.point )
		{
			trace("reward [" + reward + "] can not achieve with " + get_point() + " point.");
			return MessageTypes.RESPONSE_NOT_ALLOWED;
		}

		var lastRewardStep = getResource(ResourceType.R25_REWARD_STEP);
		if( lastRewardStep != reward.step - 1 )
		{
			if( lastRewardStep == reward.step - 2 )
			{
				var prevType:Int = index == 0 ? game.arenas.get(league - 1).rewards[2].key : game.arenas.get(league).rewards[index - 1].key;
				if( !ResourceType.isEvent(prevType) )
					return MessageTypes.RESPONSE_NOT_ALLOWED;
			}
			else
			{
				trace("reward.step " + reward.step + " can not achieve in current league.");
				return MessageTypes.RESPONSE_NOT_ALLOWED;
			}
		}
		trace("reward.step " + reward.step + " lastRewardStep " + lastRewardStep);

		resources.set(ResourceType.R25_REWARD_STEP, reward.step);
		#if java
		if( ResourceType.isBook(reward.key) )
			return game.exchanger.exchange(new ExchangeItem(reward.key, 1 ,0, "", reward.key + ":" + league), 0);

		addCard(reward.key);
		resources.increase(reward.key, reward.value);
		#end
		return MessageTypes.RESPONSE_SUCCEED;
	}

	#if flash
	public function dashboadTabEnabled(index:Int) : Bool
	{
		if( getTutorStep() >= 27 )
			return true;
		if( index == 1 )
			return inDeckTutorial();
		if( index ==  2 )
			return !inDeckTutorial();
		return false;
	}
	#end
	
	public function getQuestIndexByType(type:Int) : Int
	{
		var i = 0;
		while ( i < quests.length )
		{
			if( quests[i].type == type )
				return i;
			i ++;
		}
		return -1;
	}
	public function getQuestIndexById(id:Int) : Int
	{
		var i = 0;
		while ( i < quests.length )
		{
			if( quests[i].id == id )
				return i;
			i ++;
		}
		return -1;
	}
	
	public function fillCards() : Void
	{
		var cardTypes = availabledCards(get_point(), 1);
		var numCards:Int = cardTypes.length;
		var baseLevel = get_point() * 0.005 + 1;
		var roundBase = Math.floor(baseLevel); 
		var ratio = baseLevel % 1;
		var log = "BOT => point:" + get_point() + " base-level: " + baseLevel;
		var i = 0;
		cards = new IntCardMap(false);
		while ( i < numCards )
		{
			var type:Int = cardTypes[i];
			var level:Int = Math.round(Math.max(1, roundBase + (Math.random() < ratio ? 1 : 0)));
			log += (" ," + type + ":" + level);
			cards.set(type, new Card(game, type, level));
			i ++;
		}

		log += " deck=> ";
		i = 0;
		var allCards = cards.keys();
		var deck = new IntIntMap();
		numCards = cast(Math.min(8, allCards.length), Int);
		while( i < numCards )
		{
			var randType = allCards[Math.floor ( Math.random() * allCards.length )];
			if( deck.existsValue(randType) ) 
				continue;
			
			log += "," + randType;
			deck.set(i, randType);
			i ++;
		}
		decks.set(0, deck);
		trace(log);
	}
}