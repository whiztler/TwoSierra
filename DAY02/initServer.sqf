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

//ADF_debug = false;
[] spawn {waitUntil {time > 0}; enableEnvironment FALSE;};
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";

if (isDedicated) then {
	#include "Core\ADF_init_rpt.sqf"
};

//  Execute Core Third Party SERVER scripts: (comment out if not applicable)
_mmObjArray = [
"Land_fortified_nest_big",
"Land_fortified_nest_small_EP1",
"Land_Fort_Watchtower_EP1",
"Land_HBarrier_large",
"Land_HBarrier_5_F",
"Land_HBarrier_3_F",
"US_WarfareBFieldhHospital_Base_EP1",
"US_WarfareBBarracks_Base_EP1",
"Land_Barrack2_EP1",
"StorageBladder_01_fuel_sand_F",
"Land_Ind_TankSmall2_EP1",
"PowGen_Big_EP1",
"US_WarfareBVehicleServicePoint_Base_EP1",
"US_WarfareBUAVterminal_Base_EP1",
"Land_CncBarrier_stripes_F"
];

// Obj Map markerAlpha
[_mmObjArray,	"mAegisText_1",300] call ADF_fnc_objectMarker;
[_mmObjArray,	"mAegisCP",50] call ADF_fnc_objectMarker;

// Re-create critical markers
{[_x] call ADF_fnc_reMarker} forEach ["mAegisHQ","mAegisFort_1","mAegisFort","mAegisMed","mAegisFort_2","mAegisFort_3","mVehRepair"];