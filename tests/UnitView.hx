package;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import com.gerantech.colleagues.CMath;
import com.gerantech.mmory.core.battle.bullets.Bullet;
import com.gerantech.mmory.core.events.BattleEvent;
import flash.display.Stage;
import flash.display.Shape;
import com.gerantech.mmory.core.battle.units.Card;
import com.gerantech.mmory.core.battle.BattleField;
import com.gerantech.mmory.core.battle.units.Unit;

class UnitView extends Unit {
	private var view:Shape;
	private var range:Shape;
public function setV(v:Bool) {
	this.view.visible = this.range.visible = !v;
}
	public function new(parent:DisplayObjectContainer, id:Int, battleField:BattleField, card:Card, side:Int, x:Float, y:Float, z:Float) {
		super(id, battleField, card, side, x, y, z);

		this.view = new Shape();
		this.view.graphics.lineStyle(1, side == 0 ? 0x0000FF : 0xFF0000);
		if (shape.type == com.gerantech.colleagues.Shape.TYPE_CIRCLE) {
			this.view.graphics.drawCircle(0, 0, shape.radius);
		} else {
			for (i in 0...shape.vertexCount)
				if (i == 0)
					this.view.graphics.moveTo(shape.getX(i), shape.getY(i));
				else
					this.view.graphics.lineTo(shape.getX(i), shape.getY(i));
			this.view.graphics.lineTo(shape.getX(0), shape.getY(0));
		}
		this.view.x = this.x;
		this.view.y = this.y;
		parent.addChild(view);

		this.range = new Shape();
		this.range.graphics.lineStyle(1, 0x00FF00);
		this.range.graphics.drawCircle(0, 0, card.focusRange+1);
		this.range.graphics.lineStyle(1, 0xFF0000);
		this.range.graphics.drawCircle(0, 0, card.bulletRangeMax);
		this.range.scaleY = BattleField.CAMERA_ANGLE;
		this.range.alpha = 0.2;
		this.range.x = this.x;
		this.range.y = this.y;
		parent.addChild(range);
	}

	override function setPosition(x:Float, y:Float, z:Float, forced:Bool = false):Bool {
		if (disposed() || !super.setPosition(x, y, z, forced) )
			return false;
		if (this.view != null) {
			this.view.x = this.x;
			this.view.y = this.y;
			this.range.x = this.x;
			this.range.y = this.y;
		}
		return true;
	}

	override function fireEvent(dispatcherId:Int, type:String, data:Any) {
		if (type == BattleEvent.ATTACK) {
			var target = cast(data, Unit);
			var b = new Bullet(battleField, bulletId, card, side, x, y, 0, target.x, target.y, 0);
			b.targetId = target.id;
			battleField.bullets.set(bulletId, b);
			bulletId++;
		}
		super.fireEvent(dispatcherId, type, data);
	}

	override function dispose() {
		this.view.parent.removeChild(this.view);
		this.range.parent.removeChild(this.range);
		super.dispose();
	}
}
