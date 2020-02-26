package com.gerantech.mmory.core.battle;

import com.gerantech.mmory.core.Game;
import com.gerantech.mmory.core.battle.bullets.Bullet;
import com.gerantech.mmory.core.battle.fieldes.FieldData;
import com.gerantech.mmory.core.battle.units.Card;
import com.gerantech.mmory.core.battle.units.Unit;
import com.gerantech.mmory.core.constants.CardTypes;
import com.gerantech.mmory.core.constants.MessageTypes;
import com.gerantech.mmory.core.events.BattleEvent;
import com.gerantech.mmory.core.scripts.ScriptEngine;
import com.gerantech.mmory.core.socials.Challenge;
import com.gerantech.mmory.core.utils.CoreUtils;
import com.gerantech.mmory.core.utils.GraphicMetrics;
import com.gerantech.mmory.core.utils.Point2;
import com.gerantech.mmory.core.utils.maps.IntCardMap;
import com.gerantech.mmory.core.utils.maps.IntIntCardMap;

/**
 * ...
 * @author Mansour Djawadi
 */
#if flash
class BattleField extends flash.events.EventDispatcher
{
#elseif java
class BattleField
{
#end
	static public var WIDTH:Int = 900;
	static public var HEIGHT:Int = 1200;
	static public var PADDING:Int = 40;
	static public var SUMMON_PADDING:Int = 32;
	
	static public var STATE_0_WAITING:Int = 0;
	static public var STATE_1_CREATED:Int = 1;
	static public var STATE_2_STARTED:Int = 2;
	static public var STATE_3_PAUSED:Int = 3;
	static public var STATE_4_ENDED:Int = 4;
	static public var STATE_5_DISPOSED:Int = 5;
	
	static public  var SUMMON_AREA_THIRD:Int = -1;
	static public  var SUMMON_AREA_HALF:Int = 0;
	static public  var SUMMON_AREA_RIGHT:Int = 1;
	static public  var SUMMON_AREA_LEFT:Int = 2;
	static public  var SUMMON_AREA_BOTH:Int = 3;

	static public var CAMERA_ANGLE:Float = 0.766;// sin of 50 angle
	static public var DELTA_TIME:Int = 25;

	static public var MAX_LATENCY:Int = 4000;
	
