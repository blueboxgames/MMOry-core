package com.gt.towers.battle;
import com.gt.towers.Game;
import com.gt.towers.battle.fieldes.FieldData;
import com.gt.towers.battle.tilemap.TileMap;
import com.gt.towers.battle.units.Card;
import com.gt.towers.socials.Challenge;
import com.gt.towers.utils.lists.FloatList;
import com.gt.towers.utils.lists.IntList;
import com.gt.towers.utils.maps.IntBulletMap;
import com.gt.towers.utils.maps.IntCardMap;
import com.gt.towers.utils.maps.IntIntCardMap;
import com.gt.towers.utils.maps.IntUnitMap;

/**
 * ...
 * @author Mansour Djawadi
 */
class BattleField
{
	static public var POPULATION_MAX:Int = 10;
	static public var POPULATION_INIT:Int = 7;
	static public var WIDTH:Int = 960;
	static public var HEIGHT:Int = 1280;
	static public var PADDING:Int = 100;
	
	static public var STATE_0_WAITING:Int = 0;
	static public var STATE_1_CREATED:Int = 1;
	static public var STATE_2_STARTED:Int = 2;
	static public var STATE_3_PAUSED:Int = 3;
	static public var STATE_4_ENDED:Int = 4;
	static public var STATE_5_DISPOSED:Int = 5;
	
	static public var CAMERA_ANGLE:Float = 0.766;// sin of 50 angle
	static public var DEBUG_MODE:Bool = false;
	static public var DELTA_TIME:Int = 25;
	
	public var state:Int = 0;
	public var elixirBar:FloatList;
	public var singleMode:Bool;
	public var friendlyMode:Int;
	public var field:FieldData;
	public var difficulty:Int;
	public var arena:Int;
	public var extraTime:Int = 0;
	public var decks:IntIntCardMap;
	public var units:IntUnitMap;
	public var bullets:IntBulletMap;
	public var now:Float = 0;
	public var startAt:Int = 0;
	public var deltaTime:Int = 25;
	public var side:Int = 0;
	public var spellId:Int = 1000000;
	public var elixirSpeeds:FloatList = new  FloatList();
	public var games:Array<Game>;
	public var numSummonedUnits:Int;
	public var pauseTime:Float;
	var garbage:IntList;
	var resetTime:Float = -1;
#if java 
	public var unitsHitCallback:com.gt.towers.interfaces.IUnitHitCallback;
	var unitId:Int = 0;
#end

	public function new(){}
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
		//trace("this.startAt:" + this.startAt + " now:" + this.now + " this.resetTime:" + this.resetTime);
		
		garbage = new IntList();
		units = new IntUnitMap();
		bullets = new IntBulletMap();
		elixirSpeeds.push(1);
		elixirSpeeds.push(1);
		
		games = new Array<Game>();
		games[0] = game_0;
		games[1] = game_1;
		#if java
		
		if( singleMode )
		{
			var winRate = game_0.player.getResource(com.gt.towers.constants.ResourceType.R16_WIN_RATE);
			if( winRate < -100000 )
				winRate = 21474836;
			arena = game_0.player.get_arena(0);
			if( winRate > 2 )
				difficulty = arena + winRate - 2;
			else if( winRate < -2 )
				difficulty = arena + winRate + 2;
			else
				difficulty = arena;
			
			if( difficulty != 0 )
			{
				var ep:Int = game_0.player.get_point() + Math.round(Math.pow(1.2, Math.abs(difficulty) ) * difficulty / Math.abs(difficulty)) + difficulty * 5;
				if( ep > 100000 )
					ep = 100000;
				game_1.player.resources.set(com.gt.towers.constants.ResourceType.R2_POINT, ep);
			}
			//game_1.player.resources.set(com.gt.towers.constants.ResourceType.R1_XP, game_1.player.get_point() * 6 + 1);
			game_1.player.resources.set(com.gt.towers.constants.ResourceType.R1_XP, game_0.player.get_xp() + (game_1.player.get_point() - game_0.player.get_point())* 6 + 1);
			game_1.player.fillCards();
			
			if( difficulty != 0 )
			{
				var arenaScope = game_0.arenas.get(arena).max - game_0.arenas.get(arena).min;
				game_1.player.resources.set(com.gt.towers.constants.ResourceType.R2_POINT,	Math.round( Math.max(0, game_0.player.get_point() + Math.random() * arenaScope - arenaScope * 0.5) ) );
			}
		}
		
		// bot elixir is easier and player elixir is faster in tutorial
		elixirSpeeds.set(0, games[0].player.get_battleswins() < 3 ? 2 : 1);
		elixirSpeeds.set(1, Math.min(1, games[0].player.get_battleswins() / 5));
		
		// create castles
		if( field.mode != Challenge.MODE_1_TOUCHDOWN )
		{
			while ( unitId < 6 )
			{
				var side = unitId % 2;
				var hqType = field.mode == Challenge.MODE_0_HQ ? 201 : 221;
				var heroType = field.mode == Challenge.MODE_0_HQ ? 222 : 223;
				var card = new com.gt.towers.battle.units.Card(games[side], unitId > 1 ? heroType : hqType, friendlyMode > 0 ? 9 : games[side].player.get_level(0));
				var x = 480;
				var y = 70;
				if( unitId > 3 )
				{
					x = 160;
					y = 120;
				}
				else if( unitId > 1 )
				{
					x = 800;
					y = 120;
				}
				units.set(unitId, new com.gt.towers.battle.units.Unit(unitId, this, card, side, side == 0 ? BattleField.WIDTH - x : x, side == 0 ? BattleField.HEIGHT - y : y, 0));
				unitId ++;
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
		elixirBar = new FloatList();
		elixirBar.push(POPULATION_INIT);
		elixirBar.push(POPULATION_INIT);
	}
	
	static function getDeckCards(game:Game, cardsTypes:Array<Int>, friendlyMode:Int) : IntCardMap
	{
		var ret = new IntCardMap(); 
		var i:Int = 0;
		//trace("id: " + game.player.id + "-> " + cardsTypes.toString() + " friendlyMode:" + friendlyMode);
		while( i < cardsTypes.length )
		{
			if( game.player.cards.exists(cardsTypes[i]) )
				ret.set(cardsTypes[i], friendlyMode > 0 ? new Card(game,cardsTypes[i],9) : game.player.cards.get(cardsTypes[i]));
			i ++;
		}
		trace("id: " + game.player.id + "-> " + ret.queue_String());
		return ret;
	}
	
	public function update(deltaTime:Int) : Void
	{
		if( state < STATE_1_CREATED || state > STATE_3_PAUSED )
			return;
		
		this.deltaTime = deltaTime;
		this.now += deltaTime;
		
		if( resetTime <= this.now )
			reset();
		if( pauseTime < now )
			return;
		if( state > STATE_2_STARTED )
			return;
		
		// -=-=-=-=-=-=-=-  UPDATE AND REMOVE UNITS  -=-=-=-=-=-=-=-=-=-
		garbage = new IntList();
		var keys = units.keys();
		var i = keys.length - 1;
		while ( i >= 0 )
		{
			if( units.get(keys[i]).disposed() )
				garbage.push(keys[i]);
			else
				units.get(keys[i]).update();
			i --;
		}
		// remove dead units
		while( garbage.size() > 0 )
			units.remove(garbage.pop());
		
		// -=-=-=-=-=-=-=-=-  UPDATE AND REMOVE BULLETS  -=-=-=-=-=-=-=-=-
		keys = bullets.keys();
		i = keys.length - 1;
		while ( i >= 0 )
		{
			if( bullets.get(keys[i]).disposed() )
				garbage.push(keys[i]);
			else
				bullets.get(keys[i]).update();
			i --;
		}
		// remove exploded bullets
		while( garbage.size() > 0 )
			bullets.remove(garbage.pop());
		
		// -=-=-=-=-=-=-=-=-=-=-  INCREASE ELIXIRS  -=-=-=-=-=-=-=-=-=-=-=-
		var increaseSpeed = getElixirIncreaseSpeed() * deltaTime;
		elixirBar.set(0, Math.min(BattleField.POPULATION_MAX, elixirBar.get(0) + increaseSpeed * elixirSpeeds.get(0)));
		elixirBar.set(1, Math.min(BattleField.POPULATION_MAX, elixirBar.get(1) + increaseSpeed * elixirSpeeds.get(1)));
		
		//trace("elixirBar: " + elixirBar.toString() + "  playerSpeed: " + elixirSpeeds.get(0) + "  robotSpeed: " + elixirSpeeds.get(1) + "  increaseSpeed: " + increaseSpeed);
	}
	
	public function getElixirIncreaseSpeed() : Float
	{
		return (getDuration() > getTime(1) ? 0.00066 : 0.00033);
	}
	
	public function getDuration() : Float
	{
		return now / 1000 - startAt;
	}
	
	#if java
	public function summonUnit(type:Int, side:Int, x:Float, y:Float) : Int
	{
		var index = cardAvailabled(side, type);
		if( index < 0 )
		{
			//trace("summon  => side:" + side + " type:" + type + " error: " + index);
			return index;
		}
		
		if( side == 0 && games[0].player.get_battleswins() < 2 )
		{
			numSummonedUnits ++;
			if( numSummonedUnits == 1 )
				pauseTime = now + 1200;
			else if( numSummonedUnits == 2 )
				pauseTime = now + 2000000;
		}
		
		var card = decks.get(side).get(type);
		var log:String = null;
		if( BattleField.DEBUG_MODE )
			log = "queue: " + decks.get(side).queue_String() + " => side:" + side + " type:" + type + " index:" + index; 
		
		decks.get(side).queue_removeAt(index);
		decks.get(side).enqueue(type);
		
		if( BattleField.DEBUG_MODE )
		{
			log += " => " + decks.get(side).queue_String();
			trace(log);
		}
		
		elixirBar.set(side, elixirBar.get(side) - card.elixirSize );
		
		if( com.gt.towers.constants.CardTypes.isSpell(type) )
			return addSpell(card, side, x, y);
		
		var i = card.quantity - 1;
		while( i >= 0 )
		{
			var tile = field.tileMap.findTile(com.gt.towers.utils.CoreUtils.getXPosition(card.quantity, i, x), com.gt.towers.utils.CoreUtils.getYPosition(card.quantity, i, y), side == 0 ? 1 : -1, TileMap.STATE_EMPTY);
			if( tile == null )
				trace("tile not found!");
				
			var unit = new com.gt.towers.battle.units.Unit(unitId, this, card, side, tile.x, tile.y, 0);
			units.set(unitId, unit);
			//trace("summon id:" + unitId + " type:" + type + " side:" + side + " x:" + x + " ux:" + unit.x + " y:" + y + " uy:" + unit.y );
			unitId ++;
			i --;
		}
		return unitId - 1;
	}
	
	function addSpell(card:com.gt.towers.battle.units.Card, side:Int, x:Float, y:Float) : Int
	{
		var offset = com.gt.towers.utils.GraphicMetrics.getSpellStartPoint(card.type);
		var spell = new com.gt.towers.battle.bullets.Bullet(this, spellId, card, side, x + offset.x, y + offset.y, offset.z, x, y, 0);
		bullets.set(spellId, spell);
		spellId ++;
		return spellId - 1;
	}
	
	public function addBullet(unit:com.gt.towers.battle.units.Unit, side:Int, x:Float, y:Float, target:com.gt.towers.battle.units.Unit) : Void 
	{
		var b = new com.gt.towers.battle.bullets.Bullet(this, unit.bulletId, unit.card, side, x, y, 0, target.x, target.y, 0);
		b.targetId = target.id;
		bullets.set(unit.bulletId, b);
		unit.bulletId ++;
	}
	
	public function explodeBullet(bullet:com.gt.towers.battle.bullets.Bullet) : Void
	{
		var u:com.gt.towers.battle.units.Unit;
		var distance:Float = 0;
		//var res = "Bullet=> type: " + bullet.card.type + ", id:" + bullet.id + ", damage:" + bullet.card.bulletDamage;
		var hitUnits:java.util.List<java.lang.Integer> = new java.util.ArrayList();
		var iterator : java.util.Iterator < java.util.Map.Map_Entry<Int, com.gt.towers.battle.units.Unit> > = units._map.entrySet().iterator();
        while ( iterator.hasNext() )
		{
			u = iterator.next().getValue();
			if( u.disposed() )
				continue;
			distance = Math.abs(com.gt.towers.utils.CoreUtils.getDistance(u.x, u.y, bullet.x, bullet.y)) - bullet.card.bulletDamageArea - u.card.sizeH;
			//res += " ,  distance: " + distance + ", bulletDamageArea:" + bullet.card.bulletDamageArea + ", sizeH:" + u.card.sizeH;
			if( ((bullet.card.bulletDamage < 0 && u.side == bullet.side) || (bullet.card.bulletDamage >= 0 && (u.side != bullet.side || bullet.card.explosive))) && distance <= 0 )
			{
				//res += "|" + u.id + " (" + u.health + ") => ";
				u.hit(bullet.card.bulletDamage);
				//res += "(" + u.health + ")";
				hitUnits.add(u.id);
			}
		}
		//if( bullet.card.type == 109 )
		//trace(res);
		if( unitsHitCallback != null )
			unitsHitCallback.hit(bullet.id, hitUnits);
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
			return com.gt.towers.constants.MessageTypes.RESPONSE_NOT_FOUND;
		
		if( !decks.get(side).exists(type) )
			return com.gt.towers.constants.MessageTypes.RESPONSE_NOT_ALLOWED;
		
		if( elixirBar.get(side) < decks.get(side).get(type).elixirSize )
			return com.gt.towers.constants.MessageTypes.RESPONSE_NOT_ENOUGH_REQS;
		
		var index = decks.get(side).queue_indexOf(type);
		if ( index < 0 || index > 3 )
		{
			trace(decks.get(side).queue_String());
			return com.gt.towers.constants.MessageTypes.RESPONSE_MUST_WAIT;
		}
		
		return index;
	}
	#end
	
	public function requestReset() : Void
	{
		if( state > STATE_2_STARTED )
			return;
		resetTime = now + 2000;
		state = STATE_3_PAUSED;
	}
	function reset() : Void
	{
		resetTime = now + 2000000;
		dispose();
		elixirBar.set(0, POPULATION_INIT);
		elixirBar.set(1, POPULATION_INIT);
		state = STATE_2_STARTED;
	}
	
	public function dispose() : Void
	{
		state = STATE_5_DISPOSED;
		// dispose all units
		var keys = units.keys();
		var i = keys.length - 1;
		while ( i >= 0 )
		{
			units.get(keys[i]).dispose();
			i --;
		}
		units.clear();
		
		// dispose all bullets
		keys = bullets.keys();
		i = keys.length - 1;
		while ( i >= 0 )
		{
			bullets.get(keys[i]).dispose();
			i --;
		}
		bullets.clear();
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
}