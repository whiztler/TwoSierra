private ["_diagTestStart","_diagTestEnd"];
_diagTestStart = diag_tickTime;
diag_log "ADF RPT: Init - executing Scr\init.sqf"; // Reporting. Do NOT edit/remove

// PreComp
call compile preprocessFileLineNumbers "Scr\ADF_messageParser.sqf";

// Vars init
CSAThostile 			= false;
xRayDestroyed 		= false;
bearclawRescued 		= false;
if (ADF_isHC) then {ADF_fnc_xRayDestroyed = {}};

// Server Init
if (isServer) then {
	#include "init_server.sqf"
	#include "zebra_server.sqf"
};

// Client init
if (hasInterface) then {
	#include "init_client.sqf"
};

// All Clients
#include "bearclaw_all.sqf"
execVM "Scr\ADF_CAS.sqf";

_diagTestEnd = diag_tickTime;
diag_log format ["ADF RPT: Init - FINISHED Scr\init.sqf  [%1]",_diagTestStart - _diagTestEnd];