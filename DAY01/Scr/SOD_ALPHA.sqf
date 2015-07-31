private ["_diagTestStart","_diagTestEnd"];
_diagTestStart = diag_tickTime;
if (isServer && !hasInterface && ADF_debug) then {diag_log "########## START - Scr\SOD_ALPHA.sqf ##########";};

if (hasInterface) then {
	hintSilent parseText"<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: TWO SIERRA, message: new and additional intel re ALPHA grid:</t><br/><br/><t color='#6C7169' align='left'>1. MOTHER has confirmed 30+ ELVIS pax in and around ALPHA.</t><br/><br/><t color='#6C7169' align='left'>2. MOTHER is tracking 3 ELVIS victors around ALPHA. Out.</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: TWO SIERRA, message: new and additional intel re ALPHA grid:<br/><br/>1. MOTHER confirmed 30+ ELVIS pax in and around ALPHA.<br/><br/>2. MOTHER is tracking 3 ELVIS victors around ALPHA. Out</font><br/><br/>"]];
};

if (!ADF_HC_execute) exitWith {}; // Double check

_ADF_perfDiagStart = diag_tickTime;

// Create random mortar positions
_mortarPosArray = ["mGuerMortar_1","mGuerMortar_2","mGuerMortar_3","mGuerMortar_4","mGuerMortar_5","mGuerMortar_6","mGuerMortar_7","mGuerMortar_8","mGuerMortar_9","mGuerMortar_10"];
_g = [getPos tAlpha, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
_gX = units _g; {[_x] call ADF_fnc_redress} forEach _gX;

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
_alphaVehArray = ["mGuerVeh_1","mGuerVeh_2","mGuerVeh_3","mGuerVeh_4","mGuerVeh_5"];

for "_i" from 1 to 2 do {
	private ["_spawnPos","_spawnDir","_v","_mN","_m","_idx","_cX","_vX"];
	_spawnPos = _alphaVehArray call BIS_fnc_selectRandom;
	_idx =  _alphaVehArray find _spawnPos;
	_alphaVehArray deleteAt _idx;
	_spawnDir = markerDir _spawnPos;

	_c = createGroup INDEPENDENT;
	_v = [getMarkerPos _spawnPos, _spawnDir, "I_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
	_cX = units _c; {[_x] call ADF_fnc_redress} forEach _cX;
	_vX = _v select 0;
	[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
	[_c, getMarkerPos _spawnPos, 1200, 4, "MOVE", "SAFE", "RED", "LIMITED", "", "", [0,0,0]] call CBA_fnc_taskPatrol;
};

_alphaPaxPatrolhArray = ["mGuerPaxPatrol_1","mGuerPaxPatrol_2","mGuerPaxPatrol_3","mGuerPaxPatrol_4","mGuerPaxPatrol_5","mGuerPaxPatrol_6","mGuerPaxPatrol_7","mGuerPaxPatrol_8","mGuerPaxPatrol_9","mGuerPaxPatrol_10"];

// Random foot patrols
for "_i" from 0 to 3 do {
	private ["_spawnPos","_mN","_m","_g","_gX","_idx"];
	_spawnPos = _alphaPaxPatrolhArray call BIS_fnc_selectRandom;
	_idx =  _alphaPaxPatrolhArray find _spawnPos;
	_alphaPaxPatrolhArray deleteAt _idx;

	_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	_gX = units _g; {[_x] call ADF_fnc_redress} forEach _gX;
	[_g, getMarkerPos _spawnPos, 600, 4, "MOVE", "SAFE", "RED", "LIMITED", "", "", [0,0,0]] call CBA_fnc_taskPatrol;
};

// Bearclaw foot patrols
for "_i" from 1 to 3 do {
	private ["_g","_gX"];
	_g = [getPos objBearclaw, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	_gX = units _g; {[_x] call ADF_fnc_redress} forEach _gX;
	[_g, getPos objBearclaw, 80, 4, "MOVE", "SAFE", "RED", "LIMITED", "", "", [0,0,0]] call CBA_fnc_taskPatrol;
};

// Defence groups
for "_i" from 1 to 8 do {
	private ["_g","_gX","_spawnPos"];
	_spawnPos = format ["mGuerPaxDef_%1",_i];
	_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
	_gX = units _g; {[_x] call ADF_fnc_redress} forEach _gX;
	[_g, getMarkerPos _spawnPos, 50, 2, true] call CBA_fnc_taskDefend;	
};

// Bearclaw Defence Team
_g = [getPos objBearclaw, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
_gX = units _g; {[_x] call ADF_fnc_redress} forEach _gX;
[_g, getPos objBearclaw, 10, 2, true] call CBA_fnc_taskDefend;	


_ADF_perfDiagStop = diag_tickTime;
if (ADF_debug) then {
	_debugDiag = format [" (DIAG: %1)",_ADF_perfDiagStop - _ADF_perfDiagStart];
	_debugText = "ALPHA SOD";
	_debugMsg = _debugText + _debugDiag;
	[_debugMsg,false] call ADF_fnc_log;
};
