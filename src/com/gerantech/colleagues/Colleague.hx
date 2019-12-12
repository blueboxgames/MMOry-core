package com.gerantech.colleagues;

import com.gerantech.mmory.core.battle.GameObject;

class Colleague extends GameObject {
	public var mass:Float = 0;
	public var invMass:Float = 0;
	public var shape:Shape;

	public function setStatic() {
		mass = 0.0;
		invMass = 0.0;
	}
	
	#if flash
	public function show(parent:flash.display.DisplayObjectContainer):flash.display.Shape {
		var view = new flash.display.Shape();
		view.graphics.lineStyle(1, side == 0 ? 0x0000FF : 0xFF0000, mass > 100000 ? 0.3:1);
		if (shape.type == com.gerantech.colleagues.Shape.TYPE_CIRCLE) {
			view.graphics.drawCircle(0, 0, shape.radius);
		} else {
			for (i in 0...shape.vertexCount)
				if (i == 0)
					view.graphics.moveTo(shape.getX(i), shape.getY(i));
				else
					view.graphics.lineTo(shape.getX(i), shape.getY(i));
			view.graphics.lineTo(shape.getX(0), shape.getY(0));
		}
		view.x = this.x;
		view.y = this.y;
		parent.addChild(view);
		return view;
	}
	#end
}
