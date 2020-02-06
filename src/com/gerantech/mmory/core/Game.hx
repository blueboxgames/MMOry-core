package com.gerantech.mmory.core;
import com.gerantech.mmory.core.InitData;
import com.gerantech.mmory.core.Player;
import com.gerantech.mmory.core.exchanges.Exchanger;
import com.gerantech.mmory.core.others.Arena;
import com.gerantech.mmory.core.scripts.ScriptEngine;
import com.gerantech.mmory.core.socials.Lobby;
import com.gerantech.mmory.core.utils.maps.IntArenaMap;

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
	public function init(data:InitData) 
	{
		this.market = data.market;
		this.appVersion = data.appVersion;
		this.sessionsCount = data.sessionsCount;

		Arena.STEP = 0;
		this.arenas = new IntArenaMap();
		var ls:Array<Array<Any>> = ScriptEngine.get(ScriptEngine.T81_TROPHY_ROAD);
		for( i in 0...ls.length ) 
			this.arenas.set(i, new Arena(this, i,	i > 0 ? Std.int(ls[i - 1][0]) + 1 : -4, ls[i][0], ls[i][1], ls[i][2]));


		this.player = new Player(this, data);
		this.exchanger = new Exchanger(this);
		this.lobby = new Lobby(this);
	}
}