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

call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";

if (isDedicated) then {
	#include "Core\ADF_init_rpt.sqf"
};

//  Execute Core Third Party SERVER scripts: (comment out if not applicable)
_mmObjArray = [
	"Land_Dome_Big_F",
	"Land_Dome_Small_F",
	"Land_Research_house_V1_F",
	"Land_Research_HQ_F",
	"Land_i_Barracks_V2_F",
	"Land_MilOffices_V1_F",
	"Land_Cargo_Tower_V3_F",
	"TK_WarfareBAntiAirRadar_Base_EP1",
	"Land_CncBarrier_stripes_F",
	"Land_Cargo_HQ_V3_F",
	"Land_Fort_Watchtower_EP1",
	"Land_Cargo40_military_green_F",
	"Land_Cargo40_sand_F",
	"Land_Cargo20_military_green_F",
	"Land_Cargo20_sand_F"
];

// Obj Map markerAlpha
[_mmObjArray,	"mBpat_2",700] call ADF_fnc_objectMarker;

// Re-create critical markers
{[_x] call ADF_fnc_reMarker} forEach ["mBase"];