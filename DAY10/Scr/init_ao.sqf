diag_log "ADF RPT: Init - executing Scr\init_ao.sqf"; // Reporting. Do NOT edit/remove

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

// AA sites
private "_g";
_g = CreateGroup EAST; 
_p = _g createUnit ["O_crew_F", getMarkerPos "mPat_1", [], 0, "SERGEANT"]; _p moveInGunner vAA_1;
_p = _g createUnit ["O_crew_F", getMarkerPos "mPat_1", [], 0, "SERGEANT"]; _p moveInGunner vAA_2;
if (alive vAA_3) then {_p = _g createUnit ["O_crew_F", getMarkerPos "mPat_1", [], 0, "SERGEANT"]; _p moveInGunner vAA_3};
{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

ADF_ortegaCnt = 0;
ADF_doloresCnt = 0;

// OP
private ["_g","_spawnPos","_defArr","_sqd"];
_spawnPos = getPos oSpawn_2;

_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

_defArr = [_g, _spawnPos, 30, 2, true];
_defArr call ADF_fnc_defendArea;

// AO Defence Squad Ortego
for "_i" from 1 to 10 do {
	private ["_g","_spawnPos","_defArr","_sqd"];
	_spawnPos = format ["mDef_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	_sqd = "";
	if ((random 1) < .33) then {_sqd = "OIA_InfSquad"} else {_sqd = "OIA_InfSquad_Weapons"};
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _sqd)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;
	
	_defArr = [_g, _spawnPos, 150, 2, true];
	_defArr call ADF_fnc_defendArea;
	//_g setVariable ["ADF_HC_garrison_ADF",true];
	//_g setVariable ["ADF_HC_garrisonArr",_defArr];
};
	
// Foot patrols Ortego
for "_i" from 1 to 10 do {
	private ["_g","_p","_r","_t","_spawnPos"];
	_p			= format ["mPat_%1",_i];
	_r			= floor ((random 400) + (random 400));
	_t			= ["OI_reconSentry","OIA_InfTeam"] call BIS_fnc_selectRandom;
	_spawnPos	= getMarkerPos _p;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

	[_g, _spawnPos, _r, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

ADF_AO_dolores = {
	// AO Defence Squad Dolores
	for "_i" from 20 to 28 do {
		private ["_g","_spawnPos","_defArr","_sqd"];
		_spawnPos = format ["mDef_%1",_i];
		_spawnPos = getMarkerPos _spawnPos;
		_sqd = "";
		if ((random 1) < .33) then {_sqd = "OIA_InfSquad"} else {_sqd = "OIA_InfSquad_Weapons"};
		
		_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _sqd)] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressCSAT3} forEach units _g;
		
		_defArr = [_g, _spawnPos, 150, 2, true];
		_defArr call ADF_fnc_defendArea;
		//_g setVariable ["ADF_HC_garrison_ADF",true];
		//_g setVariable ["ADF_HC_garrisonArr",_defArr];
	};
	
	// CP
	private ["_g","_spawnPos","_defArr","_sqd"];
	_spawnPos = getPos oSpawn_1;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;
	
	_defArr = [_g, _spawnPos, 30, 2, true];
	_defArr call ADF_fnc_defendArea;
	
		
	// Foot patrols ortego
	for "_i" from 20 to 30 do {
		private ["_g","_p","_r","_t","_spawnPos"];
		_p			= format ["mPat_%1",_i];
		_r			= floor ((random 400) + (random 400));
		_t			= ["OI_reconSentry","OIA_InfTeam"] call BIS_fnc_selectRandom;
		_spawnPos	= getMarkerPos _p;
		
		_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

		[_g, _spawnPos, _r, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
	};
	
	// Count spawned Opfor Dolores
	private ["_ADF_OpforCnt","_DoloresRadius","_opforCntWin"];
	_DoloresRadius = nearestObjects [getPos tDolores, ["Man"], 500];
	_ADF_OpforCnt = {(side _x == EAST) && (alive _x)} count _DoloresRadius;
	_opforCntWin = _ADF_OpforCnt / 12;

	diag_log	"-----------------------------------------------------";
	diag_log format ["TWO SIERRA: AO OpFor spawned @ Dolores, number of Opfor: %1 (Win condition: %2)",_ADF_OpforCnt,_opforCntWin];
	diag_log	"-----------------------------------------------------";

	waitUntil {
		private ["_ADF_OpforCnt","_DoloresRadius"];
		sleep 30;
		_DoloresRadius = nearestObjects [getPos tDolores, ["Man"], 500];
		ADF_doloresCnt = {(side _x == EAST) && (alive _x)} count _DoloresRadius;
		((ADF_doloresCnt < _opforCntWin) || (time > 14400)); // 4 hours
	};
	
	ADF_doloresClear = true;
	remoteExec ["ADF_msg_doloresClear", 0, true]; 
};

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