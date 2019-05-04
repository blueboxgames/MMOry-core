package com.gt.towers.utils.maps;
import com.gt.towers.constants.ResourceType;
#if java
class IntIntMap
#elseif flash
class IntIntMap extends flash.events.EventDispatcher
#end
{

	#if java
	public var changeCallback:com.gt.towers.interfaces.IValueChangeCallback;
	private var _map:java.util.Map<Int, Int>;
	#elseif flash
	private var _map:Map<Int, Int>;
	#end

	#if java
	@:overload
	public function new()
	{
		_map = new java.util.concurrent.ConcurrentHashMap<Int, Int>();
	}
	@:overload
	public function new(inputString:String)
	{
		_map = new java.util.concurrent.ConcurrentHashMap<Int, Int>();
		parse(inputString);
	}
	#elseif flash
	public function new(inputString:String=null)
	{
		super();
		_map = new Map<Int, Int>();
		
		parse(inputString);
	}
	#end
	
	public function parse(inputString:String) : Void
	{
		if( inputString == null || inputString == "" )
			return;
		
		var step:Int = 0;
		var list:Array<String> = inputString.split(",");
		var kayVal:Array<String>;
		while ( step < list.length )
		{
			kayVal = list[step].split(":");
			increase(Std.parseInt(kayVal[0]), kayVal.length > 1 ? Std.parseInt(kayVal[1]) : 0 );
			//trace("reqsStr", list[listLen], Std.parseInt(kayVal[0]), kayVal.length > 1 ? Std.parseInt(kayVal[1]) : 0);
			step ++;
		}
	}

	/**
		Maps `key` to `value`.
		If `key` already has a mapping, the previous value disappears.
		If `key` is null, the result is unspecified.
	**/
	public function set(key:Int, value:Int) : Void
	{
		var exists = exists(key);
		var from = exists ? get(key) : 0;
		#if java
		_map.put(key, value);
		#elseif flash
		_map.set(key, value);
		#end
		
		dispatchChangeEvent(key, from, get(key), exists);
		
		if( key == ResourceType.R2_POINT && value > get(ResourceType.R7_MAX_POINT) )
			set(ResourceType.R7_MAX_POINT, value);
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
	public function get(key:Int) :Int
	{
		#if java
		return _map.get(key);
		#elseif flash
		return _map.get(key);
		#end
		return -1;
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
	
	public function existsValue(value:Int):Bool
	{
		#if java
		return _map.containsValue(value);
		#elseif flash
		return values().indexOf(value) > -1;
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
		#if java
		_map.remove(key);
		#elseif flash
		_map.remove(key);
		#end
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
	**/
	public function values():java.NativeArray<Int>
	{
		var keis:java.NativeArray<Dynamic> = _map.keySet().toArray();
		var ret:java.NativeArray<Int> = new java.NativeArray<Int>(keis.length);
		var i:Int = 0;
		while (i < keis.length)
		{
			ret[i] = cast(get(keis[i]), Int);
			i++;
		}
		return ret ;
	}
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
	**/
	public function values():flash.Vector<Int>
	{
		var ret:flash.Vector<Int> = new flash.Vector<Int>();
		for (value in _map)
			ret.push(value);
		return ret ;
	}
	#end
	
	
	public function reduceMap(bundle:IntIntMap):Void
	{
		var keys = bundle.keys();
		var i:Int = 0;
		while (i < keys.length)
		{
			reduce(keys[i], bundle.get(keys[i]));
			i++;
		}
	}
	public function reduce(key:Int, value:Int):Void
	{
		if( value == 0 )
			return;
		if( !exists(key) )
			throw new GameError(1, key + " not found.", key);

		if( key != ResourceType.R5_CURRENCY_REAL && key != ResourceType.R2_POINT && get(key) < value )
			throw new GameError(0, key + " not enough. you need " + (value-get(key)) +" more.", key);

		set(key, get(key) - value);
	}
	
	
	public function increaseMap(bundle:IntIntMap):Void
	{
		var keys = bundle.keys();
		var i:Int = 0;
		while (i < keys.length)
		{
			increase(keys[i], bundle.get(keys[i]));
			i++;
		}
	}
	public function increase(key:Int, value:Int):Void
	{
		//if (!exists(key))
		//	throw new GameError(1, "key " + key + " not found.");
		if( exists(key) )
			set(key, get(key) + value);
		else
			set(key, value);
	}

	public function getRandomKey():Int
	{
		var keis = keys();
		return keis[ Math.floor( Math.random() * keis.length ) ];
	}
	
	private function dispatchChangeEvent (key:Int, from:Int, to:Int, exists) : Void
	{
		if( from == to )
			return;
		
	#if java
		if( changeCallback != null )
		{
			if( exists )
				changeCallback.update( key, from, to );
			else
				changeCallback.insert( key, from, to );
		}
	#elseif flash
		//if( hasEventListener ( CoreEvent.CHANGE ) )
		dispatchEvent(new com.gt.towers.events.CoreEvent(com.gt.towers.events.CoreEvent.CHANGE, key, from, to) );
	#end
	}
	
	#if java
	public function toString():String
	#elseif flash
	public override function toString():String
	#end
	{
		var keys = keys();
		var ret:String = "";
		var i:Int = 0;
		while ( i < keys.length )
		{
			if( i == 0 )
				ret = keys[i] + ":" + get(keys[i]);
			else
				ret += "," + keys[i] + ":" + get(keys[i]);
			i ++;
		}
		return ret;
	}

	public function toArray(randomly:Bool) : Array<Int>
	{
		var ret = new Array<Int>();
		var keys = keys();
		var values = new Array<Int>();
		var len = keys.length;
		var i:Int = 0;
		while( i < len )
		{
			values.push(get(keys[i]));
			i ++;
		}
		if( !randomly )
			return values;
		i = 0;
		len = values.length;
		while( i < len )
		{
			var a = keys[Std.random(len)];
			if ( ret.indexOf(values[a]) > -1 )
			{
				continue;
			}
			ret.push(values[a]);				
			i ++;
		}
		//trace( toString() + " <::> " + ret.toString() );
		return ret;
	}
}