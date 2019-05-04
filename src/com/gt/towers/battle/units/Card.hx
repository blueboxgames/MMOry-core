package com.gt.towers.battle.units;
import com.gt.towers.Game;
import com.gt.towers.constants.CardFeatureType;
import com.gt.towers.constants.MessageTypes;
import com.gt.towers.constants.ResourceType;
import com.gt.towers.exchanges.ExchangeItem;
import com.gt.towers.exchanges.Exchanger;
import com.gt.towers.scripts.ScriptEngine;
import com.gt.towers.utils.CoreUtils;
import com.gt.towers.utils.maps.IntIntMap;

/**
 * ...
 * @author Mansour Djawadi
 */
class Card
{
	public var type:Int;
	public var level:Int;
	public var game:Game;
	public var maxLevel:Int = 10;
	
	public var rarity:Int = 0;
	public var availableAt:Int = 0;
	public var elixirSize:Int = 5;
	public var quantity:Int = 1;
	public var summonTime:Int = 500;
	
	public var health:Float = 1;
	public var speed:Float = 1;
	public var sizeH:Float = 50;
	public var sizeV:Float = 50;
	public var focusRange:Float = 150;
	public var explosive:Bool;
	
	public var bulletSpeed:Float = 1.0;
	public var bulletDamage:Float = 1.05;
	public var bulletShootGap:Int = 800;
	public var bulletShootDelay:Int = 500;
	public var bulletRangeMin:Float = 50;
	public var bulletRangeMax:Float = 180;
	public var bulletDamageArea:Float = 180;
	public var bulletExplodeDelay:Float = 0;
#if java
	public var bulletForceKill:Bool = false;
#end	
	public function new(game:Game, type:Int, level:Int)
	{
		this.game = game;
		this.type = type;
		this.level = level;// Math.floor(Math.max(1, level));
		//trace("t:" + type + " l:" + level);
		setFeatures();
	}
	
	private function setFeatures() : Void
	{
		rarity = ScriptEngine.getInt(CardFeatureType.F00_RARITY, type, level);
		availableAt = ScriptEngine.getInt(CardFeatureType.F01_AVAILABLE_AT, type, level);
		elixirSize = ScriptEngine.getInt(CardFeatureType.F02_ELIXIR_SIZE, type, level);
		quantity = ScriptEngine.getInt(CardFeatureType.F03_QUANTITY, type, level);
		summonTime = ScriptEngine.getInt(CardFeatureType.F04_SUMMON_TIME, type, level);
		
		// troops data
		speed = ScriptEngine.get(CardFeatureType.F11_SPEED, type, level);
		health = ScriptEngine.get(CardFeatureType.F12_HEALTH, type, level);
		sizeH = ScriptEngine.get(CardFeatureType.F13_SIZE_H, type, level);
		sizeV = ScriptEngine.get(CardFeatureType.F14_SIZE_V, type, level);
		focusRange = ScriptEngine.get(CardFeatureType.F15_FOCUS_RANGE, type, level);
		explosive = ScriptEngine.getBool(CardFeatureType.F16_EXPLOSIVE, type, level);
		
		// bullet data
		bulletSpeed = ScriptEngine.get(CardFeatureType.F21_BULLET_SPEED, type, level);
		bulletDamage = ScriptEngine.get(CardFeatureType.F22_BULLET_DAMAGE, type, level);
		bulletShootGap = ScriptEngine.getInt(CardFeatureType.F23_BULLET_SHOOT_GAP, type, level);
		bulletShootDelay = ScriptEngine.getInt(CardFeatureType.F24_BULLET_SHOOT_DELAY, type, level);
		//bulletRangeMin = ScriptEngine.get(CardFeatureType.F25_BULLET_RANGE_MIN, type, level);
		bulletRangeMax = ScriptEngine.get(CardFeatureType.F26_BULLET_RANGE_MAX, type, level);
		bulletDamageArea = ScriptEngine.get(CardFeatureType.F27_BULLET_DAMAGE_AREA, type, level);
		bulletExplodeDelay = ScriptEngine.getInt(CardFeatureType.F28_BULLET_EXPLODE_DElAY, type, level);
#if java
		bulletForceKill = ScriptEngine.getBool(CardFeatureType.F29_BULLET_FORCE_KILL, type, level);
#end		
	}
	
	static public function addNew(game:Game, type:Int) : Int
	{
		if( game.player.get_arena(0) < ScriptEngine.getInt(CardFeatureType.F01_AVAILABLE_AT, type, 1) )
		{
			trace("card " + type + " can not collect in current league.");
			return MessageTypes.RESPONSE_NOT_ALLOWED;
		}
		game.player.cards.set(type, new Card(game, type, 1));
		game.player.resources.set(type, 1);
		return MessageTypes.RESPONSE_SUCCEED;
	}
	
