diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove

// init
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_position.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_distance.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_defendArea.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_footPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createIED.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";
call compile preprocessFileLineNumbers "scr\ADF_redress_NRF.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_Rebels.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_Russians.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_Cherno.sqf";

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD,MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA,MRAP_2_1_BRAVO,MRAP_2_2_ALPHA,MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1,MRAP_2_3_WT2];
{[_x] execVM "Core\C\ADF_vCargo_B_TruckMedi.sqf"} forEach [MEDITRUCK_XO_1,MedFacil];

///// NRF FARGO

// Foot patrols	
NRF_grp_1 = [getPos oGunshipPad_1, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
NRF_grp_1 setGroupIdGlobal ["5-1 ALPHA"];

NRF_grp_2 = [getPos oAirbusPad_1, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
NRF_grp_2 setGroupIdGlobal ["5-1 BRAVO"];

// Static Defences & Ambient Vehicles
NRF_grp_3 = CreateGroup WEST; 
_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "SERGEANT"]; _p moveInGunner oStat_01;
_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "CORPORAL"]; _p moveInGunner oStat_02;
_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_03;
//_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_04;
//_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_05;
//_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "CORPORAL"]; _p moveInGunner oStat_06;
//_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_07;
//_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_08;
NRF_grp_3 setGroupIdGlobal ["5-1 CHARLIE"];

{_x enableSimulationGlobal false} forEach units NRF_grp_3;
{{[_x] call ADF_fnc_redressNRF;} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3];

{[_x, position leader _x, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;} forEach [NRF_grp_1,NRF_grp_2];

sleep .5;
{{_x setObjectTextureGlobal [0, "\a3\characters_f\BLUFOR\Data\clothing_sage_co.paa"];} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3];

// Create random IED's
private ["_iedMarkerArr"];
_iedMarkerArr = ["mIED_1","mIED_2","mIED_3","mIED_4","mIED_5","mIED_6","mIED_7","mIED_8","mIED_9","mIED_10","mIED_11","mIED_12","mIED_13","mIED_14","mIED_15","mIED_16","mIED_17","mIED_18","mIED_19"];
for "_i" from 1 to 7 do {
	private ["_iedMarkerPos","_idx"];
	_iedMarkerPos		= _iedMarkerArr call BIS_fnc_selectRandom;
	_idx				= _iedMarkerArr find _iedMarkerPos;
	_iedMarkerArr deleteAt _idx;
	[_iedMarkerPos,100,250,4.5] call ADF_fnc_createRandomIEDs;
};

indep_cp1 = [CP_1a,CP_1b,CP_1c,CP_1d]; {_x enableSimulationGlobal false; _x hideObjectGlobal true;} forEach indep_cp1;
indep_cp2 = [CP_2a,CP_2b,CP_2c,CP_2d]; {_x enableSimulationGlobal false; _x hideObjectGlobal true;} forEach indep_cp2;
indep_cp3 = [CP_3a,CP_3b,CP_3c,CP_3d]; {_x enableSimulationGlobal false; _x hideObjectGlobal true;} forEach indep_cp3;
indep_cp4 = [CP_4a,CP_4b,CP_4c,CP_4d]; {_x enableSimulationGlobal false; _x hideObjectGlobal true;} forEach indep_cp4;

	
_mmObjArray = [
"Land_fortified_nest_big",
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
[_mmObjArray,	"mFargo",400] call ADF_fnc_objectMarker;

// Re-create critical markers
{[_x] call ADF_fnc_reMarker} forEach ["mFargo","mMed"];

#include "init_AO.sqf"