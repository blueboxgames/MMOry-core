package com.gerantech.mmory.core.socials;
import com.gerantech.mmory.core.constants.MessageTypes;
import com.gerantech.mmory.core.exchanges.ExchangeItem;
import com.gerantech.mmory.core.others.Arena;
import com.gerantech.mmory.core.constants.ResourceType;
import com.gerantech.mmory.core.utils.maps.IntArenaMap;
import com.gerantech.mmory.core.utils.maps.IntIntMap;

/**
 * ...
 * @author ...Mansour Djawadi
 */
class Challenge 
{
	static public var STATE_0_WAIT:Int = 0;
	static public var STATE_1_STARTED:Int = 1;
	static public var STATE_2_END:Int = 2;

	static public var MODE_0_HQ:Int = 0;
	static public var MODE_1_TOUCHDOWN:Int = 1;
	static public var MODE_2_BAZAAR:Int = 2;
	static public var MODE_3_ZONE:Int = 3;

	static public var TYPE_0_OPEN:Int = 0;
	static public var TYPE_1_REWARD:Int = 1;
	static public var TYPE_2_RANKING:Int = 2;
	static public var TYPE_3_PROGRESS:Int = 3;
	
	public var id:Int;
	public var mode:Int;
	public var type:Int;
	public var index:Int;
	public var startAt:Int;
	public var unlockAt:Int;
	public var capacity:Int = 20;
	public var waitTime:Int = 7200;
	public var duration:Int = 28800;
	public var rewards:IntArenaMap;
	public var joinRequirements:IntIntMap;
	public var runRequirements:IntIntMap;
	public var attendees:Array<Attendee>;
	public var rewardCollected:Bool;

	public function new(game:Game, index:Int, type:Int, mode:Int)
	{
		this.index = index;
		this.type = type;
		this.mode = mode;
		if( game != null )
			this.unlockAt = getUnlockAt(game, index);
	}
	
	public function getState(now:Int):Int
	{
		if( now >= startAt + duration )
			return STATE_2_END;
		else if( now >= startAt )
			return STATE_1_STARTED;
		return STATE_0_WAIT;
	}
	
	public function sort() 
	{
		attendees.sort(function(a:Attendee, b:Attendee) : Int 
		{
			if( a.point > b.point ) return -1;
			if( a.point < b.point ) return 1;
			if( a.updateAt > b.updateAt ) return -1;
			if( a.updateAt < b.updateAt ) return 1;
			return 0;
		});
	}
	
	public function getRewardByAttendee(attendeeId:Int) : IntIntMap
	{
		sort();
		var index = indexOfAttendees(attendeeId);
		if( index <= -1 )
			return getRewardByRank(5);
		return getRewardByRank(index + 1);
	}
	
	public function getRewardByRank(rank:Int) : IntIntMap
	{
		var ret = new IntIntMap();
		var ratio = attendees.length / rank / attendees.length;
	//	if( type == 1 )
	//	{
			var prizeKeys = rewards.keys();
			var i = 0;
			var prize:Arena = null;
			while ( i < prizeKeys.length )
			{
				prize = rewards.get(prizeKeys[i]);
				if( rank >= prize.min && rank <= prize.max )
				{
					if( prize.minWinRate == -1 )
						ret.set(prize.minWinRate, 0);
					else if( ResourceType.isBook(prize.minWinRate) )
						ret.set(prize.minWinRate, 1);
					else
						ret.set(prize.minWinRate, Math.floor(ratio * 1000));
					break; 
				}
				i ++;
			}
			/*if( rank <= 0 )
				ret.set(-1, 0);
			else if( rank <= 3 )
				ret.set(rewards.get(rank).minWinStreak, 1);
			else if( rank <= 10 )
				ret.set(rewards.get(4)., 1);
			else if( rank <= 20 )
				ret.set(rewards.get(5), 1);
			else if( rank <= 40 )
				ret.set(rewards.get(6), Math.floor(ratio * 1000));		
			else
				ret.set(rewards.get(7), 0);
			
			return ret;
		}
		
		if( rank <= 0 )
			ret.set(rewards.get(5), 1);
		else if( rank <= 3 )
			ret.set(rewards.get(rank), 1);
		else if( ratio <= 0.5 )
			ret.set(rewards.get(4), 1);
		else
			ret.set(rewards.get(5), 1);*/
		
		trace(rank + " " + ratio + " " + ret.toString());
		return ret;
	}

	public function indexOfAttendees(attendeeId:Int) : Int
	{
		var i = 0;
		while ( i < attendees.length )
		{
			if( attendees[i].id == attendeeId )
				return i;
			i++;
		}
		return -1;
	}
	
	public function run(game:Game, now:Int, arena:Int) : Int
	{
		if( now < startAt || now > startAt + duration )
			return MessageTypes.RESPONSE_NOT_ALLOWED;
		return game.exchanger.exchange(getExchangeItem(type, runRequirements, arena), now);
	}
	
	static public function getUnlockAt(game:Game, index:Int) : Int
	{
		if( index == 0 )
			return -10;
		var len = game.arenas.keys().length;
		for (l in 0...len)
		{
			var rLen = game.arenas.get(l).rewards.length;
			for (r in 0...rLen)
				if( game.arenas.get(l).rewards[r].key == (30 + index) )
					return game.arenas.get(l).rewards[r].point;
		}
		return -10;
		}
	
	static public function getLastIndex(game:Game) : Int
	{
		var len = game.arenas.keys().length;
		for (l in 0...len)
		{
			var rLen = game.arenas.get(l).rewards.length;
			for (r in 0...rLen)
				if( game.arenas.get(l).rewards[r].point < game.player.get_point() && Math.floor(game.arenas.get(l).rewards[r].key/10) == 3 )
					return game.arenas.get(l).rewards[r].key % 10;
		}
		return 0;
	}

	static public function getlowestJoint(player:Player) : Int
	{
		var ret = ResourceType.R30_CHALLENGE_NUMS + 1;
		return ret;
		/*
		var i = 0;
		var lowest = 9999999;
		var joints = 0;
		while( i < 2 )
		{
			joints = player.getResource(ResourceType.CHALLENGES + i + 1 );
			if( lowest > joints )
			{
				lowest = joints;
				ret = ResourceType.CHALLENGES + i + 1;
			}
			i ++;
		}
		return ret;*/
	}
	
	static public function getRewards(type:Int):IntArenaMap
	{
		var ret = new IntArenaMap();
		if( type == 2 )
		{
			ret.set(1, new Arena(null, 1,	1,	1,	59));
			ret.set(2, new Arena(null, 2, 2,	2,	58));
			ret.set(3, new Arena(null, 3, 3,	3,	57));
			ret.set(4, new Arena(null, 4, 4,	10,	56));
			ret.set(5, new Arena(null, 5, 11, 15, 55));
			ret.set(6, new Arena(null, 1, 16, 20, 54));
			ret.set(7, new Arena(null, 5, 21, 30, 53));
			ret.set(8, new Arena(null, 6, 31, 50,	3 ));
			ret.set(9, new Arena(null, 7, 41, 999,-1));
		}
		return ret;
	}
	
#if flash
	static public function getTargetLabel(type:Int) : String
	{
		return "challenge_wins";
	}
#end
	
	static public function getExchangeItem(mode:Int, requirements:IntIntMap, arena:Int) : ExchangeItem
	{
		var ret:ExchangeItem = new ExchangeItem(ResourceType.R30_CHALLENGE_NUMS + mode + 1);
		ret.outcomes = new IntIntMap(ResourceType.R1_XP + ":" + 2 * arena);
		ret.requirements = requirements;
		return ret;
	}	
}