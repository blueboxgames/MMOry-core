package com.gerantech.mmory.core.utils.maps;
class IntIntCardMap
{
	#if java
	public var changeCallback:com.gerantech.mmory.core.interfaces.IValueChangeCallback;
	private var _map:java.util.Map<Int, IntCardMap>;
	#elseif flash
	private var _map:Map<Int, IntCardMap>;
	#end

	public function new()
	{
	#if java
		_map = new java.util.concurrent.ConcurrentHashMap<Int, IntCardMap>();
	#elseif flash
		_map = new Map<Int, IntCardMap>();
	#end
	}

	/**
		Maps `key` to `value`.
		If `key` already has a mapping, the previous value disappears.
		If `key` is null, the result is unspecified.
	**/
	public function set(key:Int, value:IntCardMap) : Void
	{
		//var exists = exists(key);
		//var from = exists ? get(key) : 0;
		#if java
		_map.put(key, value);
		#elseif flash
		_map.set(key, value);
		#end
		//dispatchChangeEvent(key, from, get(key), exists);
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
	public function get(key:Int) :IntCardMap
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
	public function values():java.NativeArray<IntCardMap>
	{
		var keis:java.NativeArray<Dynamic> = _map.keySet().toArray();
		var ret:java.NativeArray<IntCardMap> = new java.NativeArray<IntCardMap>(keis.length);
		var i:Int = 0;
		while (i < keis.length)
		{
			ret[i] = cast(get(keis[i]), IntCardMap);
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
	public function values():flash.Vector<IntCardMap>
	{
		var ret:flash.Vector<IntCardMap> = new flash.Vector<IntCardMap>();
		for (value in _map)
			ret.push(value);
		return ret ;
	}
	**/
	#end
}