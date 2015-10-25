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
call compile preprocessFileLineNumbers "scr\ADF_redress_NRF.sqf";

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD,MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA,MRAP_2_1_BRAVO,MRAP_2_2_ALPHA,MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1,MRAP_2_3_WT2];
[AMMOTRUCK] execVM "Core\C\ADF_vCargo_B_TruckAmmo.sqf";

///// NOLA Support

// Foot patrols	
NRF_grp_1 = [getPos bSpawn1, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
NRF_grp_1 setGroupIdGlobal ["5-1 ALPHA"];
NRF_grp_2 = [getPos bSpawn2, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
NRF_grp_2 setGroupIdGlobal ["5-1 BRAVO"];
NRF_grp_3 = [getPos bSpawn3, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
NRF_grp_3 setGroupIdGlobal ["5-2 ALPHA"];

// Static Defences & Gunners
NRF_grp_4 = CreateGroup WEST; 
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos bSpawn3, [], 0, "SERGEANT"]; _p moveInGunner sApt_1;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos bSpawn3, [], 0, "CORPORAL"]; _p moveInGunner sApt_2;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos bSpawn3, [], 0, "PRIVATE"]; _p moveInGunner sApt_3;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos bSpawn3, [], 0, "PRIVATE"]; _p moveInGunner sApt_4;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos bSpawn3, [], 0, "SERGEANT"]; _p moveInGunner bDef_01;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos bSpawn3, [], 0, "SERGEANT"]; _p moveInGunner bDef_02;
NRF_grp_4 setGroupIdGlobal ["5-2 BRAVO"];

{{[_x] call ADF_fnc_redressNRF;} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3,NRF_grp_4];

{[_x, position leader _x, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3];

sleep .5;
{{_x setObjectTextureGlobal [0, "\a3\characters_f\BLUFOR\Data\clothing_sage_co.paa"];} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3,NRF_grp_4];

///// DIANA

_g = createGroup INDEPENDENT;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mDiana", [], 0, "SERGEANT"]; _p moveInGunner sDiana_1;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mDiana", [], 0, "CORPORAL"]; _p moveInGunner sDiana_6;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mDiana", [], 0, "PRIVATE"]; _p moveInGunner sDiana_3;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mDiana", [], 0, "PRIVATE"]; _p moveInGunner sDiana_2;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mDiana", [], 0, "SERGEANT"]; _p moveInGunner sDiana_8;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mDiana", [], 0, "SERGEANT"]; _p moveInGunner sDiana_20;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mDiana", [], 0, "SERGEANT"]; _p moveInGunner sDiana_21;
{[_x] call ADF_fnc_redressCherno} forEach units _g;

///// Airbus
vAirbus1TO = false;

[] spawn {
	private ["_c","_p","_wp"];
	sleep ((random 150) + (random 150));
	vAirbus1TO = true;
	_c = createGroup WEST;
	_p = _c createUnit ["B_Helipilot_F", getPos bSpawn3, [], 0, "SERGEANT"]; _p moveInDriver vAirbus1;
	_wp = _c addWaypoint [getMarkerPos "mFargo", 0];
	_wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "GREEN";
	vAirbus1 flyInHeight 20;
	waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
	sleep 2;
	if !(isNil "vAirbus1") then {{deleteVehicle _x} forEach (crew vAirbus1); deleteVehicle vAirbus1; vAirbus1 = nil};
};

[] spawn {
	private ["_c","_p","_wp"];
	waitUntil {sleep 5; vAirbus1TO};
	sleep 5;
	_c = createGroup WEST;
	_p = _c createUnit ["B_Helipilot_F", getPos bSpawn3, [], 0, "SERGEANT"]; _p moveInDriver vAirbus2;
	_wp = _c addWaypoint [getMarkerPos "mFargo", 0];
	_wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "GREEN";
	vAirbus2 flyInHeight 20;
	waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
	sleep 2;
	if !(isNil "vAirbus2") then {{deleteVehicle _x} forEach (crew vAirbus2); deleteVehicle vAirbus2; vAirbus2 = nil};
};

///// ASSAULT

private ["_assaultTimer","_opforCnt","_opforCntWin","_assaultStartTime"];
// Init
_assaultTimer			= [600,700,800,900,1000,1100,1200] call BIS_fnc_selectRandom;
_assaultTimer 		= _assaultTimer - (random floor 300);
_assaultTimer			= round _assaultTimer;
_opforCnt			= 0;
_opforCntWin			= 0;
ADF_vehSpawnCnt		= 0;	
ADF_line_north		= false;
ADF_line_west			= false;
ADF_line_south		= false;
ADF_CAS_active		= false;
ADF_redZoneOpforCnt	= 0;

