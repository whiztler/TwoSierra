diag_log "ADF RPT: Init - executing init_AO.sqf"; // Reporting. Do NOT edit/remove

///// ASSAULT

private ["_assaultTimer","_opforCnt","_opforCntWin","_assaultStartTime"];
// Init
_assaultTimer			= [600,700,800,900,1000,1100,1200] call BIS_fnc_selectRandom;
_assaultTimer 		= _assaultTimer - (random floor 200);
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
	if (MotsActive) exitWith {};
	//hintSilent str _assaultTimer;
};

_assaultStartTime = time;
diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Assault started";
diag_log	"-----------------------------------------------------";

// Infantry assault groups
[] spawn {
	for "_i" from 0 to 4 do {
		private ["_spawnPos","_g","_wp","_spawnPause"];
		_spawnPos = "mLine1a";
		_spawnPause = [45,60,90,120] call BIS_fnc_selectRandom;
		
		_g = [getMarkerPos _spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressRebel} forEach units _g;
		_g allowFleeing 0;
		(leader _g) setSkill ['commanding', 1];
		_wpx = ["mLine1b1","mLine1b2","mLine1b3"] call BIS_fnc_selectRandom;
		
		_wp = _g addWaypoint [getMarkerPos _wpx, 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
		_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED";
		
		if (ADF_debug) then {_spawnPause = 10};
		sleep _spawnPause;
		ADF_vehSpawnCnt = ADF_vehSpawnCnt + _spawnPause;
	};
	ADF_line_north = true;
};

[] spawn {
	for "_i" from 0 to 4 do {
		private ["_spawnPos","_g","_wp","_spawnPause"];
		_spawnPos = "mLine2a";
		_spawnPause = [45,60,90,120] call BIS_fnc_selectRandom;
		
		_g = [getMarkerPos _spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressRussian} forEach units _g;
		_g allowFleeing 0;
		(leader _g) setSkill ['commanding', 1];
		_wpx = ["mLine2b1","mLine2b2","mLine2b3"] call BIS_fnc_selectRandom;
		
		_wp = _g addWaypoint [getMarkerPos _wpx, 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
		_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED";
		
		if (ADF_debug) then {_spawnPause = 10};
		sleep _spawnPause;
		ADF_vehSpawnCnt = ADF_vehSpawnCnt + _spawnPause;
	};
	ADF_line_west = true;
};

[] spawn {
	for "_i" from 0 to 2 do {
		private ["_spawnPos","_g","_wp","_spawnPause"];
		_spawnPos = "mLine3a";
		_spawnPause = [45,60,90,120] call BIS_fnc_selectRandom;
		
		_g = [getMarkerPos _spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressRebel} forEach units _g;
		_g allowFleeing 0;
		(leader _g) setSkill ['commanding', 1];
		_wpx = ["mLine3b1","mLine3b2","mLine3b3"] call BIS_fnc_selectRandom;
		
		_wp = _g addWaypoint [getMarkerPos _wpx, 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
		_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED";
		
		if (ADF_debug) then {_spawnPause = 10};
		sleep _spawnPause;
		ADF_vehSpawnCnt = ADF_vehSpawnCnt + _spawnPause;
	};
	ADF_line_south = true;
	remoteExec ["ADF_msg_INF",0,true];
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

_ADF_OpforCntToWin = (_ADF_OpforCnt / 10) + (random 10);
_ADF_OpforCntToWin = floor _ADF_OpforCntToWin;
if (_ADF_OpforCnt < 50) then {_ADF_OpforCntToWin = 10};
if (_ADF_OpforCntToWin < 10) then {_ADF_OpforCntToWin = 10};

[] spawn {
	// Kajman
	waitUntil {sleep 3; ADF_CAS_active};
	sleep 360;
	createVehicleCrew vAir_1;
	_g = group ((crew vAir_1) select 0);
	{[_x] call ADF_fnc_redressRussian} forEach units _g;
	_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FAST"; _wp setWaypointCombatMode "RED";
};

waitUntil {sleep 10; triggerActivated tAO_active};
deleteVehicle tAO_active;
if (ADF_debug) then {sleep 10} else {sleep 300};

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

remoteExec ["ADF_msg_MBT",0,true];

// Victors
if (ADF_debug) then {sleep 10} else {sleep 180};
[] spawn {
	for "_i" from 1 to 8 do {
		private ["_spawnPos","_spawnDir","_c","_v","_vX"];
		_spawnPos = "mV1";
		_spawnDir = markerDir _spawnPos;
		_spawnPos = getMarkerPos _spawnPos;		

		_c = createGroup east;
		_v = [_spawnPos, _spawnDir, "O_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
		{[_x] call ADF_fnc_redressRebel} forEach units _c;
		
		_vX = _v select 0;
		_vX setVariable ["BIS_enableRandomization", false];
		[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
		
		_wp = _c addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "RED";
		sleep ((random 100) + (random 100));
	};
};
if (ADF_debug) then {sleep 10} else {sleep 180};

// FlyBy's
[] spawn {
	[getMarkerPos "mLapotino", getMarkerPos "mEndFlyBy", random 150, "FULL", "O_Plane_CAS_02_F", EAST] call BIS_fnc_ambientFlyby; sleep 3;
	[getMarkerPos "mLapotino", getMarkerPos "mEndFlyBy", random 150, "FULL", "O_Plane_CAS_02_F", EAST] call BIS_fnc_ambientFlyby;
};

//APC's
if (ADF_debug) then {sleep 10} else {sleep 220};
private ["_g","_wp"];
createVehicleCrew vAPC_1;
_g = group ((crew vAPC_1) select 0);
_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "NORMAl"; _wp setWaypointCombatMode "RED";
sleep 10;
createVehicleCrew vAPC_2;
_g = group ((crew vAPC_2) select 0);
_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "NORMal"; _wp setWaypointCombatMode "RED";

// Count spawned units again and substract vehicle crews & Track Opfor count for win scenario
_ADF_OpforCntAll = {side _x == EAST} count allUnits;
_OpforVehCnt = _ADF_OpforCntAll - _ADF_OpforCnt;

diag_log	"----------------------------------------------------------------------";
diag_log format ["TWO SIERRA: AO OpFor spawned, total number of Opfor (incl vehicles): %1",_ADF_OpforCntAll];
diag_log format ["TWO SIERRA: AO OpFor spawned, Infantry: %1",_ADF_OpforCnt];
diag_log format ["TWO SIERRA: AO OpFor spawned, OpFor vehicle crews: %1",_OpforVehCnt];
diag_log format ["TWO SIERRA: AO Opfor mission success count: %1",_ADF_OpforCntToWin];
diag_log	"----------------------------------------------------------------------";

ADF_init_AO = true; publicVariable "ADF_init_AO";
ADF_sweepMsg = false;

waitUntil {
	sleep 10;
	private "_c";
	_c = {side _x == EAST} count allUnits;
	diag_log format ["TWO SIERRA: Current AO Opfor count: %1 (condition: < %2)",_c,_ADF_OpforCntToWin];
	if (_c < 25 && !ADF_sweepMsg) then {remoteExec ["ADF_msg_sweep",0,true]; ADF_sweepMsg = true;};
	((_c < _ADF_OpforCntToWin) || (time > 9000));
};

private "_proc";
_proc = "";
if (time > 9000) then {_proc = "time > 9000 (2,5 hours)"} else {_proc = "Opfor ratio"};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: End Mission process started";
diag_log format ["TWO SIERRA: Process: %1",_proc];
diag_log format ["TWO SIERRA: Current AO Opfor count: %1 (condition: < %2)",_c,_ADF_OpforCntToWin];
diag_log	"-----------------------------------------------------";

remoteExec ["ADF_msg_endMission",0,true];