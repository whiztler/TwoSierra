diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

///// RUSSIAN AA SITES

// AA Sites crew
private ["_g", "_u"];
_g = createGroup east;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "SERGEANT"]; _u moveInGunner vAA_1;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "CORPORAL"]; _u moveInGunner vAA_2;
{[_x] call ADF_fnc_redressRussian} forEach units _g;

vAA_1 addEventHandler ["killed", {[vAA_1] call ADF_fnc_AAdestroyed;}];
vAA_2 addEventHandler ["killed", {[vAA_2] call ADF_fnc_AAdestroyed;}];

ADF_fnc_AAdestroyed = {
	params ["_v"];
	if (!alive vAA_1 && !alive vAA_2) then {ADF_CAS_activate = true; publicVariable "ADF_CAS_activate"; execVM "Scr\ADF_CAS.sqf";};
	if (_v == vAA_1) then {remoteExec ["ADF_msg_AA1", 0, true];};
	if (_v == vAA_2) then {remoteExec ["ADF_msg_AA2", 0, true];};
};

// Russian defense team at AA sites
private "_i";
for "_i" from 1 to 2 do {
	private ["_g", "_p"];
	_p = format ["mObj_%1", _i];
	_p = getMarkerPos _p;
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRussian} forEach units _g;

	[_g, _p, 50, 2, true] call ADF_fnc_defendArea;
};

// Russian Lopatino patrols
for "_i" from 1 to 2 do {
	private ["_g", "_p"];
	_p = format ["mObj_%1", _i];
	_p = getMarkerPos _p;
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRussian} forEach units _g;

	[_g, _p, 350, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

///// REBEL FORCES

// Mortar crew
private ["_g", "_u"];
_g = createGroup east;
_u = _g createUnit ["O_Soldier_F", getPos oStat_1, [], 0, "SERGEANT"]; _u moveInGunner oStat_1;
_u = _g createUnit ["O_Soldier_F", getPos oStat_2, [], 0, "CORPORAL"]; _u moveInGunner oStat_2;
{[_x] call ADF_fnc_redressRebel; [_x] call ADF_fnc_setTurretGunner} forEach units _g;

// DIANA Static crews
_g = createGroup east;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "SERGEANT"]; _u moveInGunner sDiana_1;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "CORPORAL"]; _u moveInGunner sDiana_2;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _u moveInGunner sDiana_3;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _u moveInGunner sDiana_4;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "CORPORAL"]; _u moveInGunner sDiana_5;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _u moveInGunner sDiana_6;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _u moveInGunner sDiana_7;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _u moveInGunner sDiana_8;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _u moveInGunner sDiana_9;
{[_x] call ADF_fnc_redressRebel} forEach units _g;

// ODIN Static crews
_g = createGroup east;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "SERGEANT"]; _u moveInGunner sApt_1;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "CORPORAL"]; _u moveInGunner sApt_2;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _u moveInGunner sApt_3;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _u moveInGunner sApt_4;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "CORPORAL"]; _u moveInGunner sApt_5;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _u moveInGunner sApt_6;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _u moveInGunner sApt_7;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _u moveInGunner sApt_8;
_u = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _u moveInGunner sApt_9;
{[_x] call ADF_fnc_redressRebel} forEach units _g;

// Random vehicle patrols
for "_i" from 1 to 5 do {
	private ["_p", "_d", "_c", "_v"];
	_p = format ["mVeh_%1", _i];
	_d = markerDir _p;
	_p = getMarkerPos _p;		

	_c = createGroup east;
	_v = [_p, _d, "O_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressRebel} forEach units _c;
	
	_v = _v select 0;
	_v setVariable ["BIS_enableRandomization", false];
	[_v, "ADF_rebelOffroad", nil] call bis_fnc_initVehicle;
	
	[_c, _p, 1500, 4, "MOVE", "SAFE", "RED", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
};

// AO Defence teams/Squads
for "_i" from 1 to 10 do {
	private ["_g", "_p", "_t"];
	_p = format ["mDef_%1", _i];
	_p = getMarkerPos _p;
	_t = ["OIA_InfTeam", "OIA_InfSquad"] call BIS_fnc_selectRandom;
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;

	[_g, _p, 150, 2, true] call ADF_fnc_defendArea;	
};

// Foot patrols
for "_i" from 1 to 10 do {
	private ["_g", "_p", "_t"];
	_p = format ["mPat_%1", _i];
	_p = getMarkerPos _p;
	_t = ["OIA_InfTeam", "OIA_InfSentry"] call BIS_fnc_selectRandom;
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;

	[_g, _p, 400, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

// Foot patrols short
for "_i" from 1 to 6 do {
	private ["_g", "_p", "_t"];
	_p = format ["mShort_%1", _i];
	_p = getMarkerPos _p;
	_t = ["OIA_InfTeam", "OIA_InfSentry"] call BIS_fnc_selectRandom;
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;

	[_g, _p, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5, true] call ADF_fnc_footPatrol;
};

// Count spawned units
diag_log	"----------------------------------------------------------------------";
diag_log format ["TWO SIERRA: AO OpFor spawned, number of Opfor: %1", {side _x == east)} count allUnits];
diag_log format ["TWO SIERRA: AO independent spawned, number of independent: %1", {side _x == independent} count allUnits];
diag_log format ["TWO SIERRA: AO BluFor spawned, number of BluFor: %1", {(side _x == west) && (!isPlayer _x)} count allUnits];
diag_log	"----------------------------------------------------------------------";

sleep 10;
ADF_init_AO = true; publicVariable "ADF_init_AO";