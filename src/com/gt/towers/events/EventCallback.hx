package com.gt.towers.events;

/**
 * @author Mansour Djawadi
 */
interface EventCallback 
{
  	function dispatch(dispatcherId:Int, type:String, data:Any) : Void ;
}
