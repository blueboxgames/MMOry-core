package com.gerantech.colleagues;

class Shape {
	static public var TYPE_CIRCLE:Int = 0;
	static public var TYPE_POLY:Int = 1;

	public var type:Int = 0;
	public var radius:Float = 0;
	public var vertexCount:Int = 0;
	public var colleague:Colleague;

	public var matrix:Array<Float>;

	private var normals:Array<Float>;
	private var vertices:Array<Float>;

	static public function create_circle(radius:Float):Shape {
		return new Shape(TYPE_CIRCLE, radius);
	}

	static public function create_box(hw:Float, hh:Float):Shape {
		var shape = new Shape(TYPE_POLY, Math.max(hw, hh));
		shape.vertexCount = 4;
		shape.set(0, -hw, -hh);
		shape.set(1, hw, -hh);
		shape.set(2, hw, hh);
		shape.set(3, -hw, hh);
		shape.setNormal(0, 0.0, -1.0);
		shape.setNormal(1, 1.0, 0.0);
		shape.setNormal(2, 0.0, 1.0);
		shape.setNormal(3, -1.0, 0.0);
		return shape;
	}

	static public function create_poly(path:Array<Dynamic>):Shape {
		var shape = new Shape(TYPE_POLY, 100);
		var len = Math.floor(path.length / 3);
		var _xs = new Array<Float>();
		var _ys = new Array<Float>();
		for (i in 0...len) {
			_xs.push(Std.parseFloat(path[i * 3 + 1]));
			_ys.push(Std.parseFloat(path[i * 3 + 2]));
		}

		// Find the right most poon:Int the hull
		var rightMost = 0;
		var highestXCoord = _xs[0];
		var dx:Float = 0;
		var dy:Float = 0;
		for (i in 0...len) {
			var ax = _xs[i];
			var ay = _ys[i];
			if (dx < ax)
				dx = ax;
			if (dy < ay)
				dy = ay;

			var x = _xs[i];
			if (x > highestXCoord) {
				highestXCoord = x;
				rightMost = i;
			}
			// If matching x then take farthest negative y
			else if (x == highestXCoord) {
				if (_ys[i] < _ys[rightMost])
					rightMost = i;
			}
		}
		// shape.width = dx;
		// shape.height = dy;
		shape.radius = Math.sqrt(dx * dx + dy * dy);
		// trace(radius, dx, dy);
		var hull = new Array<Int>(); // MAX_POLY_VERTEX_COUNT
		var outCount:Int = 0;
		var indexHull:Int = rightMost;

		while (true) {
			hull[outCount] = indexHull;

			// Search for next index that wraps around the hull
			// by computing cross products to find the most counter-clockwise
			// vertex in the set, given the previos hull index
			var nextHullIndex:Int = 0;
			for (i in 0...len) {
				// Skip if same coordinate as we need three unique
				// points in the set to perform a cross product
				if (nextHullIndex == indexHull) {
					nextHullIndex = i;
					continue;
				}

				// Cross every set of three unique vertices
				// Record each counter clockwise third vertex and add
				// to the output hull
				// See : http://www.oocities.org/pcgpe/math2d.html
				// var e1:Vec2 = verts[nextHullIndex].sub(verts[hull[outCount]]);
				var e1x = _xs[nextHullIndex] - _xs[hull[outCount]];
				var e1y = _ys[nextHullIndex] - _ys[hull[outCount]];
				// var e2:Vec2 = verts[i].sub(verts[hull[outCount]]);
				var e2x = _xs[i] - _xs[hull[outCount]];
				var e2y = _ys[i] - _ys[hull[outCount]];
				// var c:Float = Vec2.crossVV(e1, e2);//a.x * b.y - a.y * b.x
				var c = e1x * e2y - e1y * e2x;
				if (c < 0.0)
					nextHullIndex = i;

				// Cross product is zero then e vectors are on same line
				// therefore want to record vertex farthest along that line
				if (c == 0.0 && e2x * e2x + e2y * e2y > e1x * e1x + e1y * e1y)
					nextHullIndex = i;
			}

			outCount++;
			indexHull = nextHullIndex;

			// Conclude algorithm upon wrap-around
			if (nextHullIndex == rightMost) {
				shape.vertexCount = outCount;
				break;
			}
		}

		// Copy vertices into shape's vertices
		for (i in 0...shape.vertexCount)
			shape.set(i, _xs[i], _ys[i]); // vertices[i].set(verts[hull[i]].x, verts[hull[i]].y);
		
		// Compute face normals
		for (i in 0...shape.vertexCount) {
			// var face:Vec2 = vertices[(i + 1) % vertexCount].sub(vertices[i]);
			var nx = shape.getX((i + 1) % shape.vertexCount) - shape.getX(i);
			var ny = shape.getY((i + 1) % shape.vertexCount) - shape.getY(i);

			// Calculate normal with 2D cross product between vector and scalar
			// normals[i].set(face.y, -face.x);
			// shape.setNormal(i, nx, -ny);
			shape.setNormalX(i, CMath.vector_normalizeX(ny, -nx));
			shape.setNormalY(i, CMath.vector_normalizeY(ny, -nx));
			// normals[i].normalize();
		}
		return shape;
	}

