diag_log "ADF RPT: Init - executing Scr\init_ao.sqf"; // Reporting. Do NOT edit/remove

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

// AA sites
private ["_g", "_u"];
_g = createGroup east; 
_u = _g createUnit ["O_crew_F", getMarkerPos "mPat_1", [], 0, "SERGEANT"]; _u moveInGunner vAA_1;
_u = _g createUnit ["O_crew_F", getMarkerPos "mPat_1", [], 0, "SERGEANT"]; _u moveInGunner vAA_2;
if (alive vAA_3) then {_u = _g createUnit ["O_crew_F", getMarkerPos "mPat_1", [], 0, "SERGEANT"]; _u moveInGunner vAA_3};
{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

ADF_ortegaCnt = 0;
ADF_doloresCnt = 0;

// OP
private ["_g", "_p", "_t"];
_p = getPos oSpawn_2;

_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

[_g, _p, 30, 2, true] call ADF_fnc_defendArea;

// Mortar OP
private ["_g", "_u"];
_g = createGroup east; 
_u = _g createUnit ["O_soldier_F", getMarkerPos "mPat_1", [], 0, "SERGEANT"]; _u moveInGunner oStat_50;
_u = _g createUnit ["O_soldier_F", getMarkerPos "mPat_1", [], 0, "SERGEANT"]; _u moveInGunner oStat_51;
_u = _g createUnit ["O_soldier_F", getMarkerPos "mPat_1", [], 0, "SERGEANT"]; _u moveInGunner oStat_52;
_u = _g createUnit ["O_soldier_F", getMarkerPos "mPat_1", [], 0, "SERGEANT"]; _u moveInGunner oStat_53;
{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

// UAV patrol
private ["_c", "_v"];
_c = createGroup east; 
_c setCombatMode "GREEN";
_v = [getMarkerPos "mUAV", 0, "O_UAV_02_CAS_F", _c] call BIS_fnc_spawnVehicle;
vUAV = _v select 0;
[_c, getMarkerPos "mUAV", 1500, 650, 8, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 100] call ADF_fnc_airPatrol;
vUAV removeMagazineTurret ["2Rnd_GBU12_LGB",[0]];

// AO Defence Squad Ortego
private "_i";
for "_i" from 1 to 10 do {
	private ["_g", "_p", "_t"];
	_p = format ["mDef_%1",_i];
	_p = getMarkerPos _p;
	_t = "";
	if ((random 1) > .33) then {_t = "OIA_InfAssault"} else {_t = "OIA_InfSquad_Weapons"};
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;
	
	[_g, _p, 150, 2, true] call ADF_fnc_defendArea;
};
	
// Foot patrols Ortego
for "_i" from 1 to 10 do {
	private ["_g", "_p", "_r", "_t", "_p"];
	_p	= format ["mPat_%1",_i];
	_r	= floor ((random 400) + (random 400));
	_t	= ["OI_reconSentry", "OIA_InfTeam"] call BIS_fnc_selectRandom;
	_p	= getMarkerPos _p;
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

	[_g, _p, _r, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

ADF_fnc_DeleteVehicles = {
	params ["_a"];
	
	{
		{deleteVehicle _x} forEach crew (vehicle _x) + [(vehicle _x)];
	} forEach _a;
	true
};

ADF_fnc_createConvoy = {
	private ["_c", "_v", "_wp"];

	_c = createGroup east;
	_v = [getMarkerPos "mConvoy_Spawn", markerDir "mConvoy_Spawn", "O_Truck_03_covered_F", _c] call BIS_fnc_spawnVehicle; trptConvoy_1 = _v select 0; 
	_v = [(trptConvoy_1 modelToWorld [0,-15,0]), getDir trptConvoy_1, "O_Truck_03_covered_F", _c] call BIS_fnc_spawnVehicle; trptConvoy_2 = _v select 0;
	_v = [(trptConvoy_2 modelToWorld [0,-15,0]), getDir trptConvoy_1, "O_Truck_03_covered_F", _c] call BIS_fnc_spawnVehicle; trptConvoy_3 = _v select 0;
	_v = [(trptConvoy_3 modelToWorld [0,-15,0]), getDir trptConvoy_1, "O_Truck_03_covered_F", _c] call BIS_fnc_spawnVehicle; trptConvoy_4 = _v select 0;
	_c setCombatMode "GREEN";
	_c allowFleeing 0;
	_wp = _c addWaypoint [getMarkerPos "mConvoy_2",0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCompletionRadius 20;
	_wp = _c addWaypoint [getMarkerPos "mConvoy_End",1]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL";
	_wp setWaypointStatements ["true", "[[trptConvoy_1,trptConvoy_2,trptConvoy_3,trptConvoy_4]] call ADF_fnc_DeleteVehicles"];

	while {!(isNil "trptConvoy_1")} do {
		trptConvoy_1 limitSpeed 30;		
		trptConvoy_2 limitSpeed (speed trptConvoy_1);
		trptConvoy_3 limitSpeed (speed trptConvoy_1);
		trptConvoy_4 limitSpeed (speed trptConvoy_1);	
		sleep .5;
	};
};

ADF_AO_dolores = {
	[getMarkerPos "mBase_3", getMarkerPos "mDef_7", east, 2, 1250, 100, 3, "SAD", "SAFE", "RED", "FULL", "FILE", 250] call ADF_fnc_createAirPatrol;

	[] spawn ADF_fnc_createConvoy;
	
	private "_i";
	// AO Defence Squad Dolores
	for "_i" from 20 to 28 do {
		private ["_g", "_p", "_t"];
		_p	= format ["mDef_%1",_i];
		_p	= getMarkerPos _p;
		_t	= "";
		if ((random 1) < .33) then {_t = "OIA_InfAssault"} else {_t = "OIA_InfSquad_Weapons"};
		
		_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressCSAT3} forEach units _g;
		
		[_g, _p, 150, 2, true] call ADF_fnc_defendArea;
	};
	
	// CP
	private ["_g", "_p"];
	_p = getPos oSpawn_1;
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;
	
	[_g, _p, 30, 2, true] call ADF_fnc_defendArea;	
		
	// Foot patrols ortego
	for "_i" from 20 to 30 do {
		private ["_g", "_p", "_r", "_t", "_p"];
		_p	= format ["mPat_%1",_i];
		_r	= floor ((random 400) + (random 400));
		_t	= ["OI_reconSentry", "OIA_InfTeam"] call BIS_fnc_selectRandom;
		_p	= getMarkerPos _p;
		
		_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

		[_g, _p, _r, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
	};
	
	// Count spawned Opfor Dolores
	private ["_ADF_OpforCnt", "_q", "_opforCntWin"];
	_q = nearestObjects [getPos tDolores, ["Man"], 500];
	_ADF_OpforCnt = {side _x == east} count _q;
	_opforCntWin = _ADF_OpforCnt / 12;

	diag_log	"-----------------------------------------------------";
	diag_log format ["TWO SIERRA: AO OpFor spawned @ Dolores, number of Opfor: %1 (Win condition: %2)",_ADF_OpforCnt,_opforCntWin];
	diag_log	"-----------------------------------------------------";

	waitUntil {
		private ["_ADF_OpforCnt", "_q"];
		sleep 30;
		_q = nearestObjects [getPos tDolores, ["Man"], 500];
		ADF_doloresCnt = {side _x == east} count _q;
		((ADF_doloresCnt < _opforCntWin) || (time > 14400)); // 4 hours
	};
	
	ADF_doloresClear = true;
	remoteExec ["ADF_msg_doloresClear", 0, true]; 
};

ADF_init_AO = true; publicVariable "ADF_init_AO";

// Count spawned Opfor Ortego
private ["_ADF_OpforCnt", "_ADF_westCnt"];

_ADF_OpforCnt = {side _x == east} count allUnits;
_ADF_westCnt = {(side _x == west) && !isPlayer _x} count allUnits;
_opforCntWin = _ADF_OpforCnt / 12;

diag_log	"----------------------------------------------------------------------";
diag_log format ["TWO SIERRA: AO OpFor spawned @ Ortego, number of Opfor: %1 (Win condition: %2)",_ADF_OpforCnt,_opforCntWin];
diag_log format ["TWO SIERRA: AO BluFor spawned, number of BluFor: %1",_ADF_westCnt];
diag_log	"----------------------------------------------------------------------";

// Track Opfor Ortego count
waitUntil {
	sleep 15;
	private ["_q"];
	_q = nearestObjects [getMarkerPos "mPat_11", ["Man"], 500];
	ADF_ortegaCnt = {side _x == east} count _q;
	if (triggerActivated tDolores) then {ADF_ortegaCnt = ADF_ortegaCnt - ADF_doloresCnt;};
	((ADF_ortegaCnt < _opforCntWin) || (time > 7200));
};
	
// Ortego cleared
ADF_ortegaClear = true;
remoteExec ["ADF_msg_ortegaClear", 0, true]; 

// End mission
waitUntil {sleep 5; ADF_ortegaClear && ADF_doloresClear};
ADF_endMission = true; publicVariable "ADF_endMission";