	public var state:Int = 0;
	public var debugMode:Bool;
	public var singleMode:Bool;
	public var friendlyMode:Int;
	public var field:FieldData;
	public var difficulty:Int;
	public var arena:Int;
	public var extraTime:Int = 0;
	public var decks:IntIntCardMap;
	public var units:Array<Unit>;
	public var bullets:Array<Bullet>;
	public var now:Float = 0;
	public var startAt:Int = 0;
	public var deltaTime:Int = 25;
	public var side:Int = 0;
	public var spellId:Int = 1000000;
	public var games:Array<Game>;
	public var numSummonedUnits:Int;
	public var pauseTime:Float;
	public var elixirUpdater:ElixirUpdater;
	var pioneerSide:Int;
	var resetTime:Float = -1;
	var remainigTime:Int = 0;
#if java 
	public var unitsHitCallback:com.gerantech.mmory.core.interfaces.IUnitHitCallback;
	var unitId:Int = 0;
#end
	public function new()
	{
		#if flash
		super();
		#end
	}
	public function initialize(game_0:Game, game_1:Game, field:FieldData, side:Int, startAt:Float, now:Float, hasExtraTime:Bool, friendlyMode:Int) : Void
	{
		this.side = side;
		this.now = now;
		this.startAt = Math.round(startAt);
		this.pauseTime = (startAt + 2000) * 1000;
		this.resetTime = (startAt + 2000) * 1000;
		this.field = field;
		this.singleMode = game_1.player.cards.keys().length == 0;
		this.friendlyMode = friendlyMode;
		this.extraTime = hasExtraTime ? field.times.get(3) : 0;
		
		this.units = new Array<Unit>();
		this.bullets = new Array<Bullet>();
		this.elixirUpdater = new ElixirUpdater(field.mode);

		this.games = new Array<Game>();
		this.games[0] = game_0;
		this.games[1] = game_1;
		
		#if java
		if( singleMode )
		{
			game_1.player.resources.set(com.gerantech.mmory.core.constants.ResourceType.R2_POINT, game_0.player.get_point() + Math.round(Math.random() * 20 - 10) + 15);
			this.difficulty = Math.round(game_1.player.get_point() / 20);
			game_1.player.resources.set(com.gerantech.mmory.core.constants.ResourceType.R1_XP, game_0.player.get_xp() + Math.round(Math.random() * 60 - 30) + 35);

			game_1.player.fillCards();
			
			if( this.difficulty != 0 )
			{
				var arenaScope = game_0.arenas.get(arena).max - game_0.arenas.get(arena).min;
				game_1.player.resources.set(com.gerantech.mmory.core.constants.ResourceType.R2_POINT,	Math.round( Math.max(0, game_0.player.get_point() + Math.random() * arenaScope - arenaScope * 0.5) ) );
			}
			trace("startAt:" + this.startAt + " now:" + this.now + " difficulty:" + this.difficulty + " mode:" + this.field.mode);

			// bot elixir is easier and player elixir is faster in tutorial
			this.elixirUpdater.normalSpeeds[0] *= ScriptEngine.get(ScriptEngine.T69_BATTLE_ELIXIR_RATIO, field.mode, 0, game_0.player.get_battleswins());
			this.elixirUpdater.normalSpeeds[1] *= ScriptEngine.get(ScriptEngine.T69_BATTLE_ELIXIR_RATIO, field.mode, 1, game_0.player.get_battleswins());

			trace ("es 0:" + ScriptEngine.get(ScriptEngine.T69_BATTLE_ELIXIR_RATIO, field.mode, 0, game_0.player.get_battleswins()) + " field.mode:" + field.mode + " battleswins" + game_0.player.get_battleswins());
			trace ("es 1:" + ScriptEngine.get(ScriptEngine.T69_BATTLE_ELIXIR_RATIO, field.mode, 1, game_0.player.get_battleswins()) + " field.mode:" + field.mode + " battleswins" + game_0.player.get_battleswins());
		}
		
		// add inital units
		if( field.mode != Challenge.MODE_1_TOUCHDOWN )
		{
			// var len = field.mode == Challenge.MODE_2_BAZAAR ? 2 : 6;
			var hqType = ScriptEngine.get(ScriptEngine.T54_CHALLENGE_INITIAL_UNITS, field.mode, false);
			var heroType = ScriptEngine.get(ScriptEngine.T54_CHALLENGE_INITIAL_UNITS, field.mode, true);
			while( unitId < 6 )
			{
				var side = unitId % 2;
				var card = new com.gerantech.mmory.core.battle.units.Card(games[side], unitId > 1 ? heroType : hqType, friendlyMode > 0 ? 9 : games[side].player.get_level(0));
				this.addUnit(card, side, Math.ffloor(field.targets[unitId * 2]), Math.ffloor(field.targets[unitId * 2 + 1]), card.z, this.now);
			}
		}
		
		// create decks	
		decks = new IntIntCardMap();
		// if( game_0.player.get_battleswins() < 3 )
		// 	decks.set(0, getDeckCards(game_0, game_0.loginData.initialDecks.get(game_0.player.get_battleswins()).toArray(false), friendlyMode));
		// else
			decks.set(0, getDeckCards(game_0, game_0.player.getSelectedDeck().toArray(game_0.player.get_battleswins() > 3 ), friendlyMode));
			decks.set(1, getDeckCards(game_1, game_1.player.getSelectedDeck().toArray(true), friendlyMode));
#end
		elixirUpdater.init();
	}
	
