package com.gerantech.mmory.core.battle.fieldes;

import com.gerantech.colleagues.Colleagues2d;
import haxe.Json;
import com.gerantech.mmory.core.utils.lists.IntList;

/**
 * @author Mansour Djawadi
 */
class FieldData {
	public var mode:Int;
	public var json:Dynamic;
	public var times:IntList;
	public var mapData:String;
	public var physics:Colleagues2d;
	public var targets:Array<Float>;

	public function new(mode:Int, mapData:String, ?arg:Dynamic = null) {
		this.mode = mode;
		this.mapData = mapData;
		this.times = new IntList();
		this.times.push(60);
		this.times.push(120);
		this.times.push(180);
		this.times.push(240);

		this.targets = new Array();
		this.physics = new Colleagues2d(BattleField.DELTA_TIME);
		this.mapData = mapData;
		this.json = Json.parse(mapData);
		var children:Array<Dynamic> = this.json.children[0].artboard.children;

		for (o in children) {
			if (o.name == "obstacle") {
				this.physics.add(new Obstacle(o.transform.tx + o.shape.width * 0.5, o.transform.ty + o.shape.height * 0.5, o.shape.width * 0.5, o.shape.height * 0.5));
			} else if (o.name == "target") {
				this.targets.unshift(o.transform.ty);
				this.targets.unshift(o.transform.tx);
			}
		}
	}

	public function isOperation():Bool {
		return false;
	}
}
