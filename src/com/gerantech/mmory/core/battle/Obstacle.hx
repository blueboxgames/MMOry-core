package com.gerantech.mmory.core.battle;

import com.gerantech.colleagues.Shape;
import com.gerantech.colleagues.Colleague;

class Obstacle extends Colleague {
	public function new(data:Dynamic) {
		if (data.shape.type == "rect") {
			super(-1, null, null, 0, data.transform.tx + data.shape.width * 0.5, data.transform.ty + data.shape.height * 0.5, 0);
			this.shape = Shape.create_box(data.shape.width * 0.5, data.shape.height * 0.5);
		} else if (data.shape.type == "path") {
			super(-1, null, null, 0, data.transform.tx, data.transform.ty, 0);
			this.shape = Shape.create_poly(cast(data.shape.path, String).split(" "));
		}

		this.shape.colleague = this;
		this.shape.initialize();
		this.setStatic();
	}
}