	static var RARITY_START_LEVEL = [0, 2, 6, 9];
	static public var PRICE = [5, 50, 500, 5000];
	static public var RARITY_COUNT = [1, 10, 200, 4000];
	static public var UPGRADE_COST:Array<Int> = [0,	5,	20,	 50,	150,	400,	1000,	2000,	5000,	10000,	20000,	50000,	100000];
	static public var UPGRADE_CARD:Array<Int> = [0,	2,	4,	 10,	 20,	50,		100,	200,	400,	800,	1000,	2000,	5000];
	static public function get_upgradeCost(level:Int, rarity:Int = 0):Int
	{
		var lvl = Math.round(Math.max(1, level - RARITY_START_LEVEL[rarity]));
		if( lvl < UPGRADE_COST.length )
			return UPGRADE_COST[lvl];
		return Math.floor( Math.pow( 2, lvl - 9 ) * 100000 );
	}
	static public function get_upgradeCards(level:Int, rarity:Int = 0) : Int
	{		
		var lvl = Math.round(Math.max(1, level - RARITY_START_LEVEL[rarity]));
		if( lvl < UPGRADE_CARD.length )
			return UPGRADE_CARD[lvl];
		return Math.floor( Math.pow( 2, lvl - 10 ) * 10000 );
	}
	static public function getTotalCollected(level:Int, count:Int, rarity:Int = 0) : Int 
	{
		var ret = count + 0;
		var l = level - 1;
		while ( l > 0 )
		{
			ret += Card.get_upgradeCards(l, rarity);
			l --;
		}
		return ret;
	}
	
	public function get_upgradeRequirements():IntIntMap
	{
		var ret = new IntIntMap();
		ret.set( ResourceType.R3_CURRENCY_SOFT,	get_upgradeCost(level, rarity) );
		ret.set( type,							get_upgradeCards(level, rarity) );
		return ret;
	}
	
	public function get_upgradeRewards():IntIntMap 
	{
		var ret = new IntIntMap();
		var arena = game.player.get_arena(game.player.get_point());
		var minWinStreak = game.arenas.get(arena).minWinStreak;
		var playerWinStreak = game.player.get_winStreak();
		
		// XP rewards
		ret.set(ResourceType.R1_XP, Math.round( ( Math.log(level * level) + Math.log(1) ) * 30 ) + 4);
		
		// reduce winStreak to make AI difficulty easier
		if ( playerWinStreak - 9 <= minWinStreak )
			ret.set(ResourceType.R16_WIN_RATE, minWinStreak - playerWinStreak);
		else
			ret.set(ResourceType.R16_WIN_RATE, -1);
		
		return ret;
	}
	
	public function upgradable(confirmedHards:Int=0):Bool 
	{
		return level == -1 || confirmedHards >= Exchanger.toHard( game.player.deductions(get_upgradeRequirements()) );
	}
	public function upgrade(confirmedHards:Int=0):Bool
	{
		if( level == -1 )
		{
			level = 1;
			return true;
		}
		if( !upgradable(confirmedHards) )
			return false;
		
		var ei = new ExchangeItem(0);
		ei.requirements = get_upgradeRequirements();
		ei.outcomes = get_upgradeRewards();
		level ++;
		var res = game.exchanger.exchange(ei, 0, confirmedHards);
		if( res != MessageTypes.RESPONSE_SUCCEED )
		{
			level --;
			return false;
		}
		
		setFeatures();
		return true;
	}	
	public function availabled():Bool 
	{
		return availableAt <= game.player.get_arena(0);
	}
	public function unlocked(type:Int=-1):Bool 
	{
		return game.player.cards.exists(type);
	}
	
	public function count() : Int
	{
		return game.player.resources.get(type);
	}

	public function toSoft(count:Int = 1):Int
	{
		return Exchanger.cardToSoft(count, 0);
	}
	public function toHard(count:Int = 1):Int
	{
		return Exchanger.softToHard( toSoft(count) );
	}
	
	public function toString(showCardPrperties:Bool = true, showUnitPrperties:Bool = true, showBulletPrperties:Bool = true) : String
	{
		var ret = type + " > ";
		if( showCardPrperties )
			ret += toCardString();
		if( showUnitPrperties )
			ret += ", " + toUnitString();
		if( showBulletPrperties )
			ret += ", " + toBulletString();
		return ret;
	}
	
	public function toCardString() : String
	{
		return "L:" + level/* + ", maxLevel:" + maxLevel*/ + ", elixize:" + elixirSize + ", rarity:" + rarity + ", availAt:" + availableAt + ", quantity:" + quantity + ", summonTime:" + summonTime;
	}
	public function toUnitString() : String
	{
		return "speed:" + CoreUtils.fix(speed) + ", health:" + CoreUtils.fix(health) + ", sizeH:" + CoreUtils.fix(sizeH) + ", sizeV:" + CoreUtils.fix(sizeV) + ", focusRange:" + CoreUtils.fix(focusRange) + ", explosive:" + explosive;
	}
	public function toBulletString() : String
	{
		return "BSpeed:" + CoreUtils.fix(bulletSpeed) + ", BDamage:" + CoreUtils.fix(bulletDamage) + ", BShootGap:" + CoreUtils.fix(bulletShootGap) + ", BShootDelay:" + CoreUtils.fix(bulletShootDelay) + ", BRangeMax:" + CoreUtils.fix(bulletRangeMax) + ", BDamageArea:" + CoreUtils.fix(bulletDamageArea) + ", BExplodeDelay:" + CoreUtils.fix(bulletExplodeDelay);
	}
}