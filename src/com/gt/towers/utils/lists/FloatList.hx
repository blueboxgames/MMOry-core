package com.gt.towers.utils.lists;

/**
 * ...
 * @author Mansour Djawadi
 */
class FloatList
{
	
	#if java
	private var _list:java.util.List<Float>;
	#elseif flash
	private var _list:flash.Vector<Float>;
	#end

	public function new()
	{
		#if java
		_list = new java.util.ArrayList<Float>();
		#elseif flash
		_list = new flash.Vector<Float>();
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

	public function push(value:Float):Void
	{
		#if java
		_list.add(value);
		#elseif flash
		_list.push(value);
		#end
	}

	public function pop():Void
	{
		#if java
		_list.remove(_list.size()-1);
		#elseif flash
		_list.pop();
		#end
	}

	public function set(index:Int, value:Float):Void
	{
		#if java
		_list.set(index, value);
		#elseif flash
		_list[index] = value;
		#end
	}

	public function get(index:Int):Float
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
		return _list.indexOf(element);
	}
	
	public function clear() : Void
	{
		#if java
		_list.clear();
		#elseif flash
		_list.splice(0, _list.length);
		#end
	}
	
	public static function parse(value:String, separator:String=","):FloatList
	{
		var ret = new FloatList();
		var t = 0;
		if ( value == "" || value == null ) return ret;
		var ts = value.split(separator);
		while ( t < ts.length )
		{
			ret.push(Std.parseFloat(ts[t]));
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
}