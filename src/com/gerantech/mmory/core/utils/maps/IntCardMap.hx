package com.gerantech.mmory.core.utils.maps;
import com.gerantech.mmory.core.battle.units.Card;
/**
 * ...
 * @author Mansour Djawadi
 */
class IntCardMap
{
	#if java
	private var _map:java.util.Map<Int, Card>;
	private var _queue:java.NativeArray<Int>;
	#elseif flash
	private var _map:Map<Int, Card>;
	private var _queue:flash.Vector<Int>;
	#end

	public function new(hasQueue:Bool)
	{
		#if java
		_map = new java.util.concurrent.ConcurrentHashMap<Int, Card>();
		if( hasQueue )
			_queue = new java.NativeArray<Int>(8);
		#elseif flash
		_map = new Map<Int, Card>();
		if( hasQueue )
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
		if( _queue != null )
			_queue[_map.size() - 1] = key;
		#elseif flash
		_map.set(key, value);
		if( _queue != null )
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

	public function queue_removeAt(index:Int) : Int
	{
		if( _queue == null )
			return -1;
		
		#if java
		var ret = _queue[index];
		var last = _queue.length - 1;
		for( i in index...last )
			_queue[i] = _queue[i+1];
		_queue[last] = -1;
		return ret;
		#elseif flash
		return _queue.splice(index, 1)[0];
		#end
	}
	public function queue_indexOf(item:Int) : Int
	{
		if( _queue == null )
			return -1;
		
		#if java
		var len:Int = _queue.length;
		for( i in 0...len )
			if( item == _queue[i] )
				return i;
		return -1;
		#elseif flash
		return _queue.indexOf(item);
		#end
	}
	public function enqueue(item:Int) : Void
	{
		if( _queue == null )
			return;
		
		#if java
		_queue[_queue.length - 1] = item;
		#elseif flash
		_queue.push(item);
		#end
	}
	public function dequeue() : Int
	{
		if( _queue == null )
			return -1;
		
		#if java
		return queue_removeAt(0);
		#elseif flash
		return _queue.shift();
		#end
	}
	
	public function queue_String() : String
	{
		if( _queue == null )
			return "null queue!";
		
		#if java
		var ret = "";
		var len:Int = _queue.length;
		for( i in 0...len )
			if( i == 0 )
				ret += "" + _queue[i];
			else
				ret += "," + _queue;
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