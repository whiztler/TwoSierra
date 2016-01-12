private ["_diagTestStart","_diagTestEnd"];
_diagTestStart = diag_tickTime;
diag_log "ADF RPT: Init - executing Scr\init.sqf"; // Reporting. Do NOT edit/remove

// PreComp
call compile preprocessFileLineNumbers "Scr\ADF_messageParser.sqf";

// Vars init
MotsActive			= false;
ADF_init_AO			= false;
ADF_ortegaClear		= false;
ADF_doloresClear		= false;
ADF_msg_endMission	= {diag_log "-----------------------------------------------------";diag_log "TWO SIERRA: End Mission activated";diag_log	"-----------------------------------------------------";};
ADF_msg_doloresBase	= {diag_log "-----------------------------------------------------";diag_log "TWO SIERRA: Dolores base trigger activated";diag_log	"-----------------------------------------------------";};
ADF_msg_ortegaClear	= {diag_log "-----------------------------------------------------";diag_log "TWO SIERRA: Ortega Clear message";diag_log	"-----------------------------------------------------";};
ADF_msg_doloresClear	= {diag_log "-----------------------------------------------------";diag_log "TWO SIERRA: Dolores Clear message";diag_log	"-----------------------------------------------------";};

// Server Init
if (isServer) then {
	#include "init_server.sqf"
};

// Client init
if (hasInterface) then {
	//#include "init_client.sqf"
};

// HC init
if (ADF_isHC) then {
	//#include "init_hc.sqf"
};

// All clients
//execVM "Scr\ADF_CAS.sqf";

_diagTestEnd = diag_tickTime;
diag_log format ["ADF RPT: Init - FINISHED Scr\init.sqf  [%1]",_diagTestStart - _diagTestEnd];