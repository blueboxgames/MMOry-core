package com.gt.towers.utils.maps;

/**
 * ...
 * @author Mansour Djawadi
 */

class IntStrMap
{

	#if java
	private var _map:java.util.Map<Int, String>;
	#elseif flash
	private var _map:Map<Int, String>;
	#end

	public function new()
	{
		#if java
		_map = new java.util.concurrent.ConcurrentHashMap<Int, String>();
		#elseif flash
		_map = new Map<Int, String>();
		#end
	}

	/**
		Maps `key` to `value`.
		If `key` already has a mapping, the previous value disappears.
		If `key` is null, the result is unspecified.
	**/
	public function set(key:Int, value:String) : Void
	{
		#if java
		_map.put(key, value);
		#elseif flash
		_map.set(key, value);
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
	public function get(key:Int) :String
	{
		return _map.get(key);
	}
	
	public function getAsFloat(key:Int) : Float
	{
		if ( !exists(key) )
			return 0;
		return Std.parseFloat(get(key));
	}
	public function getAsInt(key:Int) : Int
	{
		if ( !exists(key) )
			return -1;
		return Std.parseInt(get(key));
	}
	public function getAsBool(key:Int) : Bool
	{
		if ( !exists(key) )
			return false;
		return get(key)=="true" ? true : false;
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
	public function values():java.NativeArray<String>
	{
		var keis:java.NativeArray<Dynamic> = _map.keySet().toArray();
		var ret:java.NativeArray<String> = new java.NativeArray<String>(keis.length);
		var i:Int = 0;
		while (i < keis.length)
		{
			ret[i] = cast(get(keis[i]), String);
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
		for (key in _map.keys())
			ret.push(key);
		return ret ;
	}
	/**
		Returns an Iterator over the values of `this` Map.
		The order of values is undefined.
	public function values():flash.Vector<String>
	{
		var ret:flash.Vector<String> = new flash.Vector<String>();
		for (value in _map)
			ret.push(value);
		return ret ;
	}
	**/
	#end
	
	
	public function getRandomKey():Int
	{
		var keis = keys();
		var t = keis[ Math.floor( Math.random() * keis.length ) ];
		if ( t >= 1000 )
			return getRandomKey();
		return t;
	}
}