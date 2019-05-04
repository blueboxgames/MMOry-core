package com.gt.towers.utils.maps;
import com.gt.towers.socials.Challenge;
import flash.Vector;

class IntChallengeMap
{
	private var _map:Map<Int, Challenge>;
	public function new()
	{
		_map = new Map<Int, Challenge>();
	}

	/**
		Maps `key` to `value`.
		If `key` already has a mapping, the previous value disappears.
		If `key` is null, the result is unspecified.
	**/
	public function set(key:Int, value:Challenge) : Void
	{
		_map.set(key, value);
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
	public function get(key:Int) :Challenge
	{
		return _map.get(key);
	}
	
	/**
		Returns true if `key` has a mapping, false otherwise.
		If `key` is null, the result is unspecified.
	**/
	public function exists(key:Int):Bool
	{
		return _map.exists(key);
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

	/**
		Returns an Iterator over the keys of `this` Map.
		The order of keys is undefined.
	**/
	public function keys():Vector<Int>
	{
		var ret:Vector<Int> = new Vector<Int>();
		for (key in _map.keys())
			ret.push(key);
		return ret ;
	}
	/**
		Returns an Iterator over the values of `this` Map.
		The order of values is undefined.
	public function values():Vector<Challenge>
	{
		var ret:Vector<Challenge> = new Vector<Challenge>();
		for (value in _map)
			ret.push(value);
		return ret ;
	}
	**/
	
	public function getStartedChallenge(now : Int) : Int
	{
		var i = 0;
		var keys = keys();
		while ( i < keys.length )
		{
			if( get(keys[i]).getState(now) == Challenge.STATE_1_STARTED )
				return keys[i];
			i ++;
		}
		return -1;
	}
}