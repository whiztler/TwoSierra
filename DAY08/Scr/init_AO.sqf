diag_log "ADF RPT: Init - executing init_AO.sqf"; // Reporting. Do NOT edit/remove

///// ASSAULT

private ["_t", "_cnt_Obj", "_cnt_Win", "_at", "_i"];
// Init
_t					= ([600,700,800,900,1000,1100,1200] call BIS_fnc_selectRandom) - (random floor 200);
_cnt_Obj				= 0;
_cnt_Win				= 0;
ADF_vehSpawnCnt		= 0;	
ADF_line_north		= false;
ADF_line_west			= false;
ADF_line_south		= false;
ADF_CAS_active		= false;
ADF_redZoneOpforCnt	= 0;

diag_log	"-----------------------------------------------------";
diag_log format ["TWO SIERRA: Assault timer: %1 min", round (_t/60)];
diag_log	"-----------------------------------------------------";

ADF_mots_t = (_t - 300); publicVariable "ADF_mots_t"; // MOTS

// Wait till the timer runs out
if (ADF_debug) then {_t = 45};
while {_t != 1} do {
	_t = _t - 1;
	uiSleep 1;
	if (MotsActive) exitWith {};
	//hintSilent str _t;
};

_at = time;
diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Assault started";
diag_log	"-----------------------------------------------------";

