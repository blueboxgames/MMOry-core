package com.gerantech.mmory.core.interfaces;
/**
 * @author Mansour Djawadi
 */
interface IUnitHitCallback 
{
	#if java
  	function hit(bulletId:Int, hitUnits:java.util.List<java.lang.Integer>):Void ;
	#end
}