package com.gt.towers;
import com.gt.towers.Game;
import com.gt.towers.battle.units.Card;
import com.gt.towers.constants.CardFeatureType;
import com.gt.towers.constants.CardTypes;
import com.gt.towers.constants.PrefsTypes;
import com.gt.towers.constants.ResourceType;
import com.gt.towers.others.Quest;
import com.gt.towers.scripts.ScriptEngine;
import com.gt.towers.utils.maps.IntCardMap;
import com.gt.towers.utils.maps.IntIntIntMap;
import com.gt.towers.utils.maps.IntIntMap;
import com.gt.towers.utils.maps.IntStrMap;

/**
 * @author Mansour Djawadi
 */
class Player
{
	static var FIRST_CARDS:Int = 8;
	public var id:Int;
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
	public var challenges:com.gt.towers.utils.maps.IntChallengeMap;
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
		cards = new IntCardMap();
		var i:Int = 0;
		var kies = initData.cardsLevel.keys();
		while ( i < kies.length )
		{
			cards.set(kies[i], new Card( game, kies[i], initData.cardsLevel.get( kies[i] ) ) );
			i++;
		}
		
		// add prefs
		prefs = new com.gt.towers.utils.maps.IntStrMap();
		#if flash
		prefs.set(com.gt.towers.constants.PrefsTypes.SETTINGS_1_MUSIC, "true");
		prefs.set(com.gt.towers.constants.PrefsTypes.SETTINGS_2_SFX, "true");
		prefs.set(com.gt.towers.constants.PrefsTypes.SETTINGS_3_NOTIFICATION, "true");
		prefs.set(com.gt.towers.constants.PrefsTypes.SETTINGS_4_LOCALE, "0");
		
		prefs.set(com.gt.towers.constants.PrefsTypes.OFFER_30_RATING, "15");
		prefs.set(com.gt.towers.constants.PrefsTypes.OFFER_31_TELEGRAM , "20");
		prefs.set(com.gt.towers.constants.PrefsTypes.OFFER_32_INSTAGRAM, "25");
		prefs.set(com.gt.towers.constants.PrefsTypes.OFFER_33_FRIENDSHIP, "30");
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
	public function get_winStreak():Int { return resources.get(ResourceType.R16_WIN_RATE); }
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
	 * @param	mode => 0: only arena card<br/>1: avalables<br/>2: unavailables 
	 * @return
	 */
	public function availabledCards(arena:Int = -1, mode:Int = 0) : Array<Int>
	{
		var _arena = arena == -1 ? get_arena(get_point()) : arena;
		var _all:Array<Int> = ScriptEngine.get(CardFeatureType.F01_AVAILABLE_AT, -1);
		if( mode == 0 )
		{
			if( _arena == 0 )
				return _all.slice(0, FIRST_CARDS);
			return [_all[_arena + FIRST_CARDS - 1]];
		}
		if( mode == 1 )
			return _all.slice(0, _arena + FIRST_CARDS);
		return _all.slice(arena + FIRST_CARDS);
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
		var bundleKeys = bundle.keys();
		var i = 0;
		while ( i < bundleKeys.length )
		{
			if( ResourceType.isCard(bundleKeys[i]) && !game.player.cards.exists(bundleKeys[i]) )
			{
				if( getSelectedDeck().keys().length < 8 && !cards.exists(bundleKeys[i]) && !getSelectedDeck().existsValue(bundleKeys[i]) )
					getSelectedDeck().set(getSelectedDeck().keys().length, bundleKeys[i]);
				cards.set(bundleKeys[i], new Card(game, bundleKeys[i], bundle.get(bundleKeys[i]) ) );
			}
			i ++;
		}
		resources.increaseMap ( bundle );
	}
	
	public function getRandomCard(rarity:Int):Int
	{
		var keys = cards.keys();
		var i = keys.length - 1;
		var targets = new IntIntMap();
		while ( i >= 0 )
		{
			if( ScriptEngine.getInt(CardFeatureType.F00_RARITY, keys[i]) == rarity )
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
	public static function isAdmin(id:Int) : Bool {return (id < 10010); }
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
		var myArenaIndex:Int = Std.int(Math.max(1, game.player.get_arena(0)));
		if( myArenaIndex > 3 )
			myArenaIndex = 3;
		
		var cardTypes = availabledCards(myArenaIndex, 1);
		var numCards:Int = cardTypes.length;
		var baseLevel = get_point() * 0.005 + 1;
		var roundBase = Math.floor(baseLevel); 
		var ratio = baseLevel % 1;
		var log = "BOT => point:" + get_point() + " base-level: " + baseLevel;
		var i = 0;
		cards = new IntCardMap();
        while ( i < numCards )
        {
			var type:Int = cardTypes[i];
			var rarity = ScriptEngine.getInt(CardFeatureType.F00_RARITY, type, 1);
			var availabled = ScriptEngine.getInt(CardFeatureType.F01_AVAILABLE_AT, type, 1);
			var level:Int = Math.round(Math.max(1, roundBase - rarity - availabled + (Math.random() < ratio ? 1 : 0)));
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