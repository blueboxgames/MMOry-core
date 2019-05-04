package com.gt.towers.battle.tilemap;
import com.gt.towers.utils.CoreUtils;
import com.gt.towers.utils.Point2;

/**
* ...
* @author Mansour Djawadi
*/
class TileMap
{
	static public var STATE_EMPTY:Int = 0;
	static public var STATE_OCCUPIED:Int = 0xFF0000;
	static public var STATE_UNIT:Int = 0xFF00FF;
	static public var STATE_TARGET:Int = 0x00FF00;
	static public var STATE_START:Int = 0xFFFF00;

	public var width:Int = 30;
	public var height:Int = 40;
	public var tileWidth:Int;
	public var tileHeight:Int;
	var map:Array<Array<Int>>;
	var target:Tile;
	var stack:Array<Tile>;
	var coordinates:Array<Int>;
	public function new() 
	{
		tileWidth = Math.floor( BattleField.WIDTH / width );
		tileHeight = Math.floor( BattleField.HEIGHT / height );
		
		map = new Array<Array<Int>>();
		var i:Int = 0;
		var j:Int = 0;
		while ( i < width )
		{
			map[i] = new Array<Int>();
			j = 0;
			while ( j < height )
			{
				map[i][j] = 0;
				j ++;
			}
			i ++;
		}
	}
	
	public function set(i:Int, j:Int, value:Int) : Void
	{
		map[i][j] = value;
	}
	public function get(i:Int, j:Int) : Int
	{
		return map[i][j];
	}
	public function getTile(x:Float, y:Float) : Tile
	{
		var t = instantiateTile(getI(x), getJ(y), 0, 0);
		setTilePosition(t);
		return t;
	}
	public function getI(x:Float) : Int
	{
		if( x < 0 )
			x = 0;
		if( x > BattleField.WIDTH - 1 )
			x = BattleField.WIDTH - 1;
		return Math.floor(x / tileWidth);
	}
	public function getJ(y:Float) : Int
	{
		if( y < 0 )
			y = 0;
		if( y > BattleField.HEIGHT - 1 )
			y = BattleField.HEIGHT - 1;
		return Math.floor(y / tileHeight);
	}
	
	function setTilePosition(tile:Tile) : Void
	{
		tile.x = tile.i * tileWidth + tileWidth * 0.5;
		tile.y = tile.j * tileHeight + tileHeight * 0.5;
	}
	
	public function inMap(i:Int, j:Int) : Bool
	{
		return i > -1 && j > -1 && i < width - 1 && j < height - 1;
	}
	
	public function setTileState(x:Float, y:Float, width:Float, height:Float, state:Int) : Void
	{
		//trace("x:" + x + " y:" + y + " w:" + width + " h:" + height + " s:" + state);
		var from = getTile(x, y);
		var to = getTile(x + width, y + height);
		var i:Int = from.i;
		var j:Int;
		while ( i <= to.i )
		{
			j = from.j;
			while ( j <= to.j )
			{
				//trace("i:" + i + " j:" + j + " state:" + state);
				set(i, j, state);
				j ++;
			}
			i ++;
		}
	}
	
	
	function stackNew() : Void
	{
		stack = new Array<Tile>();
		coordinates = new Array<Int>();
	}
	function stackAdd(tile:Tile) : Void
	{
		stack[tile.i + tile.j * width] = tile;
		coordinates.push(tile.i + tile.j * width);
	}
	function stackGet(i:Int, j:Int) : Tile
	{
		return stack[i + j * width];
	}
	function stackRemove(tile) : Void
	{
		disposeTile(tile);
		stack[tile.i + tile.j * width] = null;
	}
	public function findPath(sourceX:Float, sourceY:Float, destX:Float, destY:Float, side:Int , removeWrongs:Bool = true):Array<Point2>
	{
		var srcTile = getTile(sourceX, sourceY);
		var desTile = getTile(destX, destY);
		if( srcTile.i == desTile.i && srcTile.j == desTile.j )
			return null;
		set(desTile.i,	desTile.j,	STATE_START);
		set(srcTile.i,	srcTile.j,	STATE_TARGET);
		
		desTile.cost = desTile.last = 0;
		stackNew();
		stackAdd(desTile);
		//run recursive function to find the shortest path
		checkNeighbors(0, 1, side);
		
		/*if( !removeWrongs )
			return stack;*/
		
		// remove wrong ways
		var ret:Array<Point2> = new Array<Point2>();
		removeWrongTiles(ret, target);
		
		// tiles return to first states
		set(desTile.i, desTile.j, STATE_EMPTY);
		set(srcTile.i, srcTile.j, STATE_EMPTY);
		disposeTile(desTile);
		disposeTile(srcTile);
		target = null;
		
		for( m in stack )
			disposeTile(m);
		
		// remove backward ways
		while( ret.length > 1 )
		{
			//trace(CoreUtils.getNormalDistance(ret[0].x, ret[0].y, ret[1].x, ret[1].y) + " " + CoreUtils.getNormalDistance(sourceX, sourceY, ret[1].x, ret[1].y));
			if( CoreUtils.getNormalDistance(ret[0].x, ret[0].y, ret[1].x, ret[1].y) < CoreUtils.getNormalDistance(sourceX, sourceY, ret[1].x, ret[1].y) )
				break;
			Point2.dispose(ret.shift());
		}		
		return ret;
	}

	function removeWrongTiles(ret:Array<Point2>, tile:Tile) : Void
	{
		ret.push(new Point2(tile.i * tileWidth + tileWidth * 0.5, tile.j * tileHeight + tileHeight * 0.5));
		if( tile.last > 0 )
			removeWrongTiles(ret, stack[tile.last]);
	}
	
