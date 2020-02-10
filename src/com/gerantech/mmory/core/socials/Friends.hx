package com.gerantech.mmory.core.socials;

class Friends {
  public static final STATE_ANY:Int = -1;
  public static final STATE_NORMAL:Int = 0;
  public static final STATE_REMOVE:Int = 1;
  public static final STATE_BLOCK:Int = 2;

  public var id:Int;
  public var state:Int;
  public var inviter:Int;
  public var invitee:Int;
  public var inviterStep:Int;
  public var inviteeStep:Int;
  public var inviterStart:Int;
  public var inviteeStart:Int;

	public function new(id:Int, inviter:Int, invitee:Int, inviterStep:Int, inviteeStep:Int, inviterStart:Int, inviteeStart:Int, state:Int) {
    this.id = id;
    this.state = state;
    this.inviter = inviter;
    this.invitee = invitee;
    this.inviterStep = inviterStep;
    this.inviteeStep = inviteeStep;
    this.inviterStart = inviterStart;
    this.inviteeStart = inviteeStart;
	}
}
