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
}
