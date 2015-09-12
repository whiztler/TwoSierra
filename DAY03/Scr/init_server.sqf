diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove
if (!isServer) exitWith {};
call compile preprocessFileLineNumbers "Scr\ADF_redress_NRF.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createIED.sqf";

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD,MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA,MRAP_2_1_BRAVO,MRAP_2_2_ALPHA,MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1,MRAP_2_3_WT2];

///// NRF LMAB

// Static Defences
NRF_grp_4 = CreateGroup WEST; 
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "SERGEANT"]; _p moveInGunner oStat_01;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "CORPORAL"]; _p moveInGunner oStat_02;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "CORPORAL"]; _p moveInGunner oStat_03;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "PRIVATE"]; _p moveInGunner oStat_04;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "PRIVATE"]; _p moveInGunner oStat_05;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "PRIVATE"]; _p moveInGunner oStat_06;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "PRIVATE"]; _p moveInGunner oStat_07;
{[_x] call ADF_fnc_redressNRF; _x enableSimulationGlobal false;} forEach units NRF_grp_4;
NRF_grp_4 setGroupIdGlobal ["5-3 CHARLIE"];

// Foot patrols	
NRF_grp_1 = [getPos oLand_1, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_1;
NRF_grp_1 setGroupIdGlobal ["5-1 ALPHA"];
[NRF_grp_1, position leader NRF_grp_1, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "", "", [1,2,3]] call CBA_fnc_taskPatrol;

NRF_grp_2 = [getPos oLand_2, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_2;
NRF_grp_2 setGroupIdGlobal ["5-1 BRAVO"];
[NRF_grp_2, position leader NRF_grp_2, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "", "", [1,2,3]] call CBA_fnc_taskPatrol;

NRF_grp_3 = [getPos (b_net), WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_3;
NRF_grp_3 setGroupIdGlobal ["5-2 ALPHA"];
[NRF_grp_3, position leader NRF_grp_3, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "", "", [1,2,3]] call CBA_fnc_taskPatrol;	

// Create random IED's
_iedMarkerArr = ["mIED_1","mIED_2","mIED_3","mIED_4","mIED_5","mIED_6","mIED_7","mIED_8","mIED_9","mIED_10","mIED_11","mIED_12","mIED_13","mIED_14","mIED_15","mIED_16"];
for "_i" from 1 to 10 do {
	private ["_iedMarkerPos","_v","_mN","_m","_idx"];
	_iedMarkerPos = _iedMarkerArr call BIS_fnc_selectRandom;
	_idx =  _iedMarkerArr find _iedMarkerPos;
	_iedMarkerArr deleteAt _idx;
	[_iedMarkerPos,100,250,6] call ADF_fnc_createRandomIEDs;
};

// Dolphin vehicle
[vDolphin,0, 120] call bis_fnc_setpitchbank;
vDolphin setDamage .7;
vDolphin setHit ["wheel_1_2_steering", 1];
vDolphin setHit ["wheel_1_4_steering", 1];
vDolphin setHit ["wheel_1_1_steering", 1];
	
{{_x setObjectTextureGlobal [0, "\a3\characters_f\BLUFOR\Data\clothing_sage_co.paa"];} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3,NRF_grp_4];

[] spawn {
	waitUntil {sleep 10; triggerActivated tStart || time > 1250};
	sleep 120; // wait for all units to spawn
	deleteVehicle tStart;
	
	// Count units/track time for win/loose scenario
	ADF_OpforCnt = {(side _x == INDEPENDENT) && (alive _x)} count allUnits;
	_opforCntWin = round ((ADF_OpforCnt / 7) + (random 10));
	_ADF_missionTime = ADF_missionStartTime + 7200;

	diag_log	"-----------------------------------------------------";
	diag_log format ["TWO SIERRA: AO spawned. Number of OpFor: %1",ADF_OpforCnt];
	diag_log	"-----------------------------------------------------";

	waitUntil {
		sleep 30;
		_cnt = {(side _x == INDEPENDENT) && (alive _x)} count allUnits;
		((_cnt <= _opforCntWin) || (time > _ADF_missionTime)); // 2 hours + prep time
	};

	diag_log	"-----------------------------------------------------";
	diag_log "TWO SIERRA: End Mission process started";
	diag_log	"-----------------------------------------------------";

	ADF_endMission = true; publicVariable "ADF_endMission";

	// Create end mission trigger at LMAB
	tEndMission = createTrigger ["EmptyDetector", getMarkerPos "mLMAB", true];
	tEndMission setTriggerActivation ["WEST","PRESENT",false];
	tEndMission setTriggerArea [200,325,240,true];
	tEndMission setTriggerTimeout [0,0,0,false];
	tEndMission setTriggerStatements [
		"{vehicle _x in thisList && isPlayer _x && ((getPosATL _x) select 2) < 5} count allUnits > 0;",
		"[] spawn ADF_msg_endMission;",
		""
	];
};

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
[_mmObjArray,	"mLMAB",400] call ADF_fnc_objectMarker;

// Re-create critical markers

//{[_x] call ADF_fnc_reMarker} forEach ["mAegisHQ","mAegisFort_1","mAegisFort","mAegisMed","mAegisFort_2","mAegisFort_3","mVehRepair"];
	