	static public function getDeckCards(game:Game, cardsTypes:Array<Int>, friendlyMode:Int) : IntCardMap
	{
		var ret = new IntCardMap(true); 
		//trace("id: " + game.player.id + "-> " + cardsTypes.toString() + " friendlyMode:" + friendlyMode);
		for(c in cardsTypes)
			if( game.player.cards.exists(c) )
				ret.set(c, friendlyMode > 0 ? new Card(game, c, 9) : game.player.cards.get(c));
		// trace("id: " + game.player.id + "-> " + ret.queue_String());
		return ret;
	}

	public function update(deltaTime:Int) : Void
	{
		if( deltaTime == 0 || state < STATE_1_CREATED || state > STATE_3_PAUSED )
			return;
		
		if( deltaTime < DELTA_TIME )
		{
			this.remainigTime += deltaTime;
			this.performRemaining();
			return;
		}

		this.remainigTime += deltaTime - DELTA_TIME;
		this.forceUpdate(DELTA_TIME);

		this.performRemaining();
	}
	
	public function forceUpdate(deltaTime:Int) : Void
	{
		this.deltaTime = deltaTime;
		this.now += deltaTime;
		// -=-=-=-=-=-=-=-  UPDATE TIME-STATE  -=-=-=-=-=-=-=-=-=-
		if( resetTime <= this.now )
			killPioneers();
		
		// trace((resetTime - now) + " delta " + (pauseTime - now) + " state " + state);
		if( pauseTime > now )
		{
			if( state == STATE_3_PAUSED )
			{
				state = STATE_2_STARTED;
				fireEvent(0, BattleEvent.PAUSE, state);
			}
		}
		else
		{
			if( state == STATE_2_STARTED )
			{
				state = STATE_3_PAUSED;
				fireEvent(0, BattleEvent.PAUSE, state);
			}
		}

		// -=-=-=-=-=-=-=-=-=-  UPDATE EXIXIR-BARS  -=-=-=-=-=-=-=-=-=-=-=-
		elixirUpdater.update(deltaTime, getDuration() > getTime(1));

		if( state > STATE_2_STARTED )
			return;
		
		// -=-=-=-=-=-=-=-=-  UPDATE AND REMOVE UNITS  -=-=-=-=-=-=-=-=-=-=
		// Creates a garbage array, adds unit id's to an array and sorts them
		// then updates disposed ones and updates the rest.
		for( unit in this.units )
			if( !unit.disposed() )
				unit.update();

		// -=-=-=-=-=-=-=-=-=  UPDATE PHYSICS-ENGINE  =-=-=-=-=-=-=-=-=-=-=-
		this.field.air.step();
		this.field.ground.step();
		
		// -=-=-=-=-=-=-=-=-  UPDATE AND REMOVE BULLETS  -=-=-=-=-=-=-=-=-
		for( bullet in this.bullets )
			if( !bullet.disposed() )
				bullet.update();			
	}

	private function performRemaining () : Void
	{
		if( this.remainigTime < DELTA_TIME )
			return;
		var remaning:Int = this.remainigTime + 0;
		this.remainigTime = 0;	
		update(remaning);
	}

	public function getDuration() : Float
	{
		return now / 1000 - startAt;
	}
	#if java
	public function summonUnit(type:Int, side:Int, x:Float, y:Float, time:Float) : Int
	{
		var index = cardAvailabled(side, type);
		if( index < 0 )
			return index;
		
		if( side == 0 )
		{
			numSummonedUnits ++;
			var ptoffset = ScriptEngine.getInt(ScriptEngine.T64_BATTLE_PAUSE_TIME, field.mode, games[0].player.get_battleswins(), numSummonedUnits);
			if( ptoffset > 0 )
				pauseTime = now + ptoffset;
		}

		if(this.now - time > MAX_LATENCY)
			return MessageTypes.RESPONSE_NOT_ALLOWED;

		if( time < this.now )
			time = this.now;
		
		var card = decks.get(side).get(type);
		decks.get(side).queue_removeAt(index);
		decks.get(side).enqueue(type);
		elixirUpdater.updateAt(side, elixirUpdater.bars[side] - card.elixirSize);
		
		if( com.gerantech.mmory.core.constants.CardTypes.isSpell(type) )
			return this.addSpell(card, side, x, y);
		
		for(i in 0...card.quantity)
			this.addUnit(card, side, CoreUtils.getXPosition(card.quantity, i, x), com.gerantech.mmory.core.utils.CoreUtils.getYPosition(card.quantity, i, y), card.z, time);

		return unitId - 1;
	}

