package com.gt.towers.utils.maps;
import com.gt.towers.battle.units.Card;
/**
 * ...
 * @author Mansour Djawadi
 */
class IntCardMap
{
	#if java
	private var _map:java.util.Map<Int, Card>;
	private var _queue:java.util.List<Int>;
	#elseif flash
	private var _map:Map<Int, Card>;
	private var _queue:flash.Vector<Int>;
	#end

	public function new()
	{
		#if java
		_map = new java.util.concurrent.ConcurrentHashMap<Int, Card>();
		_queue = new java.util.ArrayList<Int>();
		#elseif flash
		_map = new Map<Int, Card>();
		_queue = new flash.Vector<Int>();
		#end
	}

	/**
		Maps `key` to `value`.
		If `key` already has a mapping, the previous value disappears.
		If `key` is null, the result is unspecified.
	**/
	public function set(key:Int, value:Card) : Void
	{
		#if java
		_map.put(key, value);
		_queue.add(key);
		#elseif flash
		_map.set(key, value);
		_queue.push(key);
		#end
	}

	/**
		Returns the current mapping of `key`.
		If no such mapping exists, null is returned.

		Note that a check like `map.get(key) == null` can hold for two reasons:
		1. the map has no mapping for `key`
		2. the map has a mapping with a value of `null`

		If it is important to distinguish these cases, `exists()` should be
		used.
		If `key` is null, the result is unspecified.
	**/
	public function get(key:Int) : Card
	{
		return _map.get(key);
	}
	
	/**
		Returns true if `key` has a mapping, false otherwise.
		If `key` is null, the result is unspecified.
	**/
	public function exists(key:Int):Bool
	{
		#if java
		return _map.containsKey(key);
		#elseif flash
		return _map.exists(key);
		#end
		return false;
	}

	public function indexOf(type:Int) : Int
	{
		var __k = keys();
		var i = __k.length - 1;
		while ( i >= 0 )
		{
			if ( get(__k[i]).type == type )
				return i;
			i --;
		}
		return -1;
	}

	/**
		Removes the mapping of `key` and returns true if such a mapping existed,
		false otherwise.
		If `key` is null, the result is unspecified.
	**/
	public function remove(key:Int):Void
	{
		_map.remove(key);
	}

	#if java
	/**
		Returns an Iterator over the keys of `this` Map.
		The order of keys is undefined.
	**/
	public function keys():java.NativeArray<Int>
	{
		var keis:java.NativeArray<Dynamic> = _map.keySet().toArray();
		var ret:java.NativeArray<Int> = new java.NativeArray<Int>(keis.length);
		var i:Int = 0;
		while (i < keis.length)
		{
			ret[i] = cast(keis[i], Int);
			i++;
		}
		return ret ;
	}
	/**
		Returns an Iterator over the values of `this` Map.
		The order of values is undefined.
	public function values():java.NativeArray<Card>
	{
		var keis:java.NativeArray<Dynamic> = _map.keySet().toArray();
		var ret:java.NativeArray<Card> = new java.NativeArray<Card>(keis.length);
		var i:Int = 0;
		while (i < keis.length)
		{
			ret[i] = cast(get(keis[i]), Card);
			i++;
		}
		return ret ;
	}
	**/
	#end
	
	#if flash
	/**
		Returns an Iterator over the keys of `this` Map.
		The order of keys is undefined.
	**/
	public function keys():flash.Vector<Int>
	{
		var ret:flash.Vector<Int> = new flash.Vector<Int>();
		for( key in _map.keys() )
			ret.push(key);
		return ret ;
	}
	/**
		Returns an Iterator over the values of `this` Map.
		The order of values is undefined.
	public function values():flash.Vector<Card>
	{
		var ret:flash.Vector<Card> = new flash.Vector<Card>();
		for( value in _map )
			ret.push(value);
		return ret ;
	}
	**/
	#end
	
	public function queue_get(index:Int) : Int
	{
		#if java
		return _queue.get(index);
		#elseif flash
		return _queue[index];
		#end
	}
	public function queue_size() : Int
	{
		#if java
		return _queue.size();
		#elseif flash
		return _queue.length;
		#end
	}
	public function queue_removeAt(index:Int) : Int
	{
		#if java
		return _queue.remove(index);
		#elseif flash
		return _queue.splice(index, 1)[0];
		#end
	}
	public function queue_indexOf(item:Int) : Int
	{
		#if java
		var iter:java.util.Iterator<Int> = _queue.iterator();
		var i = 0;
		while ( iter.hasNext() )
		{
			if( item == iter.next() )
				return i;
			i ++;
		}
		return -1;
		#elseif flash
		return _queue.indexOf(item);
		#end
	}
	public function enqueue(item:Int) : Void
	{
		#if java
		_queue.add(item);
		#elseif flash
		_queue.push(item);
		#end
	}
	public function dequeue() : Int
	{
		#if java
		return _queue.remove(0);
		#elseif flash
		return _queue.shift();
		#end
	}
	
	public function queue_String() : String
	{
		#if java
		var iter:java.util.Iterator<Int> = _queue.iterator();
		var i = 0;
		var ret = "";
		while ( iter.hasNext() )
		{
			var item = iter.next();
			if( i == 0 )
				ret += "" + item;
			else
				ret += "," + item;
			i ++;
		}
		return ret;
		#elseif flash
		return _queue.toString();
		#end		
	}
	
	public function getRandomKey() : Int
	{
		var keys = keys();
		var t = keys[ Math.floor( Math.random() * keys.length ) ];
		if( t >= 1000 )
			return getRandomKey();
		return t;
	}
	
	public function getLowestLevel() : Int
	{
		var ret = 11;
		var lvl = 100;
		var keys = keys();
		var i = 0;
		while ( i < keys.length )
		{
			if( get(keys[i]).level < lvl )
			{
				lvl = get(keys[i]).level;
				ret = keys[i];
			}
			i ++;
		}
		return ret;
	}
	
	public function getHighestLevel() : Int
	{
		var ret = 11;
		var lvl = 0;
		var keys = keys();
		var i = 0;
		while ( i < keys.length )
		{
			if( get(keys[i]).level > lvl )
			{
				lvl = get(keys[i]).level;
				ret = keys[i];
			}
			i ++;
		}
		return ret;
	}
	
	public function getLowestCard() : Int
	{
		var ret = 101;
		var numCards = 9999999;
		var i = 0;
		var keys = keys();
		var collected = 0;
		while ( i < keys.length )
		{
			collected = Card.getTotalCollected(get(keys[i]).level, get(keys[i]).count());
			if( collected < numCards )
			{
				numCards = collected + 0;
				ret = keys[i];
			}
			i ++;
		}
		return ret;		
	}
}