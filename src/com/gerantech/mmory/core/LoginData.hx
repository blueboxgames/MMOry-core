package com.gerantech.mmory.core;
import com.gerantech.mmory.core.constants.CardTypes;
import com.gerantech.mmory.core.constants.ResourceType;
import com.gerantech.mmory.core.constants.ExchangeType;
import com.gerantech.mmory.core.utils.lists.IntList;
import com.gerantech.mmory.core.utils.maps.IntIntMap;
/**
 * ...
 * @author Mansour Djawadi
 */
class LoginData
{
	public static var coreSize:Int = 0;
	public var coreVersion:String = "2200.0829160614";//do not change len.
	public var noticeVersion:Int = 2200;
	public var forceVersion:Int = 2100;
	public var resources:IntIntMap;
	public var buildingsLevel:IntIntMap;
	public var exchanges:IntList;
	public var nameMinLen:Int = 3;
	public var nameMaxLen:Int = 12;
#if java
	//public var initialDecks:IntIntIntMap;
#end
	public var deckSize:Int = 3;
	public var deck:Array<Int>;
	
	public function new()
	{
		buildingsLevel = new IntIntMap();
		
		resources = new IntIntMap();
		resources.set(ResourceType.R1_XP, 0);
		resources.set(ResourceType.R2_POINT, -4);
		resources.set(ResourceType.R3_CURRENCY_SOFT, 100);
		resources.set(ResourceType.R4_CURRENCY_HARD, 50);
		resources.set(ResourceType.R6_TICKET, 10);
		resources.set(CardTypes.C101, 1);
		resources.set(CardTypes.C102, 1);
		resources.set(CardTypes.C103, 1);
		resources.set(CardTypes.C104, 1);
		resources.set(CardTypes.C105, 1);
		resources.set(CardTypes.C106, 1);
		resources.set(CardTypes.C107, 1);
		resources.set(CardTypes.C108, 1);
		
		exchanges = new IntList();
		exchanges.push(ExchangeType.C21_SPECIAL);
		exchanges.push(ExchangeType.C22_SPECIAL);
		exchanges.push(ExchangeType.C23_SPECIAL);
		exchanges.push(ExchangeType.C101_FREE);
		exchanges.push(ExchangeType.C111_BATTLE);
		exchanges.push(ExchangeType.C112_BATTLE);
		exchanges.push(ExchangeType.C113_BATTLE);
		exchanges.push(ExchangeType.C114_BATTLE);
		
		deck = [CardTypes.C102, CardTypes.C104, CardTypes.C108, CardTypes.C101, CardTypes.C105, CardTypes.C106, CardTypes.C103, CardTypes.C107];
	}
}
