package com.gerantech.mmory.core.battle.units;
import com.gerantech.mmory.core.Game;
import com.gerantech.mmory.core.constants.MessageTypes;
import com.gerantech.mmory.core.constants.ResourceType;
import com.gerantech.mmory.core.exchanges.ExchangeItem;
import com.gerantech.mmory.core.exchanges.Exchanger;
import com.gerantech.mmory.core.scripts.ScriptEngine;
import com.gerantech.mmory.core.utils.CoreUtils;
import com.gerantech.mmory.core.utils.maps.IntIntMap;

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
	public var summonSize:Float = 10;
	
	public var z:Int = 0;
	public var speed:Float = 1;
	public var health:Float = 1;
	public var sizeH:Float = 50;
	public var sizeV:Float = 50;
	public var focusRange:Float = 150;
	public var explosive:Bool;
	public var focusUnit:Bool = true;
	public var focusHeight:Int = 200;
	public var selfDammage:Float = 0;
	public var selfTarget:Bool;
	
	public var bulletSpeed:Float = 1.0;
	public var bulletDamage:Float = 1.05;
	public var bulletShootGap:Int = 800;
	public var bulletShootDelay:Int = 500;
	public var bulletRangeMin:Float = 50;
	public var bulletRangeMax:Float = 180;
	public var bulletDamageArea:Float = 180;
	public var bulletExplodeDelay:Float = 0;
	public var bulletForceKill:Bool = false;
	public var bulletDamageHeight:Int = -10;
	static public var radiusMax:Float = 40; 

	public function new(game:Game, type:Int, level:Int)
	{
		this.game = game;
		this.type = type;
		this.level = level;// Math.floor(Math.max(1, level));
		//trace("t:" + type + " l:" + level);
		this.setFeatures();
	}
	
	private function setFeatures() : Void
	{
		rarity = ScriptEngine.getInt(ScriptEngine.T00_RARITY, type);
		availableAt = get_unlockat(game, type);
		elixirSize = ScriptEngine.getInt(ScriptEngine.T02_ELIXIR_SIZE, type);
		quantity = ScriptEngine.getInt(ScriptEngine.T03_QUANTITY, type);
		summonTime = ScriptEngine.getInt(ScriptEngine.T04_SUMMON_TIME, type);
		
		// troops data
		z = ScriptEngine.get(ScriptEngine.T10_Z, type);
		speed = ScriptEngine.get(ScriptEngine.T11_SPEED, type);
		health = ScriptEngine.get(ScriptEngine.T12_HEALTH, type, level);
		sizeV = ScriptEngine.get(ScriptEngine.T14_SIZE_V, type);
		sizeH = ScriptEngine.get(ScriptEngine.T13_SIZE_H, type);
		// radiusMax = Math.max(radiusMax, sizeH);
		focusRange = ScriptEngine.get(ScriptEngine.T15_FOCUS_RANGE, type, 0);
		explosive = ScriptEngine.getBool(ScriptEngine.T16_EXPLOSIVE, type);
		focusUnit = ScriptEngine.getBool(ScriptEngine.T17_FOCUS_UNIT, type, 0);
		focusHeight = ScriptEngine.getInt(ScriptEngine.T18_FOCUS_HEIGHT, type);
		selfDammage = ScriptEngine.get(ScriptEngine.T19_SELF_DAMMAGE, type, health);
		selfTarget = ScriptEngine.getBool(ScriptEngine.T20_SELF_TARGET, type);
		
		// bullet data
		bulletSpeed = ScriptEngine.get(ScriptEngine.T21_BULLET_SPEED, type, level);
		bulletDamage = ScriptEngine.get(ScriptEngine.T22_BULLET_DAMAGE, type, level);
		bulletShootGap = ScriptEngine.getInt(ScriptEngine.T23_BULLET_SHOOT_GAP, type, level);
		bulletShootDelay = ScriptEngine.getInt(ScriptEngine.T24_BULLET_SHOOT_DELAY, type, level);
		//bulletRangeMin = ScriptEngine.get(ScriptEngine.T25_BULLET_RANGE_MIN, type, level);
		bulletRangeMax = ScriptEngine.get(ScriptEngine.T26_BULLET_RANGE_MAX, type, level);
		bulletDamageArea = ScriptEngine.get(ScriptEngine.T27_BULLET_DAMAGE_AREA, type, level);
		bulletExplodeDelay = ScriptEngine.getInt(ScriptEngine.T28_BULLET_EXPLODE_DELAY, type, level);
		bulletForceKill = ScriptEngine.getBool(ScriptEngine.T29_BULLET_FORCE_KILL, type, level);
		bulletDamageHeight = ScriptEngine.getInt(ScriptEngine.T30_BULLET_DAMAGE_HEIGHT, type, level);
	}
	
	static var RARITY_START_LEVEL = [0, 2, 6, 9];
	static public var PRICE = [5, 50, 500, 5000];
	static public var RARITY_COUNT = [1, 10, 200, 4000];
	static public var UPGRADE_COST:Array<Int> = [0,	5,	20,	 50,	150,	400,	1000,	2000,	5000,	10000,	20000,	50000,	100000];
	static public var UPGRADE_CARD:Array<Int> = [0,	2,	4,	 10,	 20,	50,		100,	200,	400,	800,	1000,	2000,	5000];
	static public function get_upgradeCost(level:Int, rarity:Int = 0):Int
	{
		var lvl = level;// Math.round(Math.max(1, level - RARITY_START_LEVEL[rarity]));
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
/* 		var arena = game.player.get_arena(game.player.get_point());
		var minWinRate = game.arenas.get(arena).minWinStreak;
		var playerWinRate = game.player.get_winRate(); */
		
		// XP rewards
		ret.set(ResourceType.R1_XP, Math.round( ( Math.log(level * level) + Math.log(1) ) * 30 ) + 4);
		
		// reduce winStreak to make AI difficulty easier
	/* 	if ( playerWinRate - 9 <= minWinRate )
			ret.set(ResourceType.R16_WIN_RATE, minWinRate - playerWinRate);
		else */
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
	
	static private var UNLOCKES:IntIntMap;
	static public function get_unlockes(game:Game) : IntIntMap
	{
		if( UNLOCKES != null )
			return UNLOCKES;

		UNLOCKES = new IntIntMap();
		var lLen = game.arenas.keys().length;
		for( l in 0...lLen )
		{
			var rLen = game.arenas.get(l).rewards.length;
			for( r in 0...rLen )
			{
				var rw = game.arenas.get(l).rewards[r];
				if( ResourceType.isCard(rw.key) )
					UNLOCKES.set(rw.key, rw.point);
			}
		}
		return UNLOCKES;
	}
	static public function get_unlockat(game:Game, type:Int) : Int
	{
		var uls = get_unlockes(game);
		return uls.exists(type) ? uls.get(type) : 100000;	
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