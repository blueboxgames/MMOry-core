package;

import com.gerantech.mmory.core.Game;
import com.gerantech.mmory.core.InitData;
import com.gerantech.mmory.core.battle.Obstacle;
import com.gerantech.mmory.core.utils.CoreUtils;
import com.gerantech.mmory.core.battle.units.Card;
import com.gerantech.mmory.core.socials.Challenge;
import com.gerantech.mmory.core.utils.maps.IntIntMap;
import com.gerantech.mmory.core.utils.maps.IntIntCardMap;
import com.gerantech.mmory.core.battle.BattleField;
import com.gerantech.mmory.core.battle.fieldes.FieldData;
import com.gerantech.mmory.core.scripts.ScriptEngine;
import flash.net.URLRequest;
import flash.net.URLLoader;
import flash.events.MouseEvent;
import flash.events.Event;
import flash.display.Sprite;

class BattleFieldTest extends Sprite {
	static function main() {
		// flash.Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		flash.Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		flash.Lib.current.addChild(new BattleFieldTest());
	}

	private var playerId:Int = 10002;
	private var challengeIndex:Int = 0;

	private var skipDrawing:Bool;
	private var challengeMode:Int;
	private var battleField:BattleField;
	private var unitId:Int = 0;

	/* ENTRY POINT */
	public function new() {
		super();
		this.addEventListener(Event.ADDED_TO_STAGE, this.this_addedToStageHandler);
	}

	private function this_addedToStageHandler(event:Event):Void {
		this.removeEventListener(Event.ADDED_TO_STAGE, this.this_addedToStageHandler);
		scaleX = scaleY = stage.stageWidth / BattleField.WIDTH;
		var l = new URLLoader(new URLRequest("C:\\_projects\\mmories\\mmory-core\\src\\com\\gerantech\\mmory\\core\\scripts\\script-data.cs"));
		l.addEventListener(Event.COMPLETE, script_completeHandler);
	}

	private function script_completeHandler(event:Event):Void {
		ScriptEngine.initialize(event.currentTarget.data, 2700);
		this.challengeMode = ScriptEngine.getInt(ScriptEngine.T41_CHALLENGE_MODE, this.challengeIndex, playerId);
		var l = new URLLoader(new URLRequest("C:\\SmartFoxServer_2X\\SFS2X-5000\\www\\assets\\map-" + this.challengeMode + ".json"));
		l.addEventListener(Event.COMPLETE, map_completeHandler);
	}

	private function map_completeHandler(event:Event):Void {
		var t = flash.Lib.getTimer() + 0.0;
		var field = new FieldData(this.challengeMode, event.currentTarget.data);
		var data = new InitData();
		data.id = playerId;
		data.resources.set(2, 100);
		data.decks.set(0, new IntIntMap("0:101,1:102,2:103,3:104,4:105,5:106,6:116,7:119"));
		for (i in 0...8) {
			data.resources.set(data.decks.get(0).get(i), 1);
			data.cardsLevel.set(data.decks.get(0).get(i), 1);
		}
		var player = new Game();
		player.init(data);

		data.id = 1;
		var bot = new Game();
		bot.init(data);

		this.battleField = new BattleField();
		this.battleField.create(player, bot, field, 0, t, false, 0);

		// add inital units
		for(i in 0...6)
		{
			var data:Array<Int> = ScriptEngine.get(ScriptEngine.T54_CHALLENGE_INITIAL_UNITS, field.mode, i);
			var cardType = data[0];
			var side = cast(Math.max(data[1], 0), Int);
			// trace(i, field.mode, data);
			if( cardType > -1 )
			{
				var card = new com.gerantech.mmory.core.battle.units.Card(this.battleField.games[side], cardType, this.battleField.friendlyMode > 0 ? 9 : this.battleField.games[side].player.get_level(0));
				this.addUnit(card, data[1], Math.ffloor(field.targets[unitId * 2]), Math.ffloor(field.targets[unitId * 2 + 1]), card.z, t);
			}
		}

		// initialize decks
		this.battleField.decks = new IntIntCardMap();
		this.battleField.decks.set(0,
			BattleField.getDeckCards(battleField.games[0], battleField.games[0].player.getSelectedDeck().toArray(true), battleField.friendlyMode));
		this.battleField.decks.set(1,
			BattleField.getDeckCards(battleField.games[1], battleField.games[1].player.getSelectedDeck().toArray(true), battleField.friendlyMode));
		this.battleField.start(t, t);

		// draw obstacles
		for (c in this.battleField.field.ground.colleagues)
			if (Std.is(c, Obstacle))
				c.show(this);

		// draw targets
		var i = 0;
		this.graphics.beginFill(0xFFFFFF);
		while (i < this.battleField.field.targets.length) {
			this.graphics.drawCircle(this.battleField.field.targets[i], this.battleField.field.targets[i + 1], 3);
			i += 2;
		}

		this.addEventListener(Event.ENTER_FRAME, this.this_enterFrameHandler);
		this.stage.addEventListener(MouseEvent.CLICK, this.stage_clickHandler);
	}

	private function stage_clickHandler(event:MouseEvent):Void {
		if (event.altKey) {
			this.skipDrawing = !this.skipDrawing;
			for (b in this.battleField.units)
				cast(b, UnitView).setV(this.skipDrawing);
			return;
		}
		var cards = this.battleField.decks.get(0).keys();
		var card = this.battleField.decks.get(0).get(cards[cast(cards.length * Math.random(), Int)]);
		for (i in 0...card.quantity)
			this.addUnit(card, event.stageY > BattleField.HEIGHT * 0.5 * scaleY ? 0 : 1, CoreUtils.getXPosition(card.quantity, i, event.stageX / scaleX),
				CoreUtils.getYPosition(card.quantity, i, event.stageY / scaleY), card.z, this.battleField.now);
	}

	private function addUnit(card:Card, side:Int, x:Float, y:Float, z:Float, t:Float):Void {
		var u = new UnitView(this, unitId, this.battleField, card, side, x, y, z, t);
		if (card.z < 0)
			this.battleField.field.air.add(u);
		else
			this.battleField.field.ground.add(u);
		this.battleField.units.push(u);
		unitId++;
	}

	private function this_enterFrameHandler(event:flash.events.Event):Void {
		this.battleField.update(cast(flash.Lib.getTimer() - this.battleField.now, Int));
		// this.draw();
	}
}
