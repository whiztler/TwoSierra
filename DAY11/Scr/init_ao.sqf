diag_log "ADF RPT: Init - executing Scr\init_ao.sqf"; // Reporting. Do NOT edit/remove

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

// AA sites
private ["_g", "_u"];
_g = createGroup east; 
_u = _g createUnit ["O_crew_F", getMarkerPos "mPat_1", [], 0, "SERGEANT"]; _u moveInGunner vAA_1;
{[_x] call ADF_fnc_redressCSAT3} forEach units _g;


// CP defence teams
private "_i";
for "_i" from 1 to 8 do {
	private ["_g", "_p"];
	_p = format ["mCP_%1", _i];
	_p = getMarkerPos _p;
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

	[_g, _p, 50, 2, true] call ADF_fnc_defendArea;
};

// AO defence squads
for "_i" from 1 to 8 do {
	private ["_g", "_p", "_t"];
	_p = format ["mDef_%1", _i];
	_p = getMarkerPos _p;
	_t = "";
	if ((random 1) < .33) then {_t = "OIA_InfAssault"} else {_t = "OIA_InfSquad_Weapons"};
	
	_g = [_p, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

	[_g, _p, 100, 2, true] call ADF_fnc_defendArea;
};
	
// Foot patrols LR
for "_i" from 1 to 8 do {
	private ["_g", "_p", "_r", "_t", "_p"];
	_p	= format ["mPat_%1", _i];
	_r	= floor ((random 600) + (random 600));
	_t	= ["OI_reconSentry", "OIA_InfTeam"] call BIS_fnc_selectRandom;
	_p	= getMarkerPos _p;
	
	_g = [_p, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

	[_g, _p, _r, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

// Foot patrols Base
for "_i" from 1 to 8 do {
	private ["_g", "_p", "_r", "_t", "_p"];
	_p	= format ["mBpat_%1", _i];
	_r	= 100 + ((random 50) + (random 50));
	_t	= ["OI_reconSentry", "OIA_InfSentry"] call BIS_fnc_selectRandom;
	_p	= getMarkerPos _p;
	
	_g = [_p, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

	[_g, _p, _r, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

// Veh patrols
for "_i" from 1 to 2 do {
	private ["_c", "_p", "_d", "_v", "_vc"];
	_p = format ["mVp_%1", _i];
	_d = markerDir _p;
	_p = getMarkerPos _p;
	_vc = ["O_MRAP_02_F", "O_Quadbike_01_F", "O_G_Offroad_01_F"] call BIS_fnc_selectRandom;

	_c = createGroup east;
	_v = [_p, _d, _vc, _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _c;
	
	[_c, _p, 500, 4, "MOVE", "SAFE", "RED", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
};

ADF_init_AO = true; publicVariable "ADF_init_AO";

// Count spawned Opfor 
private ["_ADF_OpforCnt", "_opforCntWin"];

_ADF_OpforCnt = {side _x == EAST} count allUnits;
_opforCntWin = _ADF_OpforCnt / 12;

diag_log	"----------------------------------------------------------------------";
diag_log format ["TWO SIERRA: AO OpFor spawned: number of Opfor: %1 (Win condition: %2)", _ADF_OpforCnt, _opforCntWin];
diag_log format ["TWO SIERRA: AO BluFor spawned, number of BluFor: %1", {(side _x == WEST) && !isPlayer _x} count allUnits];
diag_log	"----------------------------------------------------------------------";

// Track Opfor  count
waitUntil {
	sleep 15;
	private ["_a", "_o"];
	_a = (getMarkerPos "mBase") nearEntities ["Man", 500];
	_o = {side _x == EAST} count _a;
	((_o < _opforCntWin) || (time > 9000));
};

private "_t";
_t = if (time > 9000) then {true} else {false};

// End mission
ADF_endMission = true; publicVariable "ADF_endMission";
tEndMission enableSimulation true;

[_t] remoteExec ["ADF_msg_endMission", 0, true];

sleep 155;

// Reinforcements
private ["_c", "_wp", "_u"];

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

_u = _c createUnit ["o_Crew_F", getMarkerPos "reEnfor", [], 0, "LIEUTENANT"]; _u moveInCommander vReinf_1; _u setUnitRank "MAJOR";
_u = _c createUnit ["o_Crew_F", getMarkerPos "reEnfor", [], 0, "SERGEANT"]; _u moveInGunner vReinf_1;
_u = _c createUnit ["o_Crew_F", getMarkerPos "reEnfor", [], 0, "CORPORAL"]; _u moveInDriver vReinf_1;
sleep 1;

for "_i" from 2 to 6 do {
	private ["_t", "_v", "_u"];
	_t = format ["vReinf_%1", _i];
	_v = call compile format ["%1", _t];	

	_u = _c createUnit ["o_Crew_F", getMarkerPos "reEnfor", [], 0, "LIEUTENANT"]; _u moveInCommander _v;
	_u = _c createUnit ["o_Crew_F", getMarkerPos "reEnfor", [], 0, "SERGEANT"]; _u moveInGunner _v;
	_u = _c createUnit ["o_Crew_F", getMarkerPos "reEnfor", [], 0, "CORPORAL"]; _u moveInDriver _v;
	sleep 1;
};