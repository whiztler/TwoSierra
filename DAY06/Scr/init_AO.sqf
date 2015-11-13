
ADF_wpPosRdm = {
	private ["_wpPos"];
	_wpPos = ["mAirPos_1","mAirPos_2","mAirPos_3","mAirPos_4","mAirPos_5"] call BIS_fnc_selectRandom;
	_wpPos
};

[] spawn {
	while {true} do {
		private ["_c","_v","_wp","_heli","_startPos","_exitPos","_pause","_wpPad"];
		_pause = [300,600,900,1200,1800] call BIS_fnc_selectRandom;
		_startPos = call ADF_wpPosRdm;
		_exitPos = call ADF_wpPosRdm;
		if (_startPos == _exitPos) then {_exitPos = call ADF_wpPosRdm;};
		_heli = "B_Heli_Transport_03_F";
		_c = createGroup WEST;
		_v = [getMarkerPos _startPos, 0, _heli, _c] call BIS_fnc_spawnVehicle;
		_c setGroupIdGlobal ["6-1 AIRBUS"];
		vAirbus = _v select 0;
		vAirbus setObjectTextureGlobal [0, "Img\cusTex_NRFcamo.jpg"]; vAirbus setObjectTextureGlobal [1, "Img\cusTex_NRFcamo.jpg"];
		vAirbus allowDamage false;
		{_x unassignItem "NVGoggles"; _x removeItem "NVGoggles"; _x enableGunlights "forceOn";} forEach units _c;
		vAirbus flyInHeight 500;
		_wpPad = [oAirbusPad_1,oAirbusPad_2,oAirbusPad_3,oAirbusPad_4] call BIS_fnc_selectRandom;
		_wp = _c addWaypoint [getPos _wpPad, 0];
		_wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "GREEN";
		_wp setWaypointStatements ["true", "vAirbus land 'LAND';"];	
		waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
		waitUntil {isTouchingGround vAirbus};
		vAirbus setDir (getDir _wpPad);
		{vAirbus animateDoor [_x, 1];} forEach ["door_L_source","door_R_source","Door_rear_source"];
		_pausePad = [60,120,180,240,300,600] call BIS_fnc_selectRandom;
		vAirbus setFuel 0;
		sleep _pausePad;
		vAirbus setFuel 1;
		{vAirbus animateDoor [_x, 0];} forEach ["door_L_source","door_R_source","Door_rear_source"];
		_wp = _c addWaypoint [getMarkerPos _exitPos, 0];
		_wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "GREEN";
		waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
		sleep 2;
		if !(isNil "vAirbus") then {{deleteVehicle _x} forEach (crew vAirbus); deleteVehicle vAirbus; vAirbus = nil};
		sleep _pause;
	};
};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

// Mortar crew
_g = createGroup EAST;
_p = _g createUnit ["O_Soldier_F", getPos oStat_1, [], 0, "SERGEANT"]; _p moveInGunner oStat_1;
_p = _g createUnit ["O_Soldier_F", getPos oStat_2, [], 0, "CORPORAL"]; _p moveInGunner oStat_2;
{[_x] call ADF_fnc_redressRebel} forEach units _g;

// Random vehicle patrols GUER
for "_i" from 1 to 5 do {
	private ["_spawnPos","_spawnDir","_c","_v","_vX"];
	_spawnPos = format ["mGuerVeh_%1",_i];
	_spawnDir = markerDir _spawnPos;
	_spawnPos = getMarkerPos _spawnPos;		

	_c = createGroup EAST;
	_v = [_spawnPos, _spawnDir, "O_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressRebel} forEach units _c;
	
	_vX = _v select 0;
	_vX setVariable ["BIS_enableRandomization", false];
	[_vX, "ADF_rebelOffroad", nil] call bis_fnc_initVehicle;
	
	[_c, _spawnPos, 2500, 4, "MOVE", "SAFE", "RED", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
};

// Random vehicle patrols INDEP
for "_i" from 1 to 3 do {
	private ["_spawnPos","_spawnDir","_c","_v","_vX"];
	_spawnPos = format ["mIndepVeh_%1",_i];
	_spawnDir = markerDir _spawnPos;
	_spawnPos = getMarkerPos _spawnPos;		

	_c = createGroup INDEPENDENT;
	_v = [_spawnPos, _spawnDir, "I_APC_tracked_03_cannon_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressCherno} forEach units _c;
	
	_vX = _v select 0;
	_vX setObjectTextureGlobal [0, "Img\cusTex_ChernCamo.jpg"];
	_vX setObjectTextureGlobal [1, "Img\cusTex_ChernCamo.jpg"];
	
	[_c, _spawnPos, 2000, 4, "MOVE", "SAFE", "GREEN", "LIMITED",25] call ADF_fnc_vehiclePatrol;
};

// AO Defence Sentry at all cache markers
for "_i" from 1 to 24 do {
	private ["_g","_spawnPos","_defArr"];
	_spawnPos = format ["mObj%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;

	_defArr = [_g, _spawnPos, 100, 2, true];
	_defArr call ADF_fnc_defendArea;
	_g setVariable ["ADF_HC_garrison_ADF",true];
	_g setVariable ["ADF_HC_garrisonArr",_defArr];	
};

// AO Defence FireTeam at actual cache locations
for "_i" from 1 to 6 do {
	private ["_g","_p","_spawnPos","_defArr"];
	_p			= format ["cacheObj%1",_i];
	_spawnPos	= call compile format ["%1",_p];
	_spawnPos	= getPos _spawnPos;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;
	
	_defArr = [_g, _spawnPos, 250, 2, true];
	_defArr call ADF_fnc_defendArea;
	_g setVariable ["ADF_HC_garrison_ADF",true];
	_g setVariable ["ADF_HC_garrisonArr",_defArr];	
};

// Foot patrols
for "_i" from 1 to 5 do {
	private ["_g","_spawnPos"];
	_spawnPos = format ["mGuerPaxPatrol_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;

	[_g, _spawnPos, 1500, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

// Russian Lopatino patrols
for "_i" from 1 to 3 do {
	private ["_g","_spawnPos"];
	_spawnPos = format ["mRusPatrol_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRussian} forEach units _g;

	[_g, _spawnPos, 350, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

ADF_t_Lapotino = {
	private ["_g","_spawnPos"];
	_spawnPos = getMarkerPos "mLapotino";
	
	_c = createGroup EAST;
	_p = _c createUnit ["O_Pilot_F", _spawnPos, [], 0, "MAJOR"]; _p moveInDriver oRusAttackHeli;
	_p = _c createUnit ["O_Pilot_F", _spawnPos, [], 0, "CORPORAL"]; _p moveInGunner oRusAttackHeli;
	{[_x] call ADF_fnc_redressRussian} forEach units _c;

	[_c, getMarkerPos "mRusPatrol_2", 2500, 4, "MOVE", "COMBAT", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
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