	private function addUnit(card:Card, side:Int, x:Float, y:Float, z:Float, t:Float):Void
	{
		var u = new Unit(this.unitId, this, card, side, x, y, z, t);
		this.units.push(u);
		
		this.unitId ++;
	}

	function addSpell(card:Card, side:Int, x:Float, y:Float) : Int
	{
		var offset = GraphicMetrics.getSpellStartPoint(card.type);
		var spell = new Bullet(this, spellId, card, side, x + offset.x, y + offset.y, offset.z, x, y, 0);
		bullets.push(spell);
		spellId ++;
		return spellId - 1;
	}

	public function addBullet(unit:Unit, side:Int, x:Float, y:Float, target:Unit) : Void 
	{
		var b = new Bullet(this, unit.bulletId, unit.card, side, x, y, 0, target.x, target.y, 0);
		b.targetId = target.id;
		bullets.push(b);
		unit.bulletId ++;
	}
	
	
	public function getSide(id:Int) : Int
	{
		var gLen = games.length - 1;
		while( gLen >= 0 )
		{
			if( id == games[gLen].player.id )
				return gLen;
			gLen --;
		}
		return 0;
	}
	
	public function cardAvailabled(side:Int, type:Int) : Int
	{
		if( !games[side].player.cards.exists(type) )
			return com.gerantech.mmory.core.constants.MessageTypes.RESPONSE_NOT_FOUND;
		
		if( !decks.get(side).exists(type) )
			return com.gerantech.mmory.core.constants.MessageTypes.RESPONSE_NOT_ALLOWED;
		
		if( elixirUpdater.bars[side] < decks.get(side).get(type).elixirSize )
			return com.gerantech.mmory.core.constants.MessageTypes.RESPONSE_NOT_ENOUGH_REQS;
		
		var index = decks.get(side).queue_indexOf(type);
		
		// deck vallidation for bots
		if( side == 1 && games[1].player.isBot() && (index < 0 || index > 3) )
		{
			trace(decks.get(side).queue_String());
			return com.gerantech.mmory.core.constants.MessageTypes.RESPONSE_MUST_WAIT;
		}
		
		return index;
	}
	#end

	public function getUnit(uid:Int):Unit
	{
		for(unit in this.units)
			if(unit.id == uid)
				return unit;
		return null;
	}

	public function explodeBullet(bullet:Bullet) : Void
	{
		var distance:Float = 0;
	#if java
		var hitUnits:java.util.List<java.lang.Integer> = new java.util.ArrayList();
	#end
		for( u in this.units )
		{
			if( u.disposed() )
				continue;
			distance = Math.abs(com.gerantech.mmory.core.utils.CoreUtils.getDistance(u.x, u.y, bullet.x, bullet.y)) - bullet.card.bulletDamageArea - u.card.sizeH;
			if( ((bullet.card.bulletDamage < 0 && u.side == bullet.side) || (bullet.card.bulletDamage >= 0 && (u.side != bullet.side || bullet.card.explosive))) && distance <= 0 )
			{
				u.hit(bullet.card.bulletDamage);
	#if java
				hitUnits.add(u.id);
	#end
			}
		}
	#if java
		if( unitsHitCallback != null )
			unitsHitCallback.hit(bullet.id, hitUnits);
	#end
	}
	
	public function requestKillPioneers(side:Int) : Void
	{
		if( state > STATE_2_STARTED )
			return;
		pioneerSide = side;
		resetTime = now + 2000;
		pauseTime = now;
		state = STATE_3_PAUSED;
	}

