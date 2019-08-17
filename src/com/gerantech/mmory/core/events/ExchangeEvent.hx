package com.gerantech.mmory.core.events;

import com.gerantech.mmory.core.exchanges.ExchangeItem;

class ExchangeEvent extends flash.events.Event
{
	public static var COMPLETE:String = "complete";

	public var item:ExchangeItem;

	public function new(type:String, item:ExchangeItem) {
		this.item = item;
		super(type, false, false);
	}
}
