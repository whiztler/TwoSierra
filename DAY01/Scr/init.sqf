private ["_diagTestStart","_diagTestEnd"];
_diagTestStart = diag_tickTime;
diag_log "ADF RPT: Init - executing Scr\init.sqf"; // Reporting. Do NOT edit/remove

// PreComp
call compile preprocessFileLineNumbers "Scr\ADF_messageParser.sqf";

// Vars init
CSAThostile 		= false;
xRayDestroyed 	= false;
bearclawRescued 	= false;

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


// Server/HC
if (!ADF_HC_execute) exitWith {}; // HC Autodetect. If no HC present execute on the Server.
#include "init_AO.sqf" // Server/HC

_diagTestEnd = diag_tickTime;
diag_log format ["ADF RPT: Init - FINISHED Scr\init.sqf  [%1]",_diagTestStart - _diagTestEnd];