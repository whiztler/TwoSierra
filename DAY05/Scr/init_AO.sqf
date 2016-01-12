ADF_wpPosRdm = {
	private ["_p"];
	_p = ["mAirPos_1", "mAirPos_2", "mAirPos_3", "mAirPos_4", "mAirPos_5"] call BIS_fnc_selectRandom;
	_p
};

[] spawn {
	while {true} do {
		private ["_c", "_v", "_wp", "_heli", "_startPos", "_exitPos", "_wpPad", "_cp"];
		_startPos = call ADF_wpPosRdm;
		_exitPos = call ADF_wpPosRdm;
		if (_startPos == _exitPos) then {_exitPos = call ADF_wpPosRdm;};		
		_heli = "B_Heli_Transport_03_F";
		_c = createGroup west;
		_v = [getMarkerPos _startPos, 0, _heli, _c] call BIS_fnc_spawnVehicle;
		_c setGroupIdGlobal ["6-1 AIRBUS"];
		vAirbus = _v select 0;
		vAirbus setObjectTextureGlobal [0, "Img\cusTex_NRFcamo.jpg"]; vAirbus setObjectTextureGlobal [1, "Img\cusTex_NRFcamo.jpg"];
		vAirbus allowDamage false;
		vAirbus flyInHeight 500;
		_cp = driver vAirbus; _cp disableAI "AUTOTARGET"; _cp disableAI "TARGET"; _cp setBehaviour "COMBAT"; _cp setCombatMode "BLUE"; _cp enableAttack false;
		{_x unassignItem "NVGoggles"; _x removeItem "NVGoggles"; _x enableGunlights "forceOn";} forEach units _c;
		vAirbus flyInHeight 75;
		_wpPad = [oAirbusPad_1,oAirbusPad_2,oAirbusPad_3,oAirbusPad_4] call BIS_fnc_selectRandom;
		_wp = _c addWaypoint [getPos _wpPad, 0];
		_wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "GREEN";
		_wp setWaypointStatements ["true", "vAirbus land 'LAND';"];	
		waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
		vAirbus flyInHeight 0;
		waitUntil {isTouchingGround vAirbus};
		vAirbus setDir (getDir _wpPad);
		{vAirbus animateDoor [_x, 1];} forEach ["door_L_source", "door_R_source", "Door_rear_source"];
		vAirbus setFuel 0;
		sleep [60,120,180,240,300,600] call BIS_fnc_selectRandom;
		vAirbus setFuel 1;
		{vAirbus animateDoor [_x, 0];} forEach ["door_L_source", "door_R_source", "Door_rear_source"];
		_wp = _c addWaypoint [getMarkerPos _exitPos, 0];
		vAirbus flyInHeight 500;
		_wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL";  _wp setWaypointCombatMode "GREEN";
		waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
		sleep 2;
		if !(isNil "vAirbus") then {{deleteVehicle _x} forEach (crew vAirbus); deleteVehicle vAirbus; vAirbus = nil};
		sleep [300,600,900,1200,1800] call BIS_fnc_selectRandom;
	};
};

[] spawn {
	sleep ((random 150) + (random 150));
	while {alive vGunship} do {
		private ["_c", "_wp", "_wpPos", "_wpPad"];	
		_c = createGroup west;
		_p = _c createUnit ["B_helipilot_F", getMarkerPos "mFargo",[],0,"LIEUTENANT"]; _p moveInDriver vGunship;
		_p = _c createUnit ["B_helipilot_F", getMarkerPos "mFargo",[],0,"LIEUTENANT"]; _p moveInGunner vGunship;
		_c setGroupIdGlobal ["6-6 PHANTOM"];
		{_x disableAI "AUTOTARGET"; _x disableAI "TARGET"; _x setBehaviour "COMBAT"; _x setCombatMode "BLUE"; _x enableAttack false} forEach units _c;
		vGunship flyInHeight 20;
		_wpPos = call ADF_wpPosRdm;
		_wp = _c addWaypoint [getMarkerPos _wpPos, 0];
		_wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "GREEN";
		_wpPos = call ADF_wpPosRdm;
		_wp = _c addWaypoint [getMarkerPos _wpPos, 0]; _wp setWaypointType "MOVE";
		_wpPad = [oGunshipPad_1,oGunshipPad_2,oGunshipPad_3] call BIS_fnc_selectRandom;
		_wp = _c addWaypoint [getPos _wpPad, 0];
		_wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "GREEN";
		_wp setWaypointStatements ["true", "vGunship land 'LAND';"];
		{_x disableAI "AUTOTARGET"; _x disableAI "CHECKVISIBLE"; _x setBehaviour "CARELESS"} forEach units _c;
		waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
		waitUntil {isTouchingGround vGunship};		
		vGunship setFuel 0;
		if !(isNil "vGunship") then {{deleteVehicle _x} forEach (crew vGunship);};
		vGunship setDir (getDir _wpPad);
		sleep [300,600,900,1200] call BIS_fnc_selectRandom;;
		vGunship setFuel 1;		
	};
};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

