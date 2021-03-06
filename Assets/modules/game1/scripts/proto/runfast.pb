
�
game_pokerface.proto	pokerface"(
GameMessage
Ops (
Data ("2
MsgCardHand
cardHandType (
cards ("�
MsgPlayerCardList
chairID (
cardCountOnHand (
cardsOnHand (.
discardedHands (2.pokerface.MsgCardHand
flowers ("�
MsgDeal
bankerChairID (
windFlowerID (5
playerCardLists (2.pokerface.MsgPlayerCardList
cardsInWall (
dice1 (
dice2 (
isContinuousBanker (
markup ("p
MsgAllowPlayerAction
qaIndex (
actionChairID (
allowedActions (
timeoutInSeconds ("�
MsgAllowPlayerReAction
qaIndex (
actionChairID (
allowedActions (
timeoutInSeconds (
prevActionChairID (.
prevActionHand (2.pokerface.MsgCardHand"P
MsgPlayerAction
qaIndex (
action (
flags (
cards ("
MsgActionResultNotify
targetChairID (
action (*

actionHand (2.pokerface.MsgCardHand
cardsInWall ("�

MsgRestore#
msgDeal (2.pokerface.MsgDeal
prevActionChairID (.
prevActionHand (2.pokerface.MsgCardHand
landlordChairID (
multiple (
lastAwardCards (
playersListA ("�
MsgPlayerScoreGreatWin
baseWinScore (
greatWinType (
greatWinPoints (
trimGreatWinPoints (
continuousBankerExtra ("�
MsgPlayerScoreMiniWin
miniWinType (
miniWinBasicScore (
miniWinFlowerScore (
miniMultiple (
miniWinTrimScore (
continuousBankerExtra ("�
MsgPlayerScore
targetChairID (
winType (
score (
specialScore (3
greatWin (2!.pokerface.MsgPlayerScoreGreatWin1
miniWin (2 .pokerface.MsgPlayerScoreMiniWin
fakeWinScore (
fakeList (
isContinuousBanker	 ( 
continuousBankerMultiple
 ("?
MsgHandScore/
playerScores (2.pokerface.MsgPlayerScore"�
MsgHandOver
endType (5
playerCardLists (2.pokerface.MsgPlayerCardList'
scores (2.pokerface.MsgHandScore
continueAble ("5
MsgUpdateLocation
userID (	
location (	"#
MsgUpdatePropCfg
propCfg (	*�
CardID
R2H 
R2D
R2C
R2S
R3H
R3D
R3C
R3S
R4H
R4D	
R4C

R4S
R5H
R5D
R5C
R5S
R6H
R6D
R6C
R6S
R7H
R7D
R7C
R7S
R8H
R8D
R8C
R8S
R9H
R9D
R9C
R9S
R10H 
R10D!
R10C"
R10S#
JH$
JD%
JC&
JS'
QH(
QD)
QC*
QS+
KH,
KD-
KC.
KS/
AH0
AD1
AC2
AS3
JOB4
JOR5
CARDMAX6*�
MessageCode
	OPInvalid 
OPAction
OPActionResultNotify
OPActionAllowed
OPReActionAllowed

OPDeal

OPHandOver
	OPRestore
OPPlayerLeaveRoom	
OPPlayerEnterRoom

OPDisbandRequest
OPDisbandNotify
OPDisbandAnswer
OPPlayerReady
OPRoomDeleted
OPRoomUpdate
OPRoomShowTips

OPGameOver
	OPKickout
OPDonate
OPUpdateLocation
OP2Lobby
OPUpdatePropCfg
�
game_pokerface_replay.proto	pokerface"�
MsgReplayPlayerInfo
userID (	
nick (	
chairID (

totalScore (
sex (
headIconURI (	
avatarID ("N
MsgReplayPlayerScoreSummary
chairID (
score (
winType ("�
MsgReplayRecordSummary

recordUUID (	<
playerScores (2&.pokerface.MsgReplayPlayerScoreSummary
endTime (
shareAbleID (	
	startTime ("�
MsgReplayRoom
recordRoomType (
	startTime (
endTime (

roomNumber (	/
players (2.pokerface.MsgReplayPlayerInfo2
records (2!.pokerface.MsgReplayRecordSummary
ownerUserID (	
�
game_pokerface_rf.protoprunfast*�
CardHandType
None 	
Flush
Bomb

Single
Pair

Pair2X
Triplet
TripletPair
	Triplet2X
Triplet2X2Pair	*�
HandOverType
enumHandOverType_None "
enumHandOverType_Win_SelfDrawn
enumHandOverType_Win_Chuck
enumHandOverType_Chucker
enumHandOverType_Konger 
enumHandOverType_Win_RobKong*�

ActionType
enumActionType_None 
enumActionType_SKIP
enumActionType_DISCARD
enumActionType_DRAW 
enumActionType_Win_SelfDrawn
�
game_pokerface_s2s.proto	pokerface"t
SRMsgPlayerInfo
userID (	
chairID (
nick (	
sex (
headIconURI (	
avatarID ("G
SRDealDetail
chairID (
	cardsHand (
cardsFlower ("�
SRAction
action (
chairID (
qaIndex (
cards (
flags (
cardHandType (
allowActions ("=
SRMsgHandRecorderExtra
markup (
ownerUserID (	"�
SRMsgHandRecorder
bankerChairID (
windFlowerID (+
players (2.pokerface.SRMsgPlayerInfo

isHandOver (&
deals (2.pokerface.SRDealDetail$
actions (2.pokerface.SRAction
	handScore (
roomConfigID (	
	startTime	 (
endTime
 (
handNum (
isContinuousBanker (

roomNumber (	
roomType (0
extra (2!.pokerface.SRMsgHandRecorderExtra*G
SRFlags

SRNone 
SRUserReplyOnly
SRRichi

SRFlyRichi
�
game_pokerface_split2.proto	pokerface"�
MsgPlayerInfo
userID (	
chairID (
state (
name (	
nick (	
sex (
headIconURI (	

ip (	
location	 (	
dfHands
 (
diamond (
charm (
avatarID (
clubIDs (	
dan (
isLooker ("G
PlayerHandScoreRecord
userID (	
winType (
score ("u
MsgRoomHandScoreRecord
endType (
	handIndex (7
playerRecords (2 .pokerface.PlayerHandScoreRecord"�
MsgRoomInfo
state ()
players (2.pokerface.MsgPlayerInfo
ownerID (	

roomNumber (	
handStartted (7
scoreRecords (2!.pokerface.MsgRoomHandScoreRecord
handFinished ("K
RoomScoreRecords7
scoreRecords (2!.pokerface.MsgRoomHandScoreRecord"!
MsgDisbandAnswer
agree ("~
MsgDisbandNotify
disbandState (
	applicant (
waits (
agrees (
rejects (
	countdown ("�
MsgGameOverPlayerStat
chairID (
score (
winChuckCounter (
winSelfDrawnCounter (
chuckerCounter (
robKongCounter (
kongerCounter ("D
MsgGameOver5
playerStats (2 .pokerface.MsgGameOverPlayerStat"0
MsgRoomShowTips
tips (	
tipCode ("
MsgRoomDelete
reason (""

MsgKickout
victimUserID (	"t
MsgKickoutResult
result (
victimUserID (	

victimNick (	
	byWhoNick (	
byWhoUserID (	"$
MsgEnterRoomResult
status ("C
	MsgDonate
	toChairID (
itemID (
fromChairID (*P
	RoomState
	SRoomIdle 
SRoomWaiting
SRoomPlaying
SRoomDeleted*D
PlayerState

PSNone 
PSReady
	PSOffline
	PSPlaying*�
DisbandState
Waiting
Done
DoneWithOtherReject!
DoneWithRoomServerNotResponse
DoneWithWaitReplyTimeout
ErrorDuplicateAcquire"
ErrorNeedOwnerWhenGameNotStart
ErrorWatcherNotDisband*S
TipCode

TCNone 
TCWaitOpponentsAction!
TCDonateFailedNoEnoughDiamond*�
RoomDeleteReason
IdleTimeout
DisbandByOwnerFromRMS
DisbandByApplication
DisbandBySystem
DisbandMaxHand
DisbandInLoseProtected*�
KickoutResult
KickoutResult_Success'
#KickoutResult_FailedGameHasStartted!
KickoutResult_FailedNeedOwner&
"KickoutResult_FailedPlayerNotExist*�
EnterRoomStatus
Success 
RoomNotExist
RoomIsFulled
RoomPlaying
InAnotherRoom
MonkeyRoomUserIDNotMatch"
MonkeyRoomUserLoginSeqNotMatch
AppModuleNeedUpgrade
InRoomBlackList!
TakeoffDiamondFailedNotEnough	
TakeoffDiamondFailedIO

ParseTokenError
RoomInApplicateDisband
NotClubMember