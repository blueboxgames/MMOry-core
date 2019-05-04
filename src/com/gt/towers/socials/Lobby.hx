package com.gt.towers.socials;
import com.gt.towers.Game;
import com.gt.towers.exchanges.ExchangeItem;
import com.gt.towers.utils.maps.IntIntMap;
import com.gt.towers.constants.ResourceType;

/**
 * ...
 * @author ...
 */
class Lobby 
{
	public static var buddyInviterReward:Int = 20;
	public static var buddyInviteeReward:Int = 20;
	
	public var requiredGems:Int = 30;
	public var xpReward:Int = 100;
	public var game:Game;
	
	public function new(game:Game) 
	{
		this.game = game;
	}
	public function get_createRequirements():IntIntMap
	{
		var ret = new IntIntMap();
		ret.set( ResourceType.R4_CURRENCY_HARD, requiredGems );
		return ret;
	}
	public function get_createOutcome():IntIntMap
	{
		var ret = new IntIntMap();
		ret.set( ResourceType.R1_XP, xpReward );
		return ret;
	}
	public function creatable():Bool
	{
		return game.player.has(get_createRequirements());
	}

	public function create():Bool
	{
		if( !creatable() )
		{				
			trace("Lobby is not creatable!");
			return false;
		}
		
		var ei = new ExchangeItem(0);
		ei.requirements = get_createRequirements();
		ei.outcomes = get_createOutcome();
		trace("resourses then: " + game.player.resources.get(ResourceType.R4_CURRENCY_HARD));
		game.exchanger.exchange(ei, 0, 0);
		trace("resourses now: " +  game.player.resources.get(ResourceType.R4_CURRENCY_HARD));
		trace("Lobby Created!");
		return true;
	}
}