if (hasInterface) then {
	["2S","TWO SIERRA","FIRESTONE we are approaching ALPHA. How copy?"] call ADF_fnc_MessageParser; sleep 15;
	["ACO","ACO","FIRESTONE: Copy TWO SIERRA. New and additional intel re ALPHA grid:<br/><br/>1. MOTHER has confirmed 30+ ELVIS pax in and around ALPHA.<br/><br/>2. MOTHER is tracking 3 ELVIS victors around ALPHA. Out."] call ADF_fnc_MessageParser;
};

if (!isServer) exitWith {};

_ADF_perfDiagStart = diag_tickTime;

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Spawning ALPHA AO";
diag_log	"-----------------------------------------------------";

// Create random mortar positions
private ["_mortarPosArray","_g","_gX"];
_mortarPosArray = ["mGuerMortar_1","mGuerMortar_2","mGuerMortar_3","mGuerMortar_4","mGuerMortar_5","mGuerMortar_6","mGuerMortar_7","mGuerMortar_8","mGuerMortar_9","mGuerMortar_10"];
_g = [getPos tAlpha, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
_gX = units _g; {[_x] call ADF_fnc_redressPashtun} forEach _gX;

for "_i" from 0 to 2 do {
	private ["_mortarPos","_v","_mN","_m","_idx"];
	_MortarPos = _mortarPosArray call BIS_fnc_selectRandom;
	_idx =  _mortarPosArray find _MortarPos;
	_mortarPosArray deleteAt _idx;

	_v = createVehicle ["I_Mortar_01_F", getMarkerPos _mortarPos, [], 0, "CAN_COLLIDE"];
	_v setDir (markerDir _mortarPos);
	_gX select _i moveInGunner _v;
};

// Random vehicle patrols
private ["_alphaVehArray"];
_alphaVehArray = ["mGuerVeh_1","mGuerVeh_2","mGuerVeh_3","mGuerVeh_4","mGuerVeh_5"];

for "_i" from 1 to 2 do {
	private ["_spawnPos","_spawnDir","_c","_v","_vX","_idx"];
	_spawnPos	= _alphaVehArray call BIS_fnc_selectRandom;
	_idx 		= _alphaVehArray find _spawnPos;
	_spawnDir	= markerDir _spawnPos;
	_spawnPos	= getMarkerPos _spawnPos;
	_alphaVehArray deleteAt _idx;	

	_c = createGroup EAST;
	_v = [_spawnPos, _spawnDir, "I_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressPashtun} forEach units _c;
	_vX = _v select 0;
	_vX setVariable ["BIS_enableRandomization", false];
	[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
	[_c, _spawnPos, 1200, 4, "MOVE", "SAFE", "RED", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
};

private ["_alphaPaxPatrolhArray"];
_alphaPaxPatrolhArray = ["mGuerPaxPatrol_1","mGuerPaxPatrol_2","mGuerPaxPatrol_3","mGuerPaxPatrol_4","mGuerPaxPatrol_5","mGuerPaxPatrol_6","mGuerPaxPatrol_7","mGuerPaxPatrol_8","mGuerPaxPatrol_9","mGuerPaxPatrol_10"];

// Random foot patrols
for "_i" from 0 to 3 do {
	private ["_spawnPos","_mN","_m","_g","_idx"];
	_spawnPos	= _alphaPaxPatrolhArray call BIS_fnc_selectRandom;
	_idx 		= _alphaPaxPatrolhArray find _spawnPos;
	_spawnPos	= getMarkerPos _spawnPos;
	_alphaPaxPatrolhArray deleteAt _idx;

	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	[_g, _spawnPos, 600, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

// Bearclaw foot patrols
for "_i" from 1 to 3 do {
	private ["_g"];
	_g = [getPos objBearclaw, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	[_g, getPos objBearclaw, 80, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

// Defence groups
for "_i" from 1 to 8 do {
	private ["_g","_spawnPos","_defArr"];
	_spawnPos 	= format ["mGuerPaxDef_%1",_i];
	_spawnPos	= getMarkerPos _spawnPos;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	_defArr = [_g, _spawnPos, 100, 2, true];
	_defArr call ADF_fnc_defendArea;
};

// Bearclaw Defence Team
_g = [getPos objBearclaw, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressPashtun} forEach units _g;
_defArr = [_g, getPos objBearclaw, 10, 2, true];
_defArr call ADF_fnc_defendArea;