// Infantry assault groups
[] spawn {
	for "_i" from 0 to 4 do {
		private ["_p", "_g", "_wp", "_s"];
		_p = "mLine1a";
		_s = [45, 60, 90, 120] call BIS_fnc_selectRandom;
		
		_g = [getMarkerPos _p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressRebel} forEach units _g;
		
		_g allowFleeing 0;
		(leader _g) setSkill ['commanding', 1];
		
		_wpx = ["mLine1b1", "mLine1b2", "mLine1b3"] call BIS_fnc_selectRandom;
		_wp = _g addWaypoint [getMarkerPos _wpx, 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
		_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED";
		
		if (ADF_debug) then {_s = 10};
		sleep _s;
		ADF_vehSpawnCnt = ADF_vehSpawnCnt + _s;
	};
	ADF_line_north = true;
};

[] spawn {
	for "_i" from 0 to 4 do {
		private ["_p", "_g", "_wp", "_s"];
		_p = "mLine2a";
		_s = [45, 60, 90, 120] call BIS_fnc_selectRandom;
		
		_g = [getMarkerPos _p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressRussian} forEach units _g;
		
		_g allowFleeing 0;
		(leader _g) setSkill ['commanding', 1];
		
		_wpx = ["mLine2b1", "mLine2b2", "mLine2b3"] call BIS_fnc_selectRandom;
		_wp = _g addWaypoint [getMarkerPos _wpx, 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
		_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED";
		
		if (ADF_debug) then {_s = 10};
		sleep _s;
		ADF_vehSpawnCnt = ADF_vehSpawnCnt + _s;
	};
	ADF_line_west = true;
};

[] spawn {
	for "_i" from 0 to 2 do {
		private ["_p", "_g", "_wp", "_s"];
		_p = "mLine3a";
		_s = [45, 60, 90, 120] call BIS_fnc_selectRandom;
		
		_g = [getMarkerPos _p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressRebel} forEach units _g;
		
		_g allowFleeing 0;
		(leader _g) setSkill ['commanding', 1];
		
		_wpx = ["mLine3b1", "mLine3b2", "mLine3b3"] call BIS_fnc_selectRandom;
		_wp = _g addWaypoint [getMarkerPos _wpx, 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
		_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED";
		
		if (ADF_debug) then {_s = 10};
		sleep _s;
		ADF_vehSpawnCnt = ADF_vehSpawnCnt + _s;
	};
	ADF_line_south = true;
	remoteExec ["ADF_msg_INF", 0, true];
};

[] spawn {
	private ["_p", "_g", "_wp", "_s"];
	_p = "mLine4a";
	
	_g = [getMarkerPos _p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;
	
	_wp = _g addWaypoint [getMarkerPos "mLine4b", 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
	_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED";
};

waitUntil {ADF_line_south && ADF_line_west && ADF_line_north};

// Count spawned units
_cnt_Obj = {side _x == east} count allUnits;

diag_log	"----------------------------------------------------------------------";
diag_log format ["TWO SIERRA: AO OpFor Inf spawned, number of Opfor: %1", _cnt_Obj];
diag_log format ["TWO SIERRA: AO Independent spawned, number of Independent: %1", {side _x == independent} count allUnits];
diag_log format ["TWO SIERRA: AO BluFor spawned, number of BluFor: %1", {(side _x == WEST) && !isPlayer _x} count allUnits];
diag_log	"----------------------------------------------------------------------";

_cnt_Win = floor ((_cnt_Obj / 10) + (random 10));
if (_cnt_Obj < 50) then {_cnt_Win = 10};
if (_cnt_Win < 10) then {_cnt_Win = 10};

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
private ["_g", "_wp"];
createVehicleCrew vMBt_1;
_g = group ((crew vMBt_1) select 0);
{[_x] call ADF_fnc_redressRussian} forEach units _g;
_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FAST"; _wp setWaypointCombatMode "RED";
sleep 10;
createVehicleCrew vMBt_2;
_g = group ((crew vMBt_2) select 0);
{[_x] call ADF_fnc_redressRussian} forEach units _g;
_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FAST"; _wp setWaypointCombatMode "RED";

remoteExec ["ADF_msg_MBT", 0, true];

// Victors
if (ADF_debug) then {sleep 10} else {sleep 180};
[] spawn {
	for "_i" from 1 to 8 do {
		private ["_p", "_d", "_c", "_v"];
		_d = markerDir "mV1";
		_p = getMarkerPos "mV1";		

		_c = createGroup east;
		_v = [_p, _d, "O_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
		{[_x] call ADF_fnc_redressRebel} forEach units _c;
		
		_v = _v select 0;
		_v setVariable ["BIS_enableRandomization", false];
		[_v, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
		
		_wp = _c addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "RED";
		sleep ((random 100) + (random 100));
	};
};
if (ADF_debug || MotsActive) then {sleep 10} else {sleep 180};

// FlyBy's
[] spawn {
	[getMarkerPos "mLapotino", getMarkerPos "mEndFlyBy", random 150, "FULL", "O_Plane_CAS_02_F", east] call BIS_fnc_ambientFlyby; sleep 3;
	[getMarkerPos "mLapotino", getMarkerPos "mEndFlyBy", random 150, "FULL", "O_Plane_CAS_02_F", east] call BIS_fnc_ambientFlyby;
};

//APC's
if (ADF_debug || MotsActive) then {sleep 10} else {sleep 220};
private ["_g", "_wp"];

createVehicleCrew vAPC_1;

_g = group ((crew vAPC_1) select 0);
_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "NORMAl"; _wp setWaypointCombatMode "RED";
sleep 10;

createVehicleCrew vAPC_2;
_g = group ((crew vAPC_2) select 0);
_wp = _g addWaypoint [getMarkerPos "mNola", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "NORMal"; _wp setWaypointCombatMode "RED";


// Count spawned units again and substract vehicle crews & Track Opfor count for win scenario
diag_log	"----------------------------------------------------------------------";
diag_log format ["TWO SIERRA: AO OpFor spawned, total number of Opfor (incl vehicles): %1", {side _x == east} count allUnits];
diag_log format ["TWO SIERRA: AO OpFor spawned, Infantry: %1", _cnt_Obj];
diag_log format ["TWO SIERRA: AO OpFor spawned, OpFor vehicle crews: %1", ({side _x == east} count allUnits) - _cnt_Obj];
diag_log format ["TWO SIERRA: AO Opfor mission success count: %1", _cnt_Win];
diag_log	"----------------------------------------------------------------------";

ADF_init_AO = true; publicVariable "ADF_init_AO";
ADF_sweepMsg = false;

if (!ADF_debug || !MotsActive) then {waitUntil {sleep 60; if (MotsActive) exitWith {}; time > 1800}};

waitUntil {
	sleep 10;	
	_cnt_Obj = ["mNola", east, 500, "MAN"] call ADF_fnc_countRadius;
	diag_log format ["TWO SIERRA: Objective Opfor count: %1 (condition: < %2)", _cnt_Obj, _cnt_Win];
	if (_cnt_Obj < 25 && !ADF_sweepMsg) then {remoteExec ["ADF_msg_sweep", 0, true]; ADF_sweepMsg = true;};
	((_cnt_Obj < _cnt_Win) || (time > 9000));
};

private "_proc";
_proc = "";
if (time > 9000) then {_proc = "time > 9000 (2,5 hours)"} else {_proc = "Opfor ratio"};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: End Mission process started";
diag_log format ["TWO SIERRA: Process: %1", _proc];
diag_log format ["TWO SIERRA: Current AO Opfor count: %1 (condition: < %2)", _cnt_Obj, _cnt_Win];
diag_log	"-----------------------------------------------------";

remoteExec ["ADF_msg_endMission", 0, true];