private ["_diagTestStart","_diagTestEnd"];
_diagTestStart = diag_tickTime;
diag_log "ADF RPT: Init - executing Scr\init.sqf"; // Reporting. Do NOT edit/remove

// PreComp
call compile preprocessFileLineNumbers "Scr\ADF_messageParser.sqf";

// Vars init
tBOPspawnPos			= getPos tBOPspawn;
ADF_Fairlight			= false;
ADF_endMission		= false;
tBOPlive				= false;
ADF_HC_spawn			= false;
ADF_fnc_BOPactive 	= {};
ADF_fnc_BOPreenforce 	= {};
ADF_msg_endMission	= {diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: End Mission Trigger (FOB Johnson) activated";diag_log	"-----------------------------------------------------";};

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

// All clients
execVM "Scr\ADF_CAS.sqf";

_diagTestEnd = diag_tickTime;
diag_log format ["ADF RPT: Init - FINISHED Scr\init.sqf  [%1]",_diagTestStart - _diagTestEnd];