	function killPioneers() : Void
	{
		pauseTime = now + 2000000; 
		resetTime = now + 2000000;
		for( unit in this.units )
		{
			if( unit.disposed() )
				continue;
			if( unit.side == pioneerSide )
			{
				if( pioneerSide == 0 && unit.y < HEIGHT * 0.5 )
						unit.dispose();
				else if( pioneerSide == 1 && unit.y > HEIGHT * 0.5 )
						unit.dispose();
			}
		}
		state = STATE_2_STARTED;
	}
	
	public function dispose() : Void
	{
		state = STATE_5_DISPOSED;
		// dispose all units
		for( unit in this.units )
			unit.dispose();
		this.units = null;
		
		// dispose all bullets
		for( bullet in this.bullets )
			bullet.dispose();
		this.bullets = null;
	}
	
	public function getColorIndex(side:Int) : Int
	{
		return side == this.side ? 0 : 1;
	}
	public function getTime(index:Int):Int
	{
		if( field == null || index < 0 || index > 3 )
			return 0;
		return field.times.get(index) + extraTime;
	}

	private function fireEvent(dispatcherId:Int, type:String, data:Any) : Void
	{
		trace("fireEvent => id:" + dispatcherId + ", type:" + type + ", data:" + data);
		#if java
		// if( eventCallback != null )
		// 	eventCallback.dispatch(dispatcherId, type, data);
		#elseif flash
		dispatchEvent(new com.gerantech.mmory.core.events.BattleEvent(type, data));
		#end
	}

	public function getSummonState(side:Int):Int
	{
		if( field.mode == Challenge.MODE_1_TOUCHDOWN )
			return SUMMON_AREA_THIRD;
		
		// Get unit
		var leftUnitID = side == 0 ? 4 : 3;
		var rightUnitID = side == 0 ? 2 : 5;
		var leftUnit = getUnit(leftUnitID);
		var rightUnit = getUnit(rightUnitID);

		// Check existance
		var hasLeft = leftUnit != null && !leftUnit.disposed();
		var hasRight = rightUnit != null && !rightUnit.disposed();
		
		// Return result
		if( hasLeft && hasRight )
			return SUMMON_AREA_HALF;
		if( hasRight )
			return SUMMON_AREA_RIGHT;
		if( hasLeft )
			return SUMMON_AREA_LEFT;
		return SUMMON_AREA_BOTH;
	}

	public function fixSummonPosition(point:Point2, cardType:Int, summonState:Int, side:Int = 0):Point2
	{
		if( point.x < SUMMON_PADDING )
			point.x = SUMMON_PADDING;
		if( point.x > WIDTH - SUMMON_PADDING )
			point.x = WIDTH - SUMMON_PADDING;
		if( point.y > HEIGHT - SUMMON_PADDING )
			point.y = HEIGHT - SUMMON_PADDING;

		var top:Float = SUMMON_PADDING;
		if( !CardTypes.isSpell(cardType) )
		{
			if( field.mode == Challenge.MODE_1_TOUCHDOWN )
			{
				top = HEIGHT * 0.6666 + SUMMON_PADDING;
			}
			else
			{
				if( summonState >= SUMMON_AREA_BOTH )
					top = HEIGHT * 0.3333 + SUMMON_PADDING;
				else if( point.x > WIDTH * 0.5 )
					top = HEIGHT * (summonState == SUMMON_AREA_RIGHT ? 0.3333 : 0.5) + SUMMON_PADDING;
				else
					top = HEIGHT * (summonState == SUMMON_AREA_LEFT ? 0.3333 : 0.5) + SUMMON_PADDING;
			}
		}
		if( point.y < top )
			point.y = top;

		return point;
	}

	public function validateSummonPosition(point:Point2):Bool
	{
		if( point.x < SUMMON_PADDING || point.x > WIDTH - SUMMON_PADDING )
			return false;
		if( point.y < SUMMON_PADDING || point.y > HEIGHT - SUMMON_PADDING )
			return false;
		return true;
	}
}