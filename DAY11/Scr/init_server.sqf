diag_log "ADF RPT: Init - executing Scr\init_server.sqf"; // Reporting. Do NOT edit/remove

call compile preprocessFileLineNumbers "Core\F\ADF_fnc_position.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_distance.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_defendArea.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_footPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_seaPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";
call compile preprocessFileLineNumbers "scr\ADF_redress_NRF.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_CSAT3.sqf";

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
[SUPPLYTRUCK_AMMO] execVM "Core\C\ADF_vCargo_B_TruckAmmo.sqf";
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD, MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA, MRAP_2_1_BRAVO, MRAP_2_2_ALPHA, MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1, MRAP_2_3_WT2];
{[_x] execVM "Core\C\ADF_vCargo_B_TruckMedi.sqf"} forEach [MEDITRUCK_XO,MedFacil];

tEndMission enableSimulation false;
{_x enableSimulationGlobal false; _x hideObject true; _x lock 3} forEach [vReinf_1, vReinf_2, vReinf_3, vReinf_4, vReinf_5, vReinf_6];

// Pasteur evac
ADF_AO_evac = {
	private ["_c", "_p", "_wp"];
	if (!MotsActive) then {sleep ((random 150) + (random 150))};	
	
	[] spawn {
		private ["_c", "_u", "_wp", "_t"];
		_c = createGroup east;
		_c setVariable ["ADF_noHC_transfer", true];
		_u = _c createUnit ["O_soldier_F", getPos mSpawn, [], 0, "SERGEANT"]; _u moveInDriver vEvac1;	
		_wp = _c addWaypoint [getMarkerPos "cEnd", 0];
		_wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "GREEN";
		_u disableAI "AUTOTARGET"; _u disableAI "CHECKVISIBLE"; _u setBehaviour "CARELESS";
		_t = time;
		waitUntil {((currentWaypoint (_wp select 0)) > (_wp select 1)) || time == _t + 300};
		if !(isNil "vEvac1") then {vEvac1 setDamage 1; vEvac1 = nil};
		deleteGroup _c;
	};
	
	_c = createGroup east;
	_c setVariable ["ADF_noHC_transfer", true];
	_u = _c createUnit ["O_Helipilot_F", getPos mSpawn, [], 0, "SERGEANT"]; _u moveInDriver vAir_1;	
	
	_wp = _c addWaypoint [getMarkerPos "mBase_3", 0];
	_wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "GREEN";
	 sleep 2;
	_u = _c createUnit ["O_Helipilot_F", getPos mSpawn, [], 0, "SERGEANT"]; _u moveInDriver vAir_2; sleep 2;
	_u = _c createUnit ["O_Helipilot_F", getPos mSpawn, [], 0, "SERGEANT"]; _u moveInDriver vAir_3;
	
	{_x flyInHeight 50} forEach [vAir_1, vAir_2, vAir_3];
	_c allowFleeing 0;
	{_x disableAI "AUTOTARGET"; _x disableAI "CHECKVISIBLE"; _x setBehaviour "CARELESS"} forEach units _c;
	remoteExec ["ADF_AO_evac", -2, true];
	waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
	{if !(isNil "_x") then {{deleteVehicle _x} forEach (crew _x); deleteVehicle _x; _x = nil}} forEach [vAir_1, vAir_2, vAir_3];
	deleteGroup _c;
};

// Distraction
[] spawn {
	private ["_t", "_s"];
	_t = 1200;
	_s = (120 + random 10);	
	
	waitUntil {sleep 5; if (MotsActive) then {_t = 120; _s = 5}; time > _t};
	remoteExec ["ADF_msg_distraction", -2, true];
	sleep _s;
	
	private "_i";
	for "_i" from 0 to 12 do {
		private ["_b", "_p"];
		_p = getMarkerPos "mDistract";
		_p = [_p, random 360, 100] call ADF_fnc_randomPosMax;
		_p = [_p select 0, _p select 1, (_p select 2) + 25],
		_b = createVehicle [(["Bo_GBU12_LGB", "HelicopterExploBig"] call BIS_fnc_selectRandom), _p, [], 0, "NONE"];
		deleteVehicle _b;
		sleep ((random 10) + (random 10));
	};	
};

#include "init_ao.sqf"