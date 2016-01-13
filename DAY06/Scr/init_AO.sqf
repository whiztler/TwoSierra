diag_log "ADF RPT: Init - executing Scr\init_ao.sqf"; // Reporting. Do NOT edit/remove

ADF_wpPosRdm = {
	private ["_wpPos"];
	_wpPos = ["mAirPos_1", "mAirPos_2", "mAirPos_3", "mAirPos_4", "mAirPos_5"] call BIS_fnc_selectRandom;
	_wpPos
};

[] spawn {
	while {true} do {
		private ["_c", "_v", "_wp", "_ps", "_pe", "_wpPad"];
		_ps = call ADF_wpPosRdm;
		_pe = call ADF_wpPosRdm;
		if (_ps == _pe) then {waitUntil {_pe = call ADF_wpPosRdm; _ps != _pe}};
		_c = createGroup west;
		_c setCombatMode "GREEN";
		_v = [getMarkerPos _ps, 0, "B_Heli_Transport_03_F", _c] call BIS_fnc_spawnVehicle;
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
		{_x disableAI "AUTOTARGET"; _x disableAI "CHECKVISIBLE"; _x setBehaviour "CARELESS"} forEach units _c;
		waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
		vAirbus flyInHeight 0;
		waitUntil {isTouchingGround vAirbus};
		vAirbus setDir (getDir _wpPad);
		{vAirbus animateDoor [_x, 1];} forEach ["door_L_source", "door_R_source", "Door_rear_source"];
		vAirbus setFuel 0;
		sleep ([60,120,180,240,300,600] call BIS_fnc_selectRandom);
		vAirbus setFuel 1;
		{vAirbus animateDoor [_x, 0];} forEach ["door_L_source", "door_R_source", "Door_rear_source"];
		_wp = _c addWaypoint [getMarkerPos _pe, 0];
		_wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "GREEN";
		vAirbus flyInHeight 500;
		waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
		sleep 2;
		if !(isNil "vAirbus") then {{deleteVehicle _x} forEach (crew vAirbus); deleteVehicle vAirbus; vAirbus = nil};
		sleep ([300,600,900,1200,1800] call BIS_fnc_selectRandom);
	};
};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

// AO Defence Sentry at all cache markers
private "_i";
for "_i" from 1 to 24 do {
	private ["_g", "_p"];
	_p = format ["mObj%1", _i];
	_p = getMarkerPos _p;
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;

	[_g, _p, 50, 2, true] call ADF_fnc_defendArea;
};

// Mortar crew
private ["_g", "_p"];
_g = createGroup east;
_p = _g createUnit ["O_Soldier_F", getPos oStat_1, [], 0, "SERGEANT"]; _p moveInGunner oStat_1;
_p = _g createUnit ["O_Soldier_F", getPos oStat_2, [], 0, "CORPORAL"]; _p moveInGunner oStat_2;
_p = _g createUnit ["O_Soldier_F", getPos oStat_3, [], 0, "CORPORAL"]; _p moveInGunner oStat_3;
_p = _g createUnit ["O_Soldier_F", getPos oStat_4, [], 0, "CORPORAL"]; _p moveInGunner oStat_4;
{[_x] call ADF_fnc_redressRebel; [_x] call ADF_fnc_setTurretGunner} forEach units _g;

// Random vehicle patrols GUER
for "_i" from 1 to 7 do {
	private ["_p", "_d", "_c", "_v"];
	_p = format ["mGuerVeh_%1", _i];
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

// Random vehicle patrols INDEP
for "_i" from 1 to 3 do {
	private ["_p", "_d", "_c", "_v"];
	_p = format ["mIndepVeh_%1", _i];
	_d = markerDir _p;
	_p = getMarkerPos _p;		

	_c = createGroup independent;
	_v = [_p, _d, "I_APC_tracked_03_cannon_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressCherno} forEach units _c;
	
	_v = _v select 0;
	_v setObjectTextureGlobal [0, "Img\cusTex_ChernCamo.jpg"];
	_v setObjectTextureGlobal [1, "Img\cusTex_ChernCamo.jpg"];
	
	[_c, _p, 2000, 4, "MOVE", "SAFE", "GREEN", "LIMITED",25] call ADF_fnc_vehiclePatrol;
};

// Foot patrols
for "_i" from 1 to 5 do {
	private ["_g", "_p"];
	_p = format ["mGuerPaxPatrol_%1", _i];
	_p = getMarkerPos _p;
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;

	[_g, _p, 1500, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

// Russian Lopatino patrols
for "_i" from 1 to 3 do {
	private ["_g", "_p"];
	_p = format ["mRusPatrol_%1", _i];
	_p = getMarkerPos _p;
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRussian} forEach units _g;

	[_g, _p, 350, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

ADF_t_Lapotino = {
	private ["_g", "_p"];
	_p = getMarkerPos "mLapotino";
	
	_c = createGroup east;
	_p = _c createUnit ["O_Pilot_F", _p, [], 0, "MAJOR"]; _p moveInDriver oRusAttackHeli;
	_p = _c createUnit ["O_Pilot_F", _p, [], 0, "CORPORAL"]; _p moveInGunner oRusAttackHeli;
	{[_x] call ADF_fnc_redressRussian} forEach units _c;

	[_c, getMarkerPos "mRusPatrol_2", 2500, 4, "MOVE", "COMBAT", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

// Count spawned units
diag_log	"----------------------------------------------------------------------";
diag_log format ["TWO SIERRA: AO OpFor spawned, number of Opfor: %1", {side _x == east} count allUnits];
diag_log format ["TWO SIERRA: AO independent spawned, number of independent: %1", {side _x == independent} count allUnits];
diag_log format ["TWO SIERRA: AO BluFor spawned, number of BluFor: %1", {(side _x == west) && !isPlayer _x} count allUnits];
diag_log	"----------------------------------------------------------------------";

ADF_init_AO = true; publicVariable "ADF_init_AO";