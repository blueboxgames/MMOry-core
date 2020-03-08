package com.gerantech.mmory.core.constants;

class SFSCommands {
	public static final BATTLE_JOIN:String = "battleJoin";
	public static final BATTLE_START:String = "battleStart";
	public static final BATTLE_CANCEL:String = "battleCancel";
	public static final BATTLE_LEAVE:String = "battleLeave";
	public static final BATTLE_END:String = "battleEnd";
	public static final BATTLE_NEW_ROUND:String = "battleNewRound";
	public static final BATTLE_SEND_STICKER:String = "ss";
	public static final BATTLE_ELIXIR_UPDATE:String = "x";
	public static final BATTLE_SUMMON:String = "s";
	public static final BATTLE_UNIT_CHANGE:String = "u";

	public static final RANK:String = "rank";
	public static final PROFILE:String = "profile";
	public static final COLLECT_ROAD_REWARD:String = "collectRoadReward";
	public static final CARD_UPGRADE:String = "cardUpgrade";
	public static final CARD_NEW:String = "cardNew";
	public static final EXCHANGE:String = "exchange";
	public static final SELECT_NAME:String = "selectName";
	public static final VERIFY_PURCHASE:String = "verify";
	public static final OAUTH:String = "oauth";
	public static final REGISTER_PUSH:String = "registerPush";
	public static final RESTORE:String = "restore";
	public static final CHANGE_DECK:String = "changeDeck";
	public static final PREFS:String = "prefs";

	public static final PLAYERS_GET:String = "playersGet";
	public static final ISSUE_REPORT:String = "issueReport";
	public static final ISSUE_GET:String = "issueGet";
	public static final ISSUE_TRACK:String = "issueTrack";
	public static final BAN:String = "ban";
	public static final BANNED_DATA_GET:String = "bannedDataGet";
	public static final OFFENDER_DATA_GET:String = "offenderDataGet";
	public static final INFRACTIONS_GET:String = "infractionsGet";
	public static final INFRACTIONS_DELETE:String = "infractionsDelete";
	public static final SEARCH_IN_CHATS:String = "searchInChats";

	public static final LOBBY_CREATE:String = "lobbyCreate";
	public static final LOBBY_DATA:String = "lobbyData";
	public static final LOBBY_INFO:String = "lobbyInfo";
	public static final LOBBY_JOIN:String = "lobbyJoin";
	public static final LOBBY_LEAVE:String = "lobbyLeave";
	public static final LOBBY_MODERATION:String = "lobbyModeration";
	public static final LOBBY_EDIT:String = "lobbyEdit";
	public static final LOBBY_REPORT:String = "lobbyReport";
	public static final LOBBY_PUBLIC:String = "lobbyPublic";
	public static final LOBBY_PUBLIC_MESSAGE:String = "m";
	public static final LOBBY_REMOVE:String = "lobbyRemove";

	public static final BUDDY_ADD:String = "buddyAdd";
	public static final BUDDY_REMOVE:String = "buddyRemove";
	public static final BUDDY_BATTLE:String = "buddyBattle";
	public static final BUDDY_DATA:String = "buddyData";

	public static final INBOX_GET_THREADS:String = "inboxGetThreads";
	public static final INBOX_GET_RELATIONS:String = "inboxGetRelations";
	public static final INBOX_OPEN:String = "inboxOpen";
	public static final INBOX_CONFIRM:String = "inboxConfirm";
	public static final INBOX_BROADCAST:String = "inboxBroadcast";

	public static final CHALLENGE_JOIN:String = "challengeJoin";
	public static final CHALLENGE_UPDATE:String = "challengeUpdate";
	public static final CHALLENGE_GET_ALL:String = "challengeGetAll";
	public static final CHALLENGE_COLLECT:String = "challengeCollect";

	public static final QUEST_INIT:String = "questInit";
	public static final QUEST_REWARD_COLLECT:String = "questRewardCollect";

	public static function getDeadline(c:String):Int {
		if (c == BATTLE_JOIN)
			return 14000;
		if (c == BATTLE_START)
			return 30000;
		if (c == BATTLE_CANCEL || c == BATTLE_LEAVE || c == BATTLE_SUMMON || c == BATTLE_SEND_STICKER || c == INBOX_OPEN || c == INBOX_CONFIRM
			|| c == INBOX_BROADCAST || c == ISSUE_GET || c == ISSUE_REPORT || c == ISSUE_TRACK || c == LOBBY_LEAVE || c == LOBBY_EDIT || c == REGISTER_PUSH
			|| c == VERIFY_PURCHASE || c == BUDDY_BATTLE || c == CARD_NEW)
			return -1;
		return 4000;
	}

	public static function getCanceled(c:String):String {
		if (c == BATTLE_CANCEL)
			return BATTLE_JOIN;
		return null;
	}
}
