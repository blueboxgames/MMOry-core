package;

import flash.display.DisplayObjectContainer;
import com.gerantech.mmory.core.battle.BattleField;
import com.gerantech.mmory.core.battle.bullets.Bullet;
import com.gerantech.mmory.core.battle.units.Card;
import com.gerantech.mmory.core.battle.units.Unit;
import com.gerantech.mmory.core.events.BattleEvent;
import flash.display.Shape;

class UnitView extends Unit {
	private var view:Shape;
	private var range:Shape;

	public function setV(v:Bool) {
		this.view.visible = this.range.visible = !v;
	}

	public function new(parent:DisplayObjectContainer, id:Int, battleField:BattleField, card:Card, side:Int, x:Float, y:Float, z:Float, t:Float) {
		super(id, battleField, card, side, x, y, z, t);

		this.view = this.show(parent);

		this.range = new Shape();
		this.range.graphics.lineStyle(1, 0x00FF00);
		this.range.graphics.drawCircle(0, 0, card.focusRange + 1);
		this.range.graphics.lineStyle(1, 0xFF0000);
		this.range.graphics.drawCircle(0, 0, card.bulletRangeMax);
		this.range.scaleY = BattleField.CAMERA_ANGLE;
		this.range.alpha = 0.2;
		this.range.x = this.x;
		this.range.y = this.y;
		parent.addChild(range);
	}

	override function setPosition(x:Float, y:Float, z:Float, forced:Bool = false):Bool {
		if (disposed() || !super.setPosition(x, y, z, forced))
			return false;
		if (this.view != null) {
			this.view.x = this.x;
			this.view.y = this.y;
			this.range.x = this.x;
			this.range.y = this.y;
		}
		return true;
	}

	override private function attack(enemy:Unit):Void {
		var b = new Bullet(battleField, this, enemy, bulletId, card, side, x, y, 0, enemy.x, enemy.y, 0);
		battleField.bullets.push(b);
		bulletId++;
		super.attack(enemy);
	}

	override function dispose() {
		if (this.view != null && this.view.parent != null)
			this.view.parent.removeChild(this.view);
		if (this.range != null && this.range.parent != null)
			this.range.parent.removeChild(this.range);
		super.dispose();
	}
}
