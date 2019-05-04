package com.gt.towers.utils.lists;
import com.gt.towers.utils.GameError;

#if java
	import java.util.ArrayList;
	import java.lang.Error;
#elseif flash
	import flash.Vector;
	import flash.errors.Error;
#end

/**
 * ...
 * @author Mansour Djawadi
 */
class IntList
{
	
	#if java
	private var _list:ArrayList<Int>;
	#elseif flash
	private var _list:Vector<Int>;
	#end

	public function new()
	{
		#if java
		_list = new ArrayList<Int>();
		#elseif flash
		_list = new Vector<Int>();
		#end
	}

	public function size():Int
	{
		#if java
		return _list.size();
		#elseif flash
		return _list.length;
		#end
		return 0;
	}

	public function push(value:Int):Void
	{
		#if java
		_list.add(value);
		#elseif flash
		_list.push(value);
		#end
	}

	public function pop():Int
	{
		#if java
		var i = _list.size() - 1;
		var ret = _list.get(i);
		_list.remove(i);
		return ret;
		#elseif flash
		return _list.pop();
		#end
	}

	public function set(index:Int, value:Int):Void
	{
		#if java
		_list.set(index, value);
		#elseif flash
		_list[index] = value;
		#end
	}

	public function get(index:Int):Int
	{
		#if java
		return _list.get(index);
		#elseif flash
		return _list[index];
		#end
		return -1;
	}

	public function indexOf(element:Int):Int
	{
		#if java
		return _list.indexOf(element);
		#elseif flash
		return _list.indexOf(element);
		#end
		return -1;
	}
	
	public function clear() : Void
	{
		#if java
		_list.clear();
		#elseif flash
		_list.splice(0, _list.length);
		#end
		
	}
	
	public static function parse(value:String, separator:String=","):IntList
	{
		var ret = new IntList();
		var t = 0;
		if ( value == "" || value == null ) return ret;
		var ts = value.split(separator);
		while ( t < ts.length )
		{
			ret.push(Std.parseInt(ts[t]));
			t ++;
		}
		return ret;
	}
	
	public function toString():String
	{
		var size = size();
		var ret:String = "";
		var i:Int = 0;
		while ( i < size )
		{
			if( i == 0 )
				ret += get(i);
			else
				ret += "," + get(i);
			i ++;
		}
		return ret;
	}
	
	public function randomize() : IntList 
	{
		return this;
	}
}