package com.gerantech.mmory.core.socials;

class Friends {
  public var id:Int;
  public var inviter:Int;
  public var invitee:Int;
  public var inviterStep:Int;
  public var inviteeStep:Int;

	public function new(id:Int, inviter:Int, invitee:Int, inviterStep:Int, inviteeStep:Int) {
    this.id = id;
    this.inviter = inviter;
    this.invitee = invitee;
    this.inviterStep = inviterStep;
    this.inviterStep = inviterStep;
	}
}