diag_log	"-----------------------------------------------------";
diag_log format ["TWO SIERRA: Assault timer: %1 min",round (_assaultTimer/60)];
diag_log	"-----------------------------------------------------";

ADF_mots_assaultTimer = (_assaultTimer - 300); publicVariable "ADF_mots_assaultTimer"; // MOTS

// Wait till the timer runs out
if (ADF_debug) then {_assaultTimer = 45};
while {_assaultTimer != 1} do {
	_assaultTimer = _assaultTimer - 1;
	uiSleep 1;
	//hintSilent str _assaultTimer;
};

_assaultStartTime = time;
diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Assault started";
diag_log	"-----------------------------------------------------";

// Infantry assault groups
[] spawn {
	for "_i" from 0 to 2 do {
		private ["_spawnPos","_g","_wp","_spawnPause"];
		_spawnPos = "mLine1a";
		
		_g = [getMarkerPos _spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressRebel} forEach units _g;
		_g allowFleeing 0;
		(leader _g) setSkill ['commanding', 1];
		
		_wp = _g addWaypoint [getMarkerPos "mLine1b", 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
		_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED";
		
		_spawnPause = [45,60,90,120] call BIS_fnc_selectRandom;
		sleep _spawnPause;
		ADF_vehSpawnCnt = ADF_vehSpawnCnt + _spawnPause;
	};
	ADF_line_north = true;
};
[] spawn {
	for "_i" from 0 to 2 do {
		private ["_spawnPos","_g","_wp","_spawnPause"];
		_spawnPos = "mLine2a";
		
		_g = [getMarkerPos _spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressRussian} forEach units _g;
		
		_wp = _g addWaypoint [getMarkerPos "mLine2b", 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
		_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED";
		
		_spawnPause = [45,60,90,120] call BIS_fnc_selectRandom;
		sleep _spawnPause;
		ADF_vehSpawnCnt = ADF_vehSpawnCnt + _spawnPause;
	};
	ADF_line_west = true;
};
[] spawn {
	for "_i" from 0 to 2 do {
		private ["_spawnPos","_g","_wp","_spawnPause"];
		_spawnPos = "mLine3a";
		
		_g = [getMarkerPos _spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressRebel} forEach units _g;
		
		_wp = _g addWaypoint [getMarkerPos "mLine3b", 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
		_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED";
		
		_spawnPause = [45,60,90,120] call BIS_fnc_selectRandom;
		sleep _spawnPause;
		ADF_vehSpawnCnt = ADF_vehSpawnCnt + _spawnPause;
	};
	ADF_line_south = true;
};
[] spawn {
	private ["_spawnPos","_g","_wp","_spawnPause"];
	_spawnPos = "mLine4a";
	
	_g = [getMarkerPos _spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;
	
	_wp = _g addWaypoint [getMarkerPos "mLine4b", 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
	_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED";
};

waitUntil {ADF_line_south && ADF_line_west && ADF_line_north};

// Count spawned units
private ["_ADF_OpforCnt","_ADF_IndepCnt","_ADF_WestCnt","_ADF_OpforCntAll","_OpforVehCnt","_ADF_OpforCntToWin","_Cnt"];
_ADF_OpforCnt = {(side _x == EAST) && (alive _x)} count allUnits;
_ADF_IndepCnt = {(side _x == INDEPENDENT) && (alive _x)} count allUnits;
_ADF_WestCnt = {(side _x == WEST) && (alive _x) && !isPlayer _x} count allUnits;

diag_log	"----------------------------------------------------------------------";
diag_log format ["TWO SIERRA: AO OpFor spawned, number of Opfor: %1",_ADF_OpforCnt];
diag_log format ["TWO SIERRA: AO Independent spawned, number of Independent: %1",_ADF_IndepCnt];
diag_log format ["TWO SIERRA: AO BluFor spawned, number of BluFor: %1",_ADF_WestCnt];
diag_log	"----------------------------------------------------------------------";

[] spawn {
	// Kajman
	waitUntil {sleep 3; ADF_CAS_active};
	waitUntil {sleep 1; triggerActivated tCAS};
	createVehicleCrew vAir_1;
	_g = group ((crew vAir_1) select 0);
	{[_x] call ADF_fnc_redressRussian} forEach units _g;
	_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FAST"; _wp setWaypointCombatMode "RED";
};


waitUntil {sleep 10; triggerActivated tAO_active};
deleteVehicle tAO_active;
sleep 300;

// MBT's
private ["_g","_wp"];
createVehicleCrew vMBt_1;
_g = group ((crew vMBt_1) select 0);
{[_x] call ADF_fnc_redressRussian} forEach units _g;
_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FAST"; _wp setWaypointCombatMode "RED";
sleep 10;
createVehicleCrew vMBt_2;
_g = group ((crew vMBt_2) select 0);
{[_x] call ADF_fnc_redressRussian} forEach units _g;
_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FAST"; _wp setWaypointCombatMode "RED";
createVehicleCrew vMBt_3;
_g = group ((crew vMBt_3) select 0);
{[_x] call ADF_fnc_redressRussian} forEach units _g;
_wp = _g addWaypoint [getMarkerPos "mDiana", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FAST"; _wp setWaypointCombatMode "RED";

// Victors
sleep 180;
for "_i" from 1 to 5 do {
	private ["_spawnPos","_spawnDir","_c","_v","_vX"];
	_spawnPos = "mV1";
	_spawnDir = markerDir _spawnPos;
	_spawnPos = getMarkerPos _spawnPos;		

	_c = createGroup EAST;
	_v = [_spawnPos, _spawnDir, "O_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressRebel} forEach units _c;
	
	_vX = _v select 0;
	_vX setVariable ["BIS_enableRandomization", false];
	[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
	
	_wp = _c addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "RED";
	sleep 15;
};

// FlyBy's
[getMarkerPos "mLapotino", getMarkerPos "mEndFlyBy", 150, "FULL", "O_Plane_CAS_02_F", EAST] call BIS_fnc_ambientFlyby; sleep 3;
[getMarkerPos "mLapotino", getMarkerPos "mEndFlyBy", 150, "FULL", "O_Plane_CAS_02_F", EAST] call BIS_fnc_ambientFlyby; sleep 30;
[getMarkerPos "mLapotino", getMarkerPos "mEndFlyBy", 150, "FULL", "O_Plane_CAS_02_F", EAST] call BIS_fnc_ambientFlyby; sleep 3;
[getMarkerPos "mLapotino", getMarkerPos "mEndFlyBy", 150, "FULL", "O_Plane_CAS_02_F", EAST] call BIS_fnc_ambientFlyby;

//APC's
sleep 220;
private ["_g","_wp"];
createVehicleCrew vAPC_1;
_g = group ((crew vAPC_1) select 0);
_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "NORMAl"; _wp setWaypointCombatMode "RED";
sleep 10;
createVehicleCrew vAPC_2;
_g = group ((crew vAPC_2) select 0);
_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "NORMal"; _wp setWaypointCombatMode "RED";

// Count spawned units again and substract vehicle crews & Track Opfor count for win scenario
_ADF_OpforCntAll = {(side _x == EAST) && (alive _x)} count allUnits;
_OpforVehCnt = _ADF_OpforCntAll - _ADF_OpforCnt;
_ADF_OpforCntToWin = ((_ADF_OpforCntAll - _OpforVehCnt) / 10) + (random 10);

diag_log	"----------------------------------------------------------------------";
diag_log format ["TWO SIERRA: AO OpFor spawned, total number of Opfor (incl vehicles): %1",_ADF_OpforCntAll];
diag_log format ["TWO SIERRA: AO OpFor spawned, opfor vehicle crews: %1",_OpforVehCnt];
diag_log format ["TWO SIERRA: AO Opfor mission success count: %1",_ADF_OpforCntToWin];
diag_log	"----------------------------------------------------------------------";

waitUntil {
	sleep 15;
	_Cnt = {(side _x == EAST) && (alive _x)} count allUnits;
	((_ADF_OpforCntToWin < _Cnt) || (time > 7200));
};

private "_proc";
_proc = "";
if (time > 7200) then {_proc = "time > 7200"} else {_proc = "Opfor ratio"};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: End Mission process started";
diag_log format ["TWO SIERRA: Process: %1",_proc];
diag_log	"-----------------------------------------------------";

ADF_endMission = true; publicVariable "ADF_endMission";