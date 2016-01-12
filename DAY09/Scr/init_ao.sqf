diag_log "ADF RPT: Init - executing Scr\init_ao.sqf"; // Reporting. Do NOT edit/remove

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

// AA sites
private "_g";
_g = createGroup east; 
_p = _g createUnit ["O_crew_F", getMarkerPos "mPat_1", [], 0, "SERGEANT"]; _p moveInGunner vAA_1;
_p = _g createUnit ["O_crew_F", getMarkerPos "mPat_1", [], 0, "SERGEANT"]; _p moveInGunner vAA_2;
{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

// Sea patrol
for "_i" from 1 to 2 do {
	private ["_spawnPos","_spawnDir","_c","_v","_vX"];
	_spawnPos = format ["mSea_%1",_i];
	_spawnDir = markerDir _spawnPos;
	_spawnPos = getMarkerPos _spawnPos;		

	_c = createGroup east;
	_v = [_spawnPos, _spawnDir, "O_Boat_Armed_01_hmg_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _c;

	[_c, _spawnPos, 500, 4, "MOVE", "SAFE", "RED", "NORMAL", "FILE", 5] call ADF_fnc_seaPatrol;	
};


// AO Defence Squad
for "_i" from 1 to 14 do {
	private ["_g","_spawnPos","_sqd"];
	_spawnPos = format ["mDef_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	_sqd = "";
	if ((random 1) > .33) then {_sqd = "OIA_InfAssault"} else {_sqd = "OIA_InfSquad_Weapons"};
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _sqd)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

	[_g, _spawnPos, 100, 2, true] call ADF_fnc_defendArea;
};

// Foot patrols
for "_i" from 1 to 10 do {
	private ["_g","_p","_r","_spawnPos"];
	_p			= ["mPat_1","mPat_2","mPat_3"] call BIS_fnc_selectRandom;
	_r			= floor ((random 300) + (random 300));
	_spawnPos	= getMarkerPos _p;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OI_reconSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

	[_g, _spawnPos, _r, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

private "_ADF_OpforCntCity";
_ADF_OpforCntCity = {side _x == EAST} count allUnits;

// Calvin Defence Squad
private ["_g","_spawnPos","_sqd"];
_spawnPos	= getMarkerPos "mDefCalvin";
_sqd			= "";
if ((random 1) < .45) then {_sqd = "OIA_InfAssault"} else {_sqd = "OIA_InfSquad_Weapons"};

_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _sqd)] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

[_g, _spawnPos, 100, 2, true] call ADF_fnc_defendArea;


// Calvin Foot patrols
for "_i" from 1 to 3 do {
	private ["_g","_spawnPos"];
	_spawnPos	= getMarkerPos "mPatCalvin";
	_r			= (random 150) + (random 150);
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OI_reconSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

	[_g, _spawnPos, _r, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

ADF_init_AO = true; publicVariable "ADF_init_AO";
#include "init_obj.sqf"
