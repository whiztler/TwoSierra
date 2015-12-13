diag_log "ADF RPT: Init - executing Scr\init_ao.sqf"; // Reporting. Do NOT edit/remove

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

// AA sites
private "_g";
_g = CreateGroup EAST; 
_p = _g createUnit ["O_crew_F", getMarkerPos "mPat_1", [], 0, "SERGEANT"]; _p moveInGunner vAA_1;
{[_x] call ADF_fnc_redressCSAT3} forEach units _g;


// CP defence teams
for "_i" from 1 to 8 do {
	private ["_g","_spawnPos","_defArr"];
	_spawnPos = format ["mCP_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;
	
	_defArr = [_g, _spawnPos, 50, 2, true];
	_defArr call ADF_fnc_defendArea;
};

// AO defence squads
for "_i" from 1 to 8 do {
	private ["_g","_spawnPos","_defArr","_sqd"];
	_spawnPos = format ["mDef_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	_sqd = "";
	if ((random 1) < .33) then {_sqd = "OIA_InfSquad"} else {_sqd = "OIA_InfSquad_Weapons"};
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _sqd)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;
	
	_defArr = [_g, _spawnPos, 100, 2, true];
	_defArr call ADF_fnc_defendArea;
};
	
// Foot patrols LR
for "_i" from 1 to 8 do {
	private ["_g","_p","_r","_t","_spawnPos"];
	_p			= format ["mPat_%1",_i];
	_r			= floor ((random 600) + (random 600));
	_t			= ["OI_reconSentry","OIA_InfTeam"] call BIS_fnc_selectRandom;
	_spawnPos	= getMarkerPos _p;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

	[_g, _spawnPos, _r, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

// Foot patrols Base
for "_i" from 1 to 8 do {
	private ["_g","_p","_r","_t","_spawnPos"];
	_p			= format ["mBpat_%1",_i];
	_r			= 150;
	_t			= ["OI_reconSentry","OIA_InfSentry"] call BIS_fnc_selectRandom;
	_spawnPos	= getMarkerPos _p;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

	[_g, _spawnPos, _r, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

// Veh patrols
for "_i" from 1 to 2 do {
	private ["_c","_spawnPos","_d","_v","_vc"];
	_spawnPos = format ["mVp_%1",_i];
	_d = markerDir _spawnPos;
	_spawnPos = getMarkerPos _spawnPos;
	_vc = ["O_MRAP_02_F","O_Quadbike_01_F","O_G_Offroad_01_F"] call BIS_fnc_selectRandom;

	_c = createGroup EAST;
	_v = [_spawnPos, _d, _vc, _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _c;
	
	[_c, _spawnPos, 500, 4, "MOVE", "SAFE", "RED", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
};

/*

// Count spawned Opfor Ortego
private ["_ADF_OpforCnt","_ADF_WestCnt"];

_ADF_OpforCnt = {(side _x == EAST) && (alive _x)} count allUnits;
_ADF_WestCnt = {(side _x == WEST) && (alive _x) && !isPlayer _x} count allUnits;
_opforCntWin = _ADF_OpforCnt / 12;

diag_log	"----------------------------------------------------------------------";
diag_log format ["TWO SIERRA: AO OpFor spawned @ Ortego, number of Opfor: %1 (Win condition: %2)",_ADF_OpforCnt,_opforCntWin];
diag_log format ["TWO SIERRA: AO BluFor spawned, number of BluFor: %1",_ADF_WestCnt];
diag_log	"----------------------------------------------------------------------";

// Track Opfor Ortego count
waitUntil {
	sleep 15;
	private ["_OrtegoRadius"];
	_OrtegoRadius = nearestObjects [getMarkerPos "mPat_11", ["Man"], 500];
	ADF_ortegaCnt = {(side _x == EAST) && (alive _x)} count _OrtegoRadius;
	if (triggerActivated tDolores) then {ADF_ortegaCnt = ADF_ortegaCnt - ADF_doloresCnt;};
	((ADF_ortegaCnt < _opforCntWin) || (time > 7200));
};
	
// Ortego cleared
ADF_ortegaClear = true;
remoteExec ["ADF_msg_ortegaClear", 0, true]; 

// End mission
waitUntil {sleep 5; ADF_ortegaClear && ADF_doloresClear};
ADF_endMission = true; publicVariable "ADF_endMission";