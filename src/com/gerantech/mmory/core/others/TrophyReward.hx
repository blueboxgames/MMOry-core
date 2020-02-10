package com.gerantech.mmory.core.others;

import com.gerantech.mmory.core.constants.MessageTypes;
import com.gerantech.mmory.core.constants.ResourceType;

/**
 * ...
 * @author Mansour Djawadi
 */

class TrophyReward 
{
  public var league:Int;
  public var index:Int;
  public var point:Int;
  public var key:Int;
  public var value:Int;
  public var step:Int;
  public var game:Game;
  
  public function new(game:Game, league:Int, index:Int, point:Int, key:Int, value:Int, step:Int)
  {
    this.game = game;
    this.league = league;
    this.index = index;
    this.point = point;
    this.key = key;
    this.value = value;
    this.step = step;
  }

  public function reached(maxPoint:Int) : Bool
  {
    return this.point <= maxPoint; 
  }

  public function collectible(maxPoint:Int, step:Int) : Bool
  {
    return this.reached(maxPoint) && step < this.step; 
  }

  public function achievable(maxPoint:Int, lastStep:Int, isLeague:Bool):Int
  {
    if( maxPoint < this.point )
    {
      trace("reward [" + this + "] can not achieve with " + maxPoint + " point.");
      return MessageTypes.RESPONSE_MUST_WAIT;
    }

    if( lastStep != this.step - 1 )
    {
      if( lastStep >= this.step )
        return MessageTypes.RESPONSE_ALREADY_SENT;

      if( lastStep == this.step - 2 && isLeague )
      {
        
        var prevType:Int = index == 0 ? game.arenas.get(league - 1).lastReward().key : game.arenas.get(league).rewards[index - 1].key;
        if( !ResourceType.isEvent(prevType) )
        {
          trace("last step is " + lastStep + ". after challenge, you can not achieve in step " + this.step + ".");
          return MessageTypes.RESPONSE_NOT_ALLOWED;
        }
      }
      else
      {
        trace("last step is " + lastStep + ", you can not achieve in step " + this.step + ".");
        return MessageTypes.RESPONSE_NOT_ALLOWED;
      }
    }

    return MessageTypes.RESPONSE_SUCCEED;
  }

  public function toString() : String
  {
    return "league:" + league + " index:" + index + " point:" + point + " key:" + key + " value:" + value + " step:" + step;
  }
}