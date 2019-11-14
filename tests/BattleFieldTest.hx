package;

import com.gerantech.mmory.core.utils.CoreUtils;
import com.gerantech.mmory.core.battle.units.Card;
import com.gerantech.mmory.core.socials.Challenge;
import com.gerantech.mmory.core.utils.maps.IntIntMap;
import com.gerantech.mmory.core.utils.maps.IntIntCardMap;
import com.gerantech.colleagues.CMath;
import com.gerantech.colleagues.Shape;
import com.gerantech.mmory.core.Game;
import com.gerantech.mmory.core.InitData;
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
		var l = new URLLoader(new URLRequest("C:\\SmartFoxServer_2X\\SFS2X-5000\\www\\assets\\script-data.cs"));
		l.addEventListener(Event.COMPLETE, script_completeHandler);
	}

	private function script_completeHandler(event:Event):Void {
		ScriptEngine.initialize(event.currentTarget.data, 2700);
		this.challengeMode = ScriptEngine.getInt(ScriptEngine.T41_CHALLENGE_MODE, this.challengeIndex, 0, null, null);
		var l = new URLLoader(new URLRequest("C:\\SmartFoxServer_2X\\SFS2X-5000\\www\\assets\\map-" + this.challengeMode + ".json"));
		l.addEventListener(Event.COMPLETE, map_completeHandler);
	}
	
	private function map_completeHandler(event:Event):Void {
		var t = flash.Lib.getTimer();
		var field = new FieldData(this.challengeMode, event.currentTarget.data);
		var data = new InitData();
		data.id = 10004;
		data.resources.set(2, 100);
		data.decks.set(0, new IntIntMap());
		for (i in 101...109) {
			data.resources.set(i, 1);
			data.cardsLevel.set(i, 1);
			data.decks.get(0).set(i - 101, i);
		}
		var player = new Game();
		player.init(data);

		data.id = 1;
		var bot = new Game();
		bot.init(data);

		this.battleField = new BattleField();
		this.battleField.initialize(player, bot, field, 0, t / 1000, t, false, 0);

		var len = field.mode == Challenge.MODE_0_HQ ? 6 : 2;
		if( field.mode != Challenge.MODE_1_TOUCHDOWN )
		while (unitId < len) {
			var side = unitId % 2;
			var hqType = 201;
			if (field.mode == Challenge.MODE_1_TOUCHDOWN)
				hqType = 221;
			else if (field.mode == Challenge.MODE_2_BAZAAR)
				hqType = 202;
			var heroType = field.mode == Challenge.MODE_0_HQ ? 222 : 223;
			var card = new Card(battleField.games[side], unitId > 1 ? heroType : hqType,
				battleField.friendlyMode > 0 ? 9 : battleField.games[side].player.get_level(0));
			var x = Math.ffloor(field.targets[unitId * 2]);
			var y = Math.ffloor(field.targets[unitId * 2 + 1]) + (side == 0 ? - 64 : 64);
			if( x != BattleField.WIDTH * 0.5 )
				x += field.targets[unitId * 2] > BattleField.WIDTH * 0.5 ? 32 : -32;
			this.addUnit(card, side, x, y, card.z);
		}

		this.battleField.decks = new IntIntCardMap();
		this.battleField.decks.set(0,
			BattleField.getDeckCards(battleField.games[0], battleField.games[0].player.getSelectedDeck().toArray(true), battleField.friendlyMode));
		this.battleField.decks.set(1,
			BattleField.getDeckCards(battleField.games[1], battleField.games[1].player.getSelectedDeck().toArray(true), battleField.friendlyMode));
		this.battleField.state = BattleField.STATE_2_STARTED;

		for (c in this.battleField.field.physics.colleagues)
			if( Std.is(c, Obstacle))
				c.show(this);
		
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
		var card = this.battleField.decks.get(0).get(101 + Math.floor(Math.random() * 8));
		for (i in 0...card.quantity)
			this.addUnit(card, event.stageY > BattleField.HEIGHT * 0.5 * scaleY ? 0 : 1, CoreUtils.getXPosition(card.quantity, i, event.stageX/scaleX),
				CoreUtils.getYPosition(card.quantity, i, event.stageY/scaleY), card.z);
	}

	private function addUnit(card:Card, side:Int, x:Float, y:Float, z:Float):Void {
		var u = new UnitView(this, unitId, this.battleField, card, side, x, y, z);
		this.battleField.field.physics.add(u);
		this.battleField.units.set(unitId, u);
		unitId++;
	}

	private function this_enterFrameHandler(event:flash.events.Event):Void {
		this.battleField.update(cast(flash.Lib.getTimer() - this.battleField.now, Int));
		// this.draw();
	}
}
