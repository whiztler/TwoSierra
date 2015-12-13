/****************************************************************
ARMA Mission Development Framework
ADF version: 1.42 / SEPTEMBER 2015

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
"Land_fortified_nest_big",
"Land_HBarrierTower_F",
"Land_HBarrierBig_F",
"Land_fortified_nest_small_EP1",
"Land_Fort_Watchtower_EP1",
"Land_HBarrier_large",
"Land_HBarrier_5_F",
"Land_HBarrier_3_F",
"Land_HBarrierWall_corridor_F",
"Land_HBarrierWall_corner_F",
"Land_HBarrierWall4_F",
"Land_HBarrierWall6_F",
"US_WarfareBFieldhHospital_Base_EP1",
"US_WarfareBBarracks_Base_EP1",
"Land_Barrack2_EP1",
"MASH_EP1",
"StorageBladder_01_fuel_sand_F",
"Land_Ind_TankSmall2_EP1",
"PowGen_Big_EP1",
"US_WarfareBVehicleServicePoint_Base_EP1",
"US_WarfareBUAVterminal_Base_EP1",
"US_WarfareBAntiAirRadar_Base_EP1",
"Land_Hangar_2",
"Land_BagBunker_Large_F",
"Land_Cargo40_military_green_F",
"Land_Cargo40_sand_F",
"Land_Cargo20_military_green_F",
"Land_Cargo20_sand_F",
"Land_ReservoirTank_Airport_F",
"Land_u_Barracks_V2_F",
"Land_i_Barracks_V1_F",
"Land_Cargo_House_V3_F",
"Land_Cargo_House_V1_F",
"Land_Cargo_Patrol_V1_F",
"Land_Cargo_Patrol_V3_F",
"Land_Cargo_Tower_V1_F",
"Land_Cargo_Tower_V3_F",
"Land_TentHangar_V1_F",
"Land_CncBarrier_stripes_F"
];

// Obj Map markerAlpha
[_mmObjArray,	"mNola",600] call ADF_fnc_objectMarker;
[_mmObjArray,	"mDiana",150] call ADF_fnc_objectMarker;

// Re-create critical markers
{[_x] call ADF_fnc_reMarker} forEach ["mB2","mB3","mB4","mB5","mB6","mB7","mB8","mMed_1","mDiana"];