	function checkNeighbors(startIndex:Int, cost:Int, side:Int) : Void
	{
		//trace("checkQueue startIndex:" +  startIndex +  " cost:" + cost + " queue:" + queue + " side:" + side );
		var i:Int = startIndex;
		var c:Int;
		var lastCoordinatesSize = coordinates.length;
		//check neigbours of the queue element
		while( i < lastCoordinatesSize )
		{
			c = coordinates[i];
			checkTile(stack[c].i,			stack[c].j - side,	cost + 0.00, c); // top
			checkTile(stack[c].i + side,	stack[c].j - side,	cost + 0.42, c); // top-right
			checkTile(stack[c].i + side,	stack[c].j,			cost + 0.00, c); // right
			checkTile(stack[c].i + side,	stack[c].j + side,	cost + 0.42, c); // right-bottom
			checkTile(stack[c].i,			stack[c].j + side,	cost + 0.00, c); // bottom
			checkTile(stack[c].i - side,	stack[c].j + side,	cost + 0.42, c); // left-bottom
			checkTile(stack[c].i - side,	stack[c].j, 		cost + 0.00, c); // left
			checkTile(stack[c].i - side,	stack[c].j - side,	cost + 0.42, c); // left-top
			i ++;
		}
		
		if( cost < (tileWidth + tileHeight) )
			checkNeighbors(lastCoordinatesSize, cost + 1, side);
	}
		
	function checkTile(i:Int, j:Int, cost:Float, last:Int) : Void
	{
		if( i < 0 || j < 0 || i >= width || j >= height || map[i][j] == STATE_OCCUPIED )
			return;
		
		//if this coordinate is the start finish algorythm as the shortest path was just found
		if( map[i][j] == STATE_TARGET )
		{
			if( target == null || target.cost > cost )
			{
				target = instantiateTile(i, j, cost, last);
				stackAdd(target);
			}
			return;
		}
		
		addCoordinate(instantiateTile(i, j, cost, last));
	}
	
	/**
	 * if a coordinate already exists in the queue  and has higher coordinate it won't be added. but if it has lower coordinate it will replace the one in the queue
	 * @param	coordinate
	 * @param	queue
	 * @return
	 */
	function addCoordinate(tile:Tile) : Void
	{
		var t = stackGet(tile.i, tile.j);
		if( t != null )
		{
			if( tile.cost < t.cost )
			{
				stackRemove(t);
				stackAdd(tile);
				return;
			}
			
			disposeTile(tile);
			return;
		}
		stackAdd(tile);
	}
	
	
	
	public function findTile(x:Float, y:Float, side:Int, state:Int) : Tile
	{
		var tile = getTile(x, y);
		if( get(tile.i, tile.j) == state )
			return tile;
		//trace(tile.i +"," + tile.j + " start finding...");
		if( !lookingAround(tile, side, 1, state) )
			return null;
		setTilePosition(tile);
		return tile;
	}
	
	function lookingAround (tile:Tile, side:Int, step:Int, state:Int) : Bool
	{
		// vertical check
		var i:Int = 0;
		while ( i <= step )
		{
			if( checkAndFillState(tile.i + step * side, tile.j + i * side, tile, state) )
				return true;
			if( checkAndFillState(tile.i - step * side, tile.j + i * side, tile, state) )
				return true;
			if( i == 0 )
			{
				i ++;
				continue;
			}
			if( checkAndFillState(tile.i + step * side, tile.j - i * side, tile, state) )
				return true;
			if( checkAndFillState(tile.i - step * side, tile.j - i * side, tile, state) )
				return true;
			i ++;
		}
		
		// horizontal check
		i = 0;
		while ( i < step )
		{
			if( checkAndFillState(tile.i + i * side, tile.j + step * side, tile, state) )
				return true;
			if( checkAndFillState(tile.i + i * side, tile.j - step * side, tile, state) )
				return true;
			if( i == 0 )
			{
				i ++;
				continue;
			}
			if( checkAndFillState(tile.i - i * side, tile.j + step * side, tile, state) )
				return true;
			if( checkAndFillState(tile.i - i * side, tile.j - step * side, tile, state) )
				return true;
			i ++;
		}
		
		step ++;
		if( step < 15 )
			return lookingAround(tile, side, step, state);
		return false;
	}
	
	function checkAndFillState(i:Int, j:Int, tile:Tile, state:Int) : Bool
	{
		//trace("checkAndFillState i:" + i + ", j:" + j + ", ti:" + tile.i + ", tj:" + tile.j);
		if( inMap(i, j ) && get(i, j) == state )
		{
			tile.i = i;
			tile.j = j;
			return true;
		}
		return false;
	}
	
	
	
	
	
	private var pool:Array<Tile> = new Array<Tile>();
	public function instantiateTile(i:Int, j:Int, cost:Float, last:Int) : Tile 
	{
		var t = pool.pop();
		if( t != null )
			return t.update(i, j, cost, last);
		return new Tile(i, j, cost, last); 
	} 
	public function disposeTile(tile:Tile) : Void
	{
		if( tile == null || tile.last == -127 )
			return;
		tile.last = -127;
		pool.push(tile); 
	} 
	public function disposeAllTiles(oldPath:Array<Tile>) : Void
	{
		if( oldPath != null )
		{
			var len = oldPath.length;
			while ( len > 0 )
				disposeTile(oldPath[--len]);
		}
	}

}