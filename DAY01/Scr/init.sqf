private ["_diagTestStart","_diagTestEnd"];
_diagTestStart = diag_tickTime;
diag_log "ADF RPT: Init - executing Scr\init.sqf"; // Reporting. Do NOT edit/remove

// PreComp
call compile preprocessFileLineNumbers "Scr\ADF_messageParser.sqf";

// Vars init
CSAThostile 			= false;
xRayDestroyed 		= false;
bearclawRescued 		= false;
ADF_init_AO			= false;
MotsActive			= false;
ADF_AO_alpha			= {diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: Alpha AO activated";diag_log	"-----------------------------------------------------";};
ADF_AO_bravo			= {diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: Bravo AO activated";diag_log	"-----------------------------------------------------";};
ADF_AO_apt			= {diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: Airport AO activated";diag_log	"-----------------------------------------------------";};
ADF_AO_base			= {diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: CSAT Base AO activated";diag_log	"-----------------------------------------------------";};
ADF_msg_cp			= {diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: CP message";diag_log	"-----------------------------------------------------";};
ADF_msg_xRay			= {diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: Xray message";diag_log	"-----------------------------------------------------";};
ADF_msg_endMission	= {diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: End Mission activated";diag_log	"-----------------------------------------------------";};

// Server Init
if (isServer) then {
	#include "init_server.sqf"
	#include "zebra_server.sqf"
};

// Client init
if (hasInterface) then {
	#include "init_client.sqf"
};

// HC init
if (ADF_isHC) then {
	#include "init_hc.sqf"
};

// All Clients
#include "bearclaw_all.sqf"
execVM "Scr\ADF_CAS.sqf";

_diagTestEnd = diag_tickTime;
diag_log format ["ADF RPT: Init - FINISHED Scr\init.sqf  [%1]",_diagTestStart - _diagTestEnd];