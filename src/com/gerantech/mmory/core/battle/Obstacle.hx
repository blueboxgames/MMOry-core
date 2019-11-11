package com.gerantech.mmory.core.battle;

import com.gerantech.colleagues.Shape;
import com.gerantech.colleagues.Colleague;

class Obstacle extends Colleague {
	public function new(x:Float, y:Float, width:Float, height:Float) {
		super(-1, null, null, 0, x, y, 0);
		this.shape = Shape.create_box(width, height);
		this.shape.colleague = this;
		this.shape.initialize();
		this.setStatic();
	}
}
