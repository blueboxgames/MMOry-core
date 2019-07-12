package com.gerantech.mmory.core.others;

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
  
  public function new(game:Game, league:Int, index:Int, point:Int, key:Int, value:Int)
  {
    this.game = game;
    this.league = league;
    this.index = index;
    this.point = point;
    this.key = key;
    this.value = value;
    this.step = (league - 1) * 3 + index + 1;
  }

  public function reached() : Bool
  {
    return this.point < this.game.player.get_point(); 
  }

  public function collectible() : Bool
  {
    return this.reached() && this.game.player.getResource(ResourceType.R25_REWARD_STEP) < step; 
  }
}