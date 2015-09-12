diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove
call compile preprocessFileLineNumbers "scr\ADF_redress_NRF.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createIED.sqf";

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD,MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA,MRAP_2_1_BRAVO,MRAP_2_2_ALPHA,MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1,MRAP_2_3_WT2];

///// NRF JOHNSON

// Static Defences & Ambient Vehicles
NRF_grp_3 = CreateGroup WEST; 
_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos uSpawn, [], 0, "SERGEANT"]; _p moveInGunner oStat_01;
_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos uSpawn, [], 0, "CORPORAL"]; _p moveInGunner oStat_02;
NRF_grp_3 setGroupIdGlobal ["5-1 CHARLIE"];

NRF_grp_4 = CreateGroup WEST; 
uFuelTruck = NRF_grp_4 createUnit ["B_Soldier_F", getPos uSpawn, [], 0, "PRIVATE"];
NRF_grp_4 setGroupIdGlobal ["22 DELTA"];

NRF_grp_5 = CreateGroup WEST; 
uPatrol_1 = NRF_grp_5 createUnit ["B_Soldier_F", getPos uSpawn, [], 0, "CORPORAL"];
uPatrol_2 = NRF_grp_5 createUnit ["B_Soldier_F", getPos uSpawn, [], 0, "PRIVATE"];
NRF_grp_5 setGroupIdGlobal ["5-2 BRAVO"];

{{[_x] call ADF_fnc_redressNRF;} forEach units _x} forEach [NRF_grp_3,NRF_grp_4,NRF_grp_5];


{_x allowDamage false} forEach [uPatrol_1,uPatrol_2,vPatrol,uFuelTruck,vFuelTruck];

[] spawn {
	uPatrol_1 moveInGunner vPatrol;
	uPatrol_2 moveInDriver vPatrol;
	waitUntil {time > 100};		
	_wp = NRF_grp_5 addWaypoint [getMarkerPos "mMSR_15", 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointCombatMode "GREEN";
	_wp setWaypointCompletionRadius 250;	
	waitUntil {sleep 3;if (time > 600) exitWith {};(currentWaypoint (_wp select 0)) > (_wp select 1)};
	{deleteVehicle _x} forEach [uPatrol_1,uPatrol_2,vPatrol];
};

[] spawn {
	uFuelTruck moveInDriver vFuelTruck;
	vFuelTruck engineOn true;
	waitUntil {time > 85};
	
	_wp = NRF_grp_4 addWaypoint [getMarkerPos "mMSR_14", 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "NORMAL";
	_wp setWaypointCombatMode "GREEN";
	_wp setWaypointCompletionRadius 250;	
	waitUntil {sleep 5;if (time > 600) exitWith {};(currentWaypoint (_wp select 0)) > (_wp select 1)};
	{deleteVehicle _x} forEach [uFuelTruck,vFuelTruck];
};

// Foot patrols	
NRF_grp_1 = [getPos uSpawn, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_1;
NRF_grp_1 setGroupIdGlobal ["5-1 ALPHA"];

NRF_grp_2 = [getPos uSpawn, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_2;
NRF_grp_2 setGroupIdGlobal ["5-1 BRAVO"];

{[_x, position leader _x, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "", "", [1,2,3]] call CBA_fnc_taskPatrol;} forEach [NRF_grp_1,NRF_grp_2];

sleep .5;
{{_x setObjectTextureGlobal [0, "\a3\characters_f\BLUFOR\Data\clothing_sage_co.paa"];} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3,NRF_grp_4,NRF_grp_5];

// Create random IED's
_iedMarkerArr = ["mIED_1","mIED_2","mIED_3","mIED_4","mIED_5","mIED_6","mIED_7","mIED_8","mIED_9","mIED_10","mIED_11","mIED_12","mIED_13","mIED_14","mIED_15","mIED_16"];
for "_i" from 1 to 12 do {
	private ["_iedMarkerPos","_v","_mN","_m","_idx"];
	_iedMarkerPos = _iedMarkerArr call BIS_fnc_selectRandom;
	_idx =  _iedMarkerArr find _iedMarkerPos;
	_iedMarkerArr deleteAt _idx;
	[_iedMarkerPos,100,250,6] call ADF_fnc_createRandomIEDs;
};

// Create the Pashtn base of operations
execVM "Scr\SOD_BOP.sqf";

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
"Land_BagBunker_Large_F",
"Land_Cargo40_military_green_F",
"Land_Cargo40_sand_F",
"Land_Cargo20_military_green_F",
"Land_Cargo20_sand_F",
"Land_ReservoirTank_Airport_F",
"Land_u_Barracks_V2_F",
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
[_mmObjArray,	"mJohnson",100] call ADF_fnc_objectMarker;

// Re-create critical markers
{[_x] call ADF_fnc_reMarker} forEach ["mJohnson","mFobMed"];
