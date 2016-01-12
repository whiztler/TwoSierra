private ["_diagTestStart","_diagTestEnd"];
_diagTestStart = diag_tickTime;
diag_log "ADF RPT: Init - executing Scr\init.sqf"; // Reporting. Do NOT edit/remove

// PreComp
call compile preprocessFileLineNumbers "Scr\ADF_messageParser.sqf";

// Vars init
ADF_missionStartTime		= 0;
ADF_endMission			= false;
ADF_init_AO				= false;
MotsActive				= false;
ADF_greenCnt				= 0;
ADF_fnc_greenZone		 	= {diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: Green Zone Trigger activated";diag_log	"-----------------------------------------------------";};
ADF_msg_greenZone		 	= {diag_log "TWO SIERRA: Green Zone message";};
ADF_msg_tDolphin 			= {diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: Dolphin Trigger activated";diag_log	"-----------------------------------------------------";};
ADF_msg_endMission		= {diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: End Mission Trigger activated";diag_log	"-----------------------------------------------------";};
ADF_msg_cache1			= {diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: Feruz Abad Cache Trigger activated";diag_log	"-----------------------------------------------------";};
ADF_msg_apc1				= {diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: Freuz Abad APC's Trigger activated";diag_log	"-----------------------------------------------------";};
ADF_msg_base1				= {diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: Jillavur opfor base Trigger activated";diag_log	"-----------------------------------------------------";};
ADF_msg_start				= {diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: Start trigger message";diag_log	"-----------------------------------------------------";};
ADF_msg_dolphin			= {diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: Dolphin trigger activated"; diag_log "-----------------------------------------------------";};
ADF_AO_mosque				= {diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: Mosque trigger activated"; diag_log "-----------------------------------------------------";};

// Server Init
if (isServer) then {
	#include "init_server.sqf"
};

// Client init
if (hasInterface) then {
	#include "init_client.sqf"
};

// HC init
if (ADF_isHC) then {
	#include "init_hc.sqf"
};

_diagTestEnd = diag_tickTime;
diag_log format ["ADF RPT: Init - FINISHED Scr\init.sqf  [%1]",_diagTestStart - _diagTestEnd];