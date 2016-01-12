/****************************************************************
ARMA Mission Development Framework
ADF version: 1.43 / JANUARY 2016

Script: Mission init
Author: Whiztler
Script version: 1.14

Game type: n/a
File: initServer.sqf
****************************************************************
Executed on the server at mission start. NOT executed on any
(player) clients and not on JIP.
****************************************************************/

diag_log "ADF RPT: Init - executing initServer.sqf"; // Reporting. Do NOT edit/remove

// add mission data to RPT log
diag_log text ""; diag_log text ""; diag_log text ""; 
diag_log text format["####################   %1   ####################", missionName]; // stamp mission name in RPT log
diag_log text "";

[] spawn {waitUntil {time > 0}; enableEnvironment FALSE;};	

if (isDedicated) then {
	#include "Core\ADF_init_rpt.sqf"
};

//  Execute Core Third Party SERVER scripts: (comment out if not applicable)
// Object markers
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";
_objArr = ["Land_HBarrierWall6_F","Land_HBarrier_5_F","Land_Radar","US_WarfareBBarracks_Base_EP1","Fort_Barracks_USMC","US_WarfareBFieldhHospital_Base_EP1"];
[_objArr,uSpawn,150] call ADF_fnc_objectMarker;
{[_x] call ADF_fnc_reMarker} forEach ["respawn_west","mVehRepair","mKav"];
