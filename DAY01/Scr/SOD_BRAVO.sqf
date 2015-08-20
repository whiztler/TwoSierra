if (hasInterface) then {
	["ACO","ACO","FIRESTONE: TWO SIERRA, Message. BRAVO grid intel:<br/><br/>1. MOTHER is tracking 20+ ELVIS pax in BRAVO grid.<br/><br/>2. ACE is tracking 2 victors around BRAVO. Several CEASAR victors in the vicinity of BRAVO. Out."] call ADF_fnc_MessageParser;
};

if (!ADF_HC_execute) exitWith {}; // Double check

// Random vehicle patrols
_bravoVehArray = ["mGuerVeh_20","mGuerVeh_21","mGuerVeh_22","mGuerVeh_23","mGuerVeh_24","mGuerVeh_25"];

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Spawning BRAVO AO";
diag_log	"-----------------------------------------------------";

for "_i" from 1 to 2 do {
	private ["_spawnPos","_spawnDir","_v","_mN","_m","_idx","_vX"];
	_spawnPos = _bravoVehArray call BIS_fnc_selectRandom;
	_idx = _bravoVehArray find _spawnPos;
	_bravoVehArray deleteAt _idx;
	_spawnDir = markerDir _spawnPos;

	_c = createGroup INDEPENDENT;
	_v = [getMarkerPos _spawnPos, _spawnDir, "I_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressPashtun} forEach units _c;
	_vX = _v select 0;
	_vX setVariable ["BIS_enableRandomization", false];
	[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
	[_c, getMarkerPos _spawnPos, 1000, 4, "MOVE", "SAFE", "RED", "LIMITED", "", "", [0,0,0]] call CBA_fnc_taskPatrol;
};

_bravoPaxPatrolhArray = ["mGuerPaxPatrol_20","mGuerPaxPatrol_21","mGuerPaxPatrol_22","mGuerPaxPatrol_23","mGuerPaxPatrol_24","mGuerPaxPatrol_25","mGuerPaxPatrol_26"];

// Random foot patrols
for "_i" from 1 to 3 do {
	private ["_spawnPos","_mN","_m","_g","_idx"];
	_spawnPos = _bravoPaxPatrolhArray call BIS_fnc_selectRandom;
	_idx =  _bravoPaxPatrolhArray find _spawnPos;
	_bravoPaxPatrolhArray deleteAt _idx;

	_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	[_g, getMarkerPos _spawnPos, 600, 4, "MOVE", "SAFE", "RED", "LIMITED", "", "", [0,0,0]] call CBA_fnc_taskPatrol;
};

// Defence groups
for "_i" from 10 to 13 do {
	private ["_g","_spawnPos"];
	_spawnPos = format ["mGuerPaxDef_%1",_i];
	_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	[_g, getMarkerPos _spawnPos, 75, 2, true] call CBA_fnc_taskDefend;	
};

// Defence Oil Rigs
for "_i" from 1 to 2 do {
	private ["_g","_spawnPos"];
	_spawnPos = format ["mGuerPaxTwr_%1",_i];
	_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun; _x setPosATL [getMarkerPos _spawnPos select 0, getMarkerPos _spawnPos select 1, 5.8];} forEach units _g;
};
