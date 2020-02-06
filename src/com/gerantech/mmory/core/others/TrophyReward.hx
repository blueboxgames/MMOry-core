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

  public function achievavle(point:Int, lastStep:Int, isLeague:Bool):Int
  {
    if( point < this.point )
    {
      trace("reward [" + this + "] can not achieve with " + point + " point.");
      return MessageTypes.RESPONSE_NOT_ALLOWED;
    }

    if( lastStep != this.step - 1 )
    {
      if( lastStep == this.step - 2 && isLeague )
      {
        var prevType:Int = index == 0 ? game.arenas.get(league - 1).lastReward().key : game.arenas.get(league).rewards[index - 1].key;
        if( !ResourceType.isEvent(prevType) )
          return MessageTypes.RESPONSE_NOT_ALLOWED;
      }
      else
      {
        trace("this.step " + this.step + " can not achieve in current league.");
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