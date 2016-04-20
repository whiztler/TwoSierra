diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_position.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_distance.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_defendArea.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_footPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_seaPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createIED.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";
call compile preprocessFileLineNumbers "scr\ADF_redress_NRF.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_CSAT3.sqf";

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD, MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA, MRAP_2_1_BRAVO, MRAP_2_2_ALPHA, MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1, MRAP_2_3_WT2];
[oMed] execVM "Core\C\ADF_vCargo_B_TruckMedi.sqf";

private "_a";
_a = ["mVeh_1", "mVeh_2", "mVeh_3", "mVeh_4", "mVeh_5", "mVeh_6", "mVeh_7", "mVeh_8", "mVeh_9", "mVeh_10", "mVeh_11", "mVeh_12", "mVeh_13", "mVeh_14", "mVeh_15", "mVeh_16", "mVeh_17", "mVeh_18", "mVeh_19", "mVeh_20"];

// Random vehicle
for "_i" from 1 to 3 do {
	private ["_p", "_idx", "_va", "_v"];
	_p = _a call BIS_fnc_selectRandom;
	_va = ["O_MRAP_02_hmg_F", "O_MRAP_02_F", "O_MRAP_02_gmg_F"] call BIS_fnc_selectRandom;
	_a = _a - [_p];
	_v = createVehicle [_va, getMarkerPos _p, [], 0, "NONE"];
	_v setDir (markerDir _p);
	_v lock 3;
};

// Spawn static Marid
private ["_mp", "_v"];
_mp = ["mMarid_1", "mMarid_2", "mMarid_3", "mMarid_4", "mMarid_5"] call BIS_fnc_selectRandom;
_v = createVehicle ["O_APC_Wheeled_02_rcws_F", getMarkerPos _mp, [], 0, "NONE"];
_v setDir (markerDir _mp);
_v lock 3;

// AO Defence Squad
for "_i" from 1 to 14 do {
	private ["_g", "_p", "_t"];
	_p = format ["mDef_%1", _i];
	_p = getMarkerPos _p;
	_t = if ((random 1) > .33) then {"OIA_InfAssault"} else {"OIA_InfSquad_Weapons"};
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;
		
	[_g, _p, 125, 2, true] call ADF_fnc_defendArea;
};

// foot patrols
for "_i" from 2 to 12 do {
	private ["_p", "_g", "_r", "_w"];
	_p = getMarkerPos "mOpforSpawn";
	_r = (random 225) + (random 225);
	_w = [3,4,5] call BIS_fnc_selectRandom;

	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OI_reconSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;
	[_g, _p, _r, _w, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5, true] call ADF_fnc_footPatrol;
};

// foot patrols LR
for "_i" from 1 to 5 do {
	private ["_p", "_g", "_r", "_w"];
	_p = getMarkerPos "mOpforSpawn";
	_r = 200 + ((random 300) + (random 300));
	if (_r < 300) then {_r = 250 + (random 300)};
	_w = [3,4,5,6] call BIS_fnc_selectRandom;

	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OI_infTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;
	[_g, _p, _r, _w, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 25] call ADF_fnc_footPatrol;
};

// Counter
waitUntil {
	sleep 60;
	private "_c";
	_c = {side _x == east} count allUnits;
	if (ADF_debug) then {systemChat format ["TWO SIERRA debug: Opfor remaining: %1", _c];} else {diag_log format ["TWO SIERRA: Opfor remaining: %1", _c];};
	_c == 20
};

// Counter spawn
private "_n";
_n = [2, 3, 4, 5] call BIS_fnc_selectRandom;
for "_i" from 1 to _n do {
	private ["_g", "_p", "_t", "_wp"];
	_p = getMarkerPos (["mCtr_1", "mCtr_2", "mCtr_1"]);
	_t = if ((random 1) > .33) then {"OIA_InfAssault"} else {"OIA_InfSquad_Weapons"};
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;
		
	_g allowFleeing 0;
	(leader _g) setSkill ['commanding', 1];
	_wp = _g addWaypoint [getMarkerPos "mOpforSpawn", 0];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointCombatMode "RED";
};

diag_log	"-----------------------------------------------------";
diag_log format ["TWO SIERRA: Counter assault spawned: Nr of squads: %1 -- Opfor counter nr: %2", _n, _n * 8];
diag_log	"-----------------------------------------------------";


private ["_cnt_Win"];
_cnt_Win = 5;

// Count and track alive OpFor
waitUntil {
	sleep 60;
	private "_c";
	_c = {side _x == east} count allUnits;
	if (ADF_debug) then {systemChat format ["TWO SIERRA debug: Opfor remaining: %1", _c];} else {diag_log format ["TWO SIERRA: Opfor remaining: %1", _c];};
	_c <= _cnt_Win
};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: End Mission process started";
diag_log	"-----------------------------------------------------";

remoteExec ["ADF_msg_endMission", -2];