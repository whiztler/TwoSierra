private ["_diagTestStart","_diagTestEnd"];
_diagTestStart = diag_tickTime;
diag_log "ADF RPT: Init - executing Scr\init.sqf"; // Reporting. Do NOT edit/remove

// PreComp
call compile preprocessFileLineNumbers "Scr\ADF_messageParser.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_position.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_distance.sqf";

// Vars init
ADF_missionStartTime		= 0;
ADF_endMission			= false;
ADF_greenCnt				= 0;
ADF_msg_greenZoneCross 	= {};
ADF_msg_tDolphin 			= {};
ADF_msg_endMission		= {};
ADF_msg_cache1			= {};
ADF_msg_apc1				= {};
ADF_msg_base1			= {};

// Server Init
if (isServer) then {
	#include "init_server.sqf"
};

// Client init
if (hasInterface) then {
	#include "init_client.sqf"
};

// Server/HC
if (!ADF_HC_execute) exitWith {}; // HC Autodetect. If no HC present execute on the Server.

#include "init_AO.sqf" // Server/HC

_diagTestEnd = diag_tickTime;
diag_log format ["ADF RPT: Init - FINISHED Scr\init.sqf  [%1]",_diagTestStart - _diagTestEnd];