diag_log "ADF RPT: Init - executing Scr\init_server.sqf"; // Reporting. Do NOT edit/remove
if (!isServer) exitWith {};

call compile preprocessFileLineNumbers "Core\F\ADF_fnc_position.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_distance.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_defendArea.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_footPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createIED.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_NRF.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_Pashtun.sqf";

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
[medTruck] execVM "Core\C\ADF_vCargo_B_TruckMedi.sqf"; 
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD,MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA,MRAP_2_1_BRAVO,MRAP_2_2_ALPHA,MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1,MRAP_2_3_WT2];

///// NRF LMAB

// Static Defences
NRF_grp_4 = CreateGroup WEST; 
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "SERGEANT"]; _p moveInGunner oStat_01;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "CORPORAL"]; _p moveInGunner oStat_02;
//_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "CORPORAL"]; _p moveInGunner oStat_03;
//_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "PRIVATE"]; _p moveInGunner oStat_04;
//_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "PRIVATE"]; _p moveInGunner oStat_05;
//_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "PRIVATE"]; _p moveInGunner oStat_06;
//_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "PRIVATE"]; _p moveInGunner oStat_07;
{[_x] call ADF_fnc_redressNRF; _x enableSimulationGlobal false;} forEach units NRF_grp_4;
NRF_grp_4 setGroupIdGlobal ["5-3 CHARLIE"];

