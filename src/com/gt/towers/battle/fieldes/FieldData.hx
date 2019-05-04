package com.gt.towers.battle.fieldes;
import com.gt.towers.battle.tilemap.TileMap;
import com.gt.towers.utils.lists.IntList;
import haxe.Json;

/**
 * @author Mansour Djawadi
 */
class FieldData
{
	public var mode:Int;
	public var json:Dynamic;
	public var times:IntList;
	public var mapData:String;
	public var tileMap:TileMap;

	public function new(mode:Int, mapData:String, times:String) 
	{
		this.mode = mode;
		this.mapData = mapData;
		this.times = IntList.parse(times);
		
		// parse json layout and occupy tile map
		this.tileMap = new TileMap();
		this.json = Json.parse(mapData);
		if( this.json.layout != null )
		{
			var obstacles:Array<Dynamic> = json.layout.children[1].children;
			for( obs in obstacles )
				this.tileMap.setTileState(obs.params.x - 25 * obs.params.scaleX, obs.params.y - 25 * obs.params.scaleY, 50 * obs.params.scaleX, 50 * obs.params.scaleY, TileMap.STATE_OCCUPIED);
		}
	}
	
	public function isOperation() : Bool
	{
		return false;
	}
}