private ["_diagTestStart","_diagTestEnd"];
_diagTestStart = diag_tickTime;
diag_log "ADF RPT: Init - executing Scr\init.sqf"; // Reporting. Do NOT edit/remove

// PreComp
call compile preprocessFileLineNumbers "Scr\ADF_messageParser.sqf";

// Vars init
MotsActive				= false;
ADF_pashtunWaveClear 		= false;
ADF_pashtunAOtriggered	= false;
ADF_SatanClearUp			= false;
ADF_SatanControl			= false;
ADF_init_AO				= false;
MotsActive				= false;
ADF_redZoneOpforCnt		= 0;
ADF_msg_tPrice 			= {diag_log "TWO SIERRA: Price message";};
ADF_msg_tBaltimore 		= {diag_log "TWO SIERRA: Baltimore message";};

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

// All Clients
execVM "Scr\ADF_CAS.sqf";

_diagTestEnd = diag_tickTime;
diag_log format ["ADF RPT: Init - FINISHED Scr\init.sqf  [%1]",_diagTestStart - _diagTestEnd];