// Foot patrols	
NRF_grp_1 = [getPos oLand_1, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_1;
NRF_grp_1 setGroupIdGlobal ["5-1 ALPHA"];
[NRF_grp_1, position leader NRF_grp_1, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;

NRF_grp_2 = [getPos oLand_2, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_2;
NRF_grp_2 setGroupIdGlobal ["5-1 BRAVO"];
[NRF_grp_2, position leader NRF_grp_2, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;

NRF_grp_3 = [getPos (b_net), WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_3;
NRF_grp_3 setGroupIdGlobal ["5-2 ALPHA"];
[NRF_grp_3, position leader NRF_grp_3, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;

// Create random IED's
_iedMarkerArr = ["mIED_1","mIED_2","mIED_3","mIED_4","mIED_5","mIED_6","mIED_7","mIED_8","mIED_9","mIED_10","mIED_11","mIED_12","mIED_13","mIED_14","mIED_15","mIED_16"];
for "_i" from 1 to 10 do {
	private ["_iedMarkerPos","_idx"];
	_iedMarkerPos 	= _iedMarkerArr call BIS_fnc_selectRandom;
	_idx 			=  _iedMarkerArr find _iedMarkerPos;
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
[_mmObjArray,"mLMAB",400] call ADF_fnc_objectMarker;

// Re-create critical markers
{[_x] call ADF_fnc_reMarker} forEach ["mLMAB","mVehRepair","mMed"];


ADF_wpPosRdm = {
	private "_wpPos";
	_wpPos = ["mAirPos_1","mAirPos_2","mAirPos_3","mAirPos_4","mAirPos_5"] call BIS_fnc_selectRandom;
	_wpPos
};

[] spawn {
	sleep 25;
	while {true} do {
		private ["_c","_v","_wp","_heli","_startPos","_exitPos","_pause"];
		_pause = [300,600,900,1200,1800] call BIS_fnc_selectRandom;
		_startPos = call ADF_wpPosRdm;
		_exitPos = call ADF_wpPosRdm;
		_heli = "B_Heli_Transport_03_F";
		_landPos = [oLand_1,oLand_2] call BIS_fnc_selectRandom;		
		_c = createGroup WEST;
		_v = [getMarkerPos _startPos, 0, _heli, _c] call BIS_fnc_spawnVehicle;
		_c setGroupIdGlobal ["6-1 AIRBUS"];
		vAirbus = _v select 0;
		vAirbus setObjectTextureGlobal [0, "Img\cusTex_NRFcamo.jpg"]; vAirbus setObjectTextureGlobal [1, "Img\cusTex_NRFcamo.jpg"];		
		{_x unassignItem "NVGoggles"; _x removeItem "NVGoggles"; _x enableGunlights "forceOn";} forEach units _c;
		vAirbus flyInHeight 75;
		_wp = _c addWaypoint [getPos _landPos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "NORMAL";
		_wp setWaypointStatements ["true", "vAirbus land 'LAND';"];	
		waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
		waitUntil {isTouchingGround vAirbus};
		{vAirbus animateDoor [_x, 1];} forEach ["door_L_source","door_R_source","Door_rear_source"];
		_pausePad = [60,120,180,240,300,600] call BIS_fnc_selectRandom;
		vAirbus setFuel 0;
		sleep _pausePad;
		vAirbus setFuel 1;
		{vAirbus animateDoor [_x, 0];} forEach ["door_L_source","door_R_source","Door_rear_source"];
		_wp = _c addWaypoint [getMarkerPos _exitPos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "NORMAL";
		waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
		sleep 2;
		if !(isNil "vAirbus") then {{deleteVehicle _x} forEach (crew vAirbus); deleteVehicle vAirbus; vAirbus = nil};
		sleep _pause;
	};
};

[] spawn {
	sleep random 300;
	while {alive vGunship} do {
		private ["_c","_wp","_wpPos","_pausePad"];	
		_c = createGroup WEST;
		_p = _c createUnit ["B_helipilot_F", getMarkerPos "mLMAB",[],0,"LIEUTENANT"]; _p moveInDriver vGunship;
		_p = _c createUnit ["B_helipilot_F", getMarkerPos "mLMAB",[],0,"LIEUTENANT"]; _p moveInGunner vGunship;
		_c setGroupIdGlobal ["6-6 CONDOR"];
		vGunship flyInHeight 50;
		_wpPos = call ADF_wpPosRdm;
		_wp = _c addWaypoint [getMarkerPos _wpPos, 0];
		_wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL";
		_wpPos = call ADF_wpPosRdm;
		_wp = _c addWaypoint [getMarkerPos _wpPos, 0]; _wp setWaypointType "MOVE";
		_wp = _c addWaypoint [getPos oGunshipPad, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "NORMAL";
		_wp setWaypointStatements ["true", "vGunship land 'LAND';"];		
		waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
		waitUntil {isTouchingGround vGunship};
		_pausePad = [300,600,900,1200] call BIS_fnc_selectRandom;
		vGunship setFuel 0;
		if !(isNil "vGunship") then {{deleteVehicle _x} forEach (crew vGunship);};
		vGunship setDir (getDir oGunshipPad);
		sleep _pausePad;
		vGunship setFuel 1;		
	};
};

waitUntil {sleep 10; triggerActivated tStart || time > 1250};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

ADF_missionStartTime = time;

// Random vehicle patrols
for "_i" from 1 to 5 do {
	private ["_spawnPos","_spawnDir","_c","_v","_vX"];
	_spawnPos 	= format ["mGuerVeh_%1",_i];
	_spawnDir	= markerDir _spawnPos;
	_spawnPos	= getMarkerPos _spawnPos;

	_c = createGroup INDEPENDENT;
	_v = [_spawnPos, _spawnDir, "I_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressPashtun} forEach units _c;
	
	_vX = _v select 0;
	_vX setVariable ["BIS_enableRandomization", false];
	[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
	[_c, _spawnPos, 2500, 4, "MOVE", "SAFE", "RED", "LIMITED",25] call ADF_fnc_vehiclePatrol;
};

// AO Defence Fire Team
for "_i" from 1 to 12 do {
	private ["_g","_spawnPos","_defArr"];
	_spawnPos 	= format ["mGuerPaxDef_%1",_i];
	_spawnPos	= getMarkerPos _spawnPos;
	
	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	_defArr = [_g, _spawnPos, 150, 2, true];
	_defArr call ADF_fnc_defendArea;
	_g setVariable ["ADF_HC_garrison_ADF",true];
	_g setVariable ["ADF_HC_garrisonArr",_defArr];	
};

// AO Defence Squad
for "_i" from 20 to 25 do {
	private ["_g","_spawnPos","_defArr"];
	_spawnPos	= format ["mGuerPaxDef_%1",_i];
	_spawnPos	= getMarkerPos _spawnPos;
	
	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	_defArr = [_g, _spawnPos, 150, 2, true];
	_defArr call ADF_fnc_defendArea;
	_g setVariable ["ADF_HC_garrison_ADF",true];
	_g setVariable ["ADF_HC_garrisonArr",_defArr];		
};

// Foot patrols
for "_i" from 1 to 6 do {
	private ["_g","_spawnPos"];
	_spawnPos	= format ["mGuerPatrol_%1",_i];
	_spawnPos	= getMarkerPos _spawnPos;
	
	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	[_g, _spawnPos, 750, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

if (!isNil "tStart") then {deleteVehicle tStart};

private ["_opforCntWin","_ADF_missionTime"];
// Count units/track time for win/loose scenario
ADF_OpforCnt = {(side _x == INDEPENDENT) && (alive _x)} count allUnits;
_opforCntWin = round ((ADF_OpforCnt / 7) + (random 10));
_ADF_missionTime = ADF_missionStartTime + 7200;

diag_log	"-----------------------------------------------------";
diag_log format ["TWO SIERRA: AO spawned. Number of OpFor: %1",ADF_OpforCnt];
diag_log format ["TWO SIERRA: Success mission OpFor count: %1",_opforCntWin];
diag_log	"-----------------------------------------------------";

waitUntil {
	sleep 30;
	_cnt = {(side _x == INDEPENDENT) && (alive _x)} count allUnits;
	((_cnt < _opforCntWin) || (time > _ADF_missionTime)); // 2 hours + prep time
};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: End Mission process started";
diag_log	"-----------------------------------------------------";

ADF_endMission = true; publicVariable "ADF_endMission";



