package com.gerantech.mmory.core.constants;

/**
 * ...
 * @author Mansour Djawadi
 */
import com.gerantech.mmory.core.scripts.ScriptEngine;

class CardFeatureType {
	public function new() {}

	#if flash
	private static var _all:Array<Int>;

	static public function getAll():Array<Int> {
		if (_all == null) {
			_all = new Array<Int>();

			_all.push(ScriptEngine.T03_QUANTITY);

			_all.push(ScriptEngine.T11_SPEED);
			_all.push(ScriptEngine.T12_HEALTH);
			_all.push(ScriptEngine.T13_SIZE_H);
			_all.push(ScriptEngine.T14_SIZE_V);

			_all.push(ScriptEngine.T22_BULLET_DAMAGE);
			_all.push(ScriptEngine.T23_BULLET_SHOOT_GAP);
			_all.push(ScriptEngine.T24_BULLET_SHOOT_DELAY);
			_all.push(ScriptEngine.T25_BULLET_RANGE_MIN);
			_all.push(ScriptEngine.T26_BULLET_RANGE_MAX);
			_all.push(ScriptEngine.T27_BULLET_DAMAGE_AREA);
			_all.push(ScriptEngine.T28_BULLET_EXPLODE_DElAY);
		}
		return _all;
	}

	static public function getRelatedTo(cardType:Int):Array<Int> {
		var ret = new Array<Int>();
		ret.push(ScriptEngine.T22_BULLET_DAMAGE);
		if (CardTypes.isSpell(cardType))
			return ret;
		ret.push(ScriptEngine.T23_BULLET_SHOOT_GAP);
		ret.push(ScriptEngine.T04_SUMMON_TIME);
		ret.push(ScriptEngine.T11_SPEED);
		ret.push(ScriptEngine.T12_HEALTH);
		ret.push(ScriptEngine.T26_BULLET_RANGE_MAX);
		return ret;
	}

	static public function getUIFactor(featureType:Int):Float {
		return switch (featureType) {
			/*case 5 : 1000;
				case 12: 50;
				case 21: 50;
				case 23: 0.2;
				case 24: 0.2; */
			case 4: 0.001;
			case 11: 1000;
			case 12: 50;
			case 22: 100;
			case 23: 0.01;
			case 26: 0.5;
			default: 1;
		}
	}
	/*static public function getChangables(game:Game, type:Int, level:Int):com.gerantech.mmory.core.utils.lists.IntList
		{
			var ret = new com.gerantech.mmory.core.utils.lists.IntList();
			var all = getAll();
			var i = 0;
			while ( i < all.size() )
			{
				if ( game.calculator.get(all.get(i), type, level) != game.calculator.get(all.get(i), type, level + 1) )
					ret.push(all.get(i));
				i ++;
			}
			return ret;
	}*/
	#end
}
