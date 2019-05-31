package com.gerantech.mmory.core.events;

/**
 * @author Mansour Djawadi
 */
interface EventCallback 
{
  	function dispatch(dispatcherId:Int, type:String, data:Any) : Void ;
}
