package com.gt.towers.interfaces;

/**
 * @author Mansour Djawadi
 */
interface IValueChangeCallback 
{
  	function insert(key:Int, oldValue:Int, newValue:Int) : Void ;
  	function update(key:Int, oldValue:Int, newValue:Int) : Void ;
}