// AO Defence Fire Team
for "_i" from 1 to 11 do {
	private ["_g", "_p"];
	_p = format ["mGuerPaxDef_%1",_i];
	_p = getMarkerPos _p;
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;
	
	[_g, _p, 150, 2, true] call ADF_fnc_defendArea;
};

// AO Defence Squad
for "_i" from 20 to 23 do {
	private ["_g", "_p"];
	_p = format ["mGuerPaxDef_%1",_i];
	_p = getMarkerPos _p;
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfSquad")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;

	[_g, _p, 250, 2, true] call ADF_fnc_defendArea;
};

// Random vehicle patrols GUER
for "_i" from 1 to 5 do {
	private ["_p", "_d", "_v"];
	_p = format ["mGuerVeh_%1",_i];
	_d = markerDir _p;
	_p = getMarkerPos _p;

	_c = createGroup east;
	_v = [_p, _d, "O_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressRebel} forEach units _c;
	_v = _v select 0;
	_v setVariable ["BIS_enableRandomization", false];
	[_v, "ADF_rebelOffroad", nil] call bis_fnc_initVehicle;
	
	[_c, _p, 2500, 4, "MOVE", "SAFE", "RED", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
};

// Random vehicle patrols INDEP
for "_i" from 1 to 3 do {
	private ["_p", "_d", "_v"];
	_p = format ["mIndepVeh_%1",_i];
	_d = markerDir _p;
	_p = getMarkerPos _p;

	_c = createGroup INDEPENDENT;
	_v = [_p, _d, "I_APC_tracked_03_cannon_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressCherno} forEach units _c;
	_v = _v select 0;
	_v setObjectTextureGlobal [0, "Img\cusTex_ChernCamo.jpg"];
	_v setObjectTextureGlobal [1, "Img\cusTex_ChernCamo.jpg"];
	
	[_c, _p, 2000, 4, "MOVE", "SAFE", "GREEN", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
};

// AO patrol Fire Team City
for "_i" from 1 to 11 do {
	private ["_g", "_p", "_r", "_w", "_t"];
	_p = format ["mGuerPaxDef_%1",_i];
	_p = getMarkerPos _p;
	_r = floor ((random 125) + (random 100));
	_w = [3,4,5] call BIS_fnc_selectRandom;
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;
	
	[_g, _p, _r, _w, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

// Foot patrols
for "_i" from 1 to 10 do {
	private ["_g", "_p", "_r", "_w", "_t"];
	_p = format ["mGuerPaxPatrol_%1",_i];
	_p = getMarkerPos _p;
	_r = floor ((random 900) + (random 900));
	_w = [3,4,5] call BIS_fnc_selectRandom;
	//_t = ["OIA_InfTeam", "OIA_InfSentry"] call BIS_fnc_selectRandom;
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;

	[_g, _p, _r, _w, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

// Russian Lopatino patrols
for "_i" from 1 to 3 do {
	private ["_g", "_p", "_r", "_w"];
	_p = format ["mRusPatrol_%1",_i];
	_p = getMarkerPos _p;
	_r = floor ((random 250) + (random 250));
	_w = [3,4,5] call BIS_fnc_selectRandom;
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRussian} forEach units _g;

	[_g, _p, _r, _w, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

ADF_t_Lapotino = {
	private ["_g", "_p"];
	_p = getMarkerPos "mLapotino";
	
	_c = createGroup east;
	_p = _c createUnit ["O_Pilot_F", _p, [], 0, "MAJOR"]; _p moveInDriver oRusAttackHeli;
	_p = _c createUnit ["O_Pilot_F", _p, [], 0, "CORPORAL"]; _p moveInGunner oRusAttackHeli;
	{[_x] call ADF_fnc_redressRussian} forEach units _c;

	[_c, getMarkerPos "mRusPatrol_2", 2500, 50, 5, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 250] call ADF_fnc_airPatrol;
};

// Count spawned units
_ADF_OpforCnt = {side _x == east} count allUnits;
_ADF_IndepCnt = {side _x == independent} count allUnits;
_ADF_WestCnt = {side _x == west} count (allUnits - allPlayers);

diag_log	"----------------------------------------------------------------------";
diag_log format ["TWO SIERRA: AO OpFor spawned, number of Opfor: %1",_ADF_OpforCnt];
diag_log format ["TWO SIERRA: AO Independent spawned, number of Independent: %1",_ADF_IndepCnt];
diag_log format ["TWO SIERRA: AO BluFor spawned, number of BluFor: %1",_ADF_WestCnt];
diag_log	"----------------------------------------------------------------------";

ADF_init_AO = true; publicVariable "ADF_init_AO";

