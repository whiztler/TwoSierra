diag_log "ADF RPT: Init - executing Scr\init_ao.sqf"; // Reporting. Do NOT edit/remove

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

// AA sites
private "_g";
_g = createGroup east; 
_p = _g createUnit ["O_crew_F", getMarkerPos "mPat_1", [], 0, "SERGEANT"]; _p moveInGunner vAA_1;
{[_x] call ADF_fnc_redressCSAT3} forEach units _g;


// CP defence teams
for "_i" from 1 to 8 do {
	private ["_g","_spawnPos","_defArr"];
	_spawnPos = format ["mCP_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	
	_g = [_spawnPos, east, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
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
	if ((random 1) < .33) then {_sqd = "OIA_InfAssault"} else {_sqd = "OIA_InfSquad_Weapons"};
	
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
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
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

	_c = createGroup east;
	_v = [_spawnPos, _d, _vc, _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _c;
	
	[_c, _spawnPos, 500, 4, "MOVE", "SAFE", "RED", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
};

ADF_init_AO = true; publicVariable "ADF_init_AO";

// Count spawned Opfor Ortego
private ["_ADF_OpforCnt","_ADF_WestCnt"];

_ADF_OpforCnt = {side _x == EAST} count allUnits;
_ADF_WestCnt = {(side _x == WEST) && !isPlayer _x} count allUnits;
_opforCntWin = _ADF_OpforCnt / 12;

diag_log	"----------------------------------------------------------------------";
diag_log format ["TWO SIERRA: AO OpFor spawned @ Ortego, number of Opfor: %1 (Win condition: %2)",_ADF_OpforCnt,_opforCntWin];
diag_log format ["TWO SIERRA: AO BluFor spawned, number of BluFor: %1",_ADF_WestCnt];
diag_log	"----------------------------------------------------------------------";

// Track Opfor Ortego count
waitUntil {
	sleep 15;
	private ["_a", "_o"];
	_a = nearestObjects [getMarkerPos "mPat_11", ["Man"], 500];
	_o = {side _x == EAST} count _a;
	((_o < _opforCntWin) || (time > 7200));
};

private "_t";
_t = if (time > 7200) then {true} else {false};

// End mission
ADF_endMission = true; publicVariable "ADF_endMission";
tEndMission enableSimulation true;

[_t] remoteExec ["ADF_msg_endMission", 0, true];

sleep 155;

// Reinforcements
private ["_c", "_wp"];

{
	_x enableSimulationGlobal true;
	_x hideObject false;
} forEach [vReinf_1, vReinf_2, vReinf_3, vReinf_4, vReinf_5, vReinf_6];

_c = createGroup east;
_c allowFleeing 0;

(leader _c) setSkill ['commanding', 1];
_wp = _c addWaypoint [getMarkerPos "mBase", 0];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "FULL";
_wp setWaypointCombatMode "RED";
_wp setWaypointFormation "VEE";

_p = _c createUnit ["o_Crew_F", getMarkerPos "reEnfor", [], 0, "LIEUTENANT"]; _p moveInCommander vReinf_1; _p setUnitRank "MAJOR";
_p = _c createUnit ["o_Crew_F", getMarkerPos "reEnfor", [], 0, "SERGEANT"]; _p moveInGunner vReinf_1;
_p = _c createUnit ["o_Crew_F", getMarkerPos "reEnfor", [], 0, "CORPORAL"]; _p moveInDriver vReinf_1;
sleep 1;

for "_i" from 2 to 6 do {
	_t = format ["vReinf_%1",_i];
	_v = call compile format ["%1",_t];	

	_p = _c createUnit ["o_Crew_F", getMarkerPos "reEnfor", [], 0, "LIEUTENANT"]; _p moveInCommander _v;
	_p = _c createUnit ["o_Crew_F", getMarkerPos "reEnfor", [], 0, "SERGEANT"]; _p moveInGunner _v;
	_p = _c createUnit ["o_Crew_F", getMarkerPos "reEnfor", [], 0, "CORPORAL"]; _p moveInDriver _v;
	sleep 1;
};