	public function new(type:Int, radius:Float) {
		this.type = type;
		this.radius = radius;
		this.normals = new Array();
		this.vertices = new Array();
		this.matrix = [1.0, 0.0, 0.0, 1.0];
	}

	public function initialize() {
		computeMass(1.0);
	}

	public function computeMass(density:Float):Void {
		if (type == TYPE_CIRCLE) {
			colleague.mass = Math.PI * radius * radius * density;
			colleague.invMass = (colleague.mass != 0.0) ? 1.0 / colleague.mass : 0.0;
			return;
		}

		// centroid 
		var cx:Float = 0;
		var cy:Float = 0;
		var area = 0.0;
		var I = 0.0;
		var k_inv3 = 1.0 / 3.0;

		for (i in 0...vertexCount) {
			var px1 = getX(i);
			var py1 = getY(i);
			var px2 = getX((i + 1) % vertexCount);
			var py2 = getY((i + 1) % vertexCount);

			var D = px1 * py2 - py1 * px2;
			var triangleArea = 0.5 * D;

			area += triangleArea;

			// Use area to weight the centroid average, not just vertex position
			var weight = triangleArea * k_inv3;
			cx += px1 * weight;
			cy += py1 * weight;
			cx += px2 * weight;
			cy += py2 * weight;

			// var intx2 = p1.x * p1.x + p2.x * p1.x + p2.x * p2.x;
			// var inty2 = p1.y * p1.y + p2.y * p1.y + p2.y * p2.y;
			var intx2 = px1 * px1 + px2 * px1 + px2 * px2;
			var inty2 = py1 * py1 + py2 * py1 + py2 * py2;
			I += (0.25 * k_inv3 * D) * (intx2 + inty2);
		}

		cx *= (1.0 / area);
		cy *= (1.0 / area);

		// Translate vertices to centroid (make the centroid (0, 0)
		// for the polygon in model space)
		// Not really necessary, but I like doing this anyway
		for (i in 0...vertexCount)
			set(i, getX(i) - cx, getY(i) - cy);

		colleague.mass = density * area;
		colleague.invMass = (colleague.mass != 0.0) ? 1.0 / colleague.mass : 0.0;
		CMath.matrix_rotate(matrix, 0);
	}

	public function set(index:Int, x:Float, y:Float):Void {
		this.vertices[index * 2] = x;
		this.vertices[index * 2 + 1] = y;
	}

	private function setX(index:Int, value:Float):Float {
		return this.vertices[index * 2] = value;
	}

	private function setY(index:Int, value:Float):Float {
		return this.vertices[index * 2 + 1] = value;
	}

	public function getX(index:Int):Float {
		return this.vertices[index * 2];
	}

	public function getY(index:Int):Float {
		return this.vertices[index * 2 + 1];
	}

	private function setNormal(index:Int, x:Float, y:Float):Void {
		this.normals[index * 2] = x;
		this.normals[index * 2 + 1] = y;
	}

	private function setNormalX(index:Int, x:Float):Float {
		return this.normals[index * 2] = x;
	}

	private function setNormalY(index:Int, y:Float):Float {
		return this.normals[index * 2 + 1] = y;
	}

	public function getNormalX(index:Int):Float {
		return this.normals[index * 2];
	}

	public function getNormalY(index:Int):Float {
		return this.normals[index * 2 + 1];
	}
}
