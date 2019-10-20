package com.gerantech.mmory.core.battle.fieldes;
import haxe.Json;
import com.gerantech.mmory.core.battle.tilemap.TileMap;
import com.gerantech.mmory.core.utils.lists.IntList;

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

	public function new(mode:Int, mapData:String, ?arg:Dynamic = null) 
	{
		this.mode = mode;
		this.mapData = mapData;
		this.times = new IntList();
		this.times.push(60);
		this.times.push(120);
		this.times.push(180);
		this.times.push(240);
		
		// var version = cast(arg, Int);
		// trace("version==>" + version);
		// parse json layout and occupy tile map
		this.tileMap = new TileMap();
		this.mapData = mapData;
		this.json = Json.parse(mapData);
		var children:Array<Dynamic> = this.json.children[0].artboard.children;
		for( o in children )
			if( o.name == "obstacle" )
				this.tileMap.setTileState(o.transform.tx, o.transform.ty, o.shape.width, o.shape.height, TileMap.STATE_OCCUPIED);
	}
	
	public function isOperation() : Bool
	{
		return false;
	}
}
