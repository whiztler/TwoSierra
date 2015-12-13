diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

///// RUSSIAN AA SITES

// AA Sites crew
_g = createGroup EAST;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "SERGEANT"]; _p moveInGunner vAA_1;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "CORPORAL"]; _p moveInGunner vAA_2;
{[_x] call ADF_fnc_redressRussian} forEach units _g;

vAA_1 addEventHandler ["killed", {[vAA_1] call ADF_fnc_AAdestroyed;}];
vAA_2 addEventHandler ["killed", {[vAA_2] call ADF_fnc_AAdestroyed;}];

ADF_fnc_AAdestroyed = {
	params ["_v"];
	if (!alive vAA_1 && !alive vAA_2) then {ADF_CAS_activate = true; publicVariable "ADF_CAS_activate"; execVM "Scr\ADF_CAS.sqf";};
	if (_v == vAA_1) then {remoteExec ["ADF_msg_AA1",0,true];};
	if (_v == vAA_2) then {remoteExec ["ADF_msg_AA2",0,true];};
};

// Russian defense team at AA sites
for "_i" from 1 to 2 do {
	private ["_g","_spawnPos","_defArr"];
	_spawnPos = format ["mObj_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRussian} forEach units _g;

	_defArr = [_g, _spawnPos, 50, 2, true];
	_defArr call ADF_fnc_defendArea;
};

// Russian Lopatino patrols
for "_i" from 1 to 2 do {
	private ["_g","_spawnPos"];
	_spawnPos = format ["mObj_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRussian} forEach units _g;

	[_g, _spawnPos, 350, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

///// REBEL FORCES

// Mortar crew
private ["_g","_p"];
_g = createGroup EAST;
_p = _g createUnit ["O_Soldier_F", getPos oStat_1, [], 0, "SERGEANT"]; _p moveInGunner oStat_1;
_p = _g createUnit ["O_Soldier_F", getPos oStat_2, [], 0, "CORPORAL"]; _p moveInGunner oStat_2;
{[_x] call ADF_fnc_redressRebel; [_x] call ADF_fnc_setTurretGunner} forEach units _g;

// DIANA Static crews
_g = createGroup EAST;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "SERGEANT"]; _p moveInGunner sDiana_1;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "CORPORAL"]; _p moveInGunner sDiana_2;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sDiana_3;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sDiana_4;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "CORPORAL"]; _p moveInGunner sDiana_5;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sDiana_6;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sDiana_7;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sDiana_8;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sDiana_9;
{[_x] call ADF_fnc_redressRebel} forEach units _g;

// ODIN Static crews
_g = createGroup EAST;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "SERGEANT"]; _p moveInGunner sApt_1;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "CORPORAL"]; _p moveInGunner sApt_2;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sApt_3;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sApt_4;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "CORPORAL"]; _p moveInGunner sApt_5;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sApt_6;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sApt_7;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sApt_8;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sApt_9;
{[_x] call ADF_fnc_redressRebel} forEach units _g;

// Random vehicle patrols
for "_i" from 1 to 5 do {
	private ["_spawnPos","_spawnDir","_c","_v","_vX"];
	_spawnPos = format ["mVeh_%1",_i];
	_spawnDir = markerDir _spawnPos;
	_spawnPos = getMarkerPos _spawnPos;		

	_c = createGroup EAST;
	_v = [_spawnPos, _spawnDir, "O_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressRebel} forEach units _c;
	
	_vX = _v select 0;
	_vX setVariable ["BIS_enableRandomization", false];
	[_vX, "ADF_rebelOffroad", nil] call bis_fnc_initVehicle;
	
	[_c, _spawnPos, 1500, 4, "MOVE", "SAFE", "RED", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
};

// AO Defence teams/Sqauds
for "_i" from 1 to 10 do {
	private ["_g","_spawnPos","_defArr","_t"];
	_spawnPos = format ["mDef_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	_t = ["OIA_InfTeam","OIA_InfSquad"] call BIS_fnc_selectRandom;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;

	_defArr = [_g, _spawnPos, 150, 2, true];
	_defArr call ADF_fnc_defendArea;	
};

// Foot patrols
for "_i" from 1 to 10 do {
	private ["_g","_spawnPos","_t"];
	_spawnPos = format ["mPat_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	_t = ["OIA_InfTeam","OIA_InfSentry"] call BIS_fnc_selectRandom;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;

	[_g, _spawnPos, 400, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

// Foot patrols short
for "_i" from 1 to 6 do {
	private ["_g","_spawnPos","_t"];
	_spawnPos = format ["mShort_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	_t = ["OIA_InfTeam","OIA_InfSentry"] call BIS_fnc_selectRandom;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;

	[_g, _spawnPos, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5, true] call ADF_fnc_footPatrol;
};

// Count spawned units
_ADF_OpforCnt = {(side _x == EAST) && (alive _x)} count allUnits;
_ADF_IndepCnt = {(side _x == INDEPENDENT) && (alive _x)} count allUnits;
_ADF_WestCnt = {(side _x == WEST) && (alive _x) && !isPlayer _x} count allUnits;

diag_log	"----------------------------------------------------------------------";
diag_log format ["TWO SIERRA: AO OpFor spawned, number of Opfor: %1",_ADF_OpforCnt];
diag_log format ["TWO SIERRA: AO Independent spawned, number of Independent: %1",_ADF_IndepCnt];
diag_log format ["TWO SIERRA: AO BluFor spawned, number of BluFor: %1",_ADF_WestCnt];
diag_log	"----------------------------------------------------------------------";

sleep 10;
ADF_init_AO = true; publicVariable "ADF_init_AO";