package com.gt.towers;
import com.gt.towers.InitData;
import com.gt.towers.Player;
import com.gt.towers.scripts.ScriptEngine;
import com.gt.towers.constants.CardFeatureType;
import com.gt.towers.others.Arena;
import com.gt.towers.constants.CardTypes;
import com.gt.towers.constants.ResourceType;
import com.gt.towers.exchanges.Exchanger;
import com.gt.towers.socials.Lobby;
import com.gt.towers.utils.maps.IntArenaMap;

/**
 * ...
 * @author Mansour Djawadi
 */
class Game
{
	public var loginData:LoginData = new LoginData(); 
	public var appVersion:Int;
	public var market:String;
	public var sessionsCount:Int;
	public var exchanger:Exchanger;
	public var levels:Array<Int>;
	public var arenas:IntArenaMap;
	public var player:Player;
	public var lobby:Lobby;

	public function new()
	{
		levels = [0, 20, 50, 100, 200, 400, 1000, 2000, 5000, 10000, 20000, 40000, 80000];
	}
	function init(data:InitData) 
	{
		appVersion = data.appVersion;
		market = data.market;
		sessionsCount = data.sessionsCount;
		fillArenas();
		player = new Player(this, data);
		exchanger = new Exchanger(this);
		lobby = new Lobby(this);
	}
	
	function fillArenas() : Void
	{
		arenas = new IntArenaMap();
	  //						Arena(num   ,	min ,	max , minWinrate));
		arenas.set(	0	, new Arena(	0	,	0	,	100	,	-8	));
		arenas.set(	1	, new Arena(	1	,	101	,	200	,	-7	));
		arenas.set(	2	, new Arena(	2	,	201	,	300	,	-6	));
		arenas.set(	3	, new Arena(	3	,	301	,	400	,	-5	));
		arenas.set(	4	, new Arena(	4	,	401	,	500	,	-4	));
		arenas.set(	5	, new Arena(	5	,	501	,	600	,	-3	));
		arenas.set(	6	, new Arena(	6	,	601	,	730	,	-2	));
		arenas.set(	7	, new Arena(	7	,	731	,	860	,	-1	));
		arenas.set(	8	, new Arena(	8	,	861	,	1000	,	0	));
		arenas.set(	9	, new Arena(	9	,	1001	,	1160	,	0	));
		arenas.set(	10	, new Arena(	10	,	1161	,	1320	,	0	));
		arenas.set(	11	, new Arena(	11	,	1321	,	1500	,	0	));
		arenas.set(	12	, new Arena(	12	,	1501	,	1740	,	0	));
		arenas.set(	13	, new Arena(	13	,	1741	,	1960	,	0	));
		arenas.set(	14	, new Arena(	14	,	1961	,	2200	,	0	));
		arenas.set(	15	, new Arena(	15	,	2201	,	2460	,	0	));
		arenas.set(	16	, new Arena(	16	,	2461	,	2720	,	0	));
		arenas.set(	17	, new Arena(	17	,	2721	,	3000	,	0	));
		arenas.set(	18	, new Arena(	18	,	3001	,	3500	,	0	));
		arenas.set(	19	, new Arena(	19	,	3501	,	4000	,	0	));
		arenas.set(	20	, new Arena(	20	,	4001	,	4500	,	0	));
		arenas.set(	21	, new Arena(	21	,	4501	,	5350	,	0	));
		arenas.set(	22	, new Arena(	22	,	5351	,	6150	,	0	));
		arenas.set(	23	, new Arena(	23	,	6151	,	7000	,	0	));
		arenas.set(	24	, new Arena(	24	,	7001	,	8000	,	0	));
		arenas.set(	25	, new Arena(	25	,	8001	,	9000	,	0	));
		arenas.set(	26	, new Arena(	26	,	9001	,	10000	,	0	));
		arenas.set(	27	, new Arena(	27	,	10001	,	12000	,	0	));
		arenas.set(	28	, new Arena(	28	,	12001	,	14000	,	0	));
		arenas.set(	29	, new Arena(	29	,	14001	,	16000	,	0	));
		arenas.set(	30	, new Arena(	30	,	16001	,	18000	,	0	));
		arenas.set(	31	, new Arena(	31	,	18001	,	200000	,	0	));	
	}
	
	/*public function unlockedBuildingAt ( type:Int ) : Int
	{
		var arenaIndex = 0;
		var arenaKeys = arenas.keys();
		while ( arenaIndex < arenaKeys.length )
		{
			var cardIndex = 0;
			var arena = arenas.get(arenaKeys[arenaIndex]);
			while ( cardIndex <  arena.cards.size() )
			{
				if( arena.cards.get(cardIndex) == type )
					return arenaIndex;
				cardIndex ++;
			}
			arenaIndex ++;
		}
		return 100;
	}*/
	public function getBuildingAvailablity(type:Int =-1) : Int
	{
		if( !ResourceType.isCard(type) )
			return CardTypes.AVAILABLITY_EXISTS;
		if( player.cards.exists(type) )
			return CardTypes.AVAILABLITY_EXISTS;
		return ScriptEngine.getInt(CardFeatureType.F01_AVAILABLE_AT, type, 1) <= player.get_arena(0) ? CardTypes.AVAILABLITY_WAIT : CardTypes.AVAILABLITY_NOT;
	}
}