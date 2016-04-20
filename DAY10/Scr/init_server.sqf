diag_log "ADF RPT: Init - executing Scr\init_server.sqf"; // Reporting. Do NOT edit/remove

call compile preprocessFileLineNumbers "Core\F\ADF_fnc_position.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_distance.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_defendArea.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_footPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_airPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_seaPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createIED.sqf";
call compile preprocessFileLineNumbers "scr\ADF_redress_NRF.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_CSAT3.sqf";

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
[SUPPLYTRUCK_AMMO] execVM "Core\C\ADF_vCargo_B_TruckAmmo.sqf";
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD, MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA, MRAP_2_1_BRAVO, MRAP_2_2_ALPHA, MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1, MRAP_2_3_WT2];
{[_x] execVM "Core\C\ADF_vCargo_B_TruckMedi.sqf"} forEach [MEDITRUCK_XO,MedFacil];

_p = ["mCarBomb_1", "mCarBomb_2", "mCarBomb_3"] call BIS_fnc_selectRandom;
[_p,	75, west, "C_Van_01_fuel_F"] call ADF_fnc_createCarBomb;

// Pascal heli port
ADF_AO_ortega = {
	private ["_c", "_p", "_wp"];
	if (!MotsActive) then {sleep ((random 150) + (random 150))};	
	_c = createGroup east;
	_c setVariable ["ADF_noHC_transfer", true];
	_p = _c createUnit ["O_Helipilot_F", getPos mSpawn, [], 0, "SERGEANT"]; _p moveInDriver vAir_1;	
	_wp = _c addWaypoint [getMarkerPos "mBase_3", 0];
	_wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "GREEN";
	_p = _c createUnit ["O_Helipilot_F", getPos mSpawn, [], 0, "SERGEANT"]; _p moveInDriver vAir_2;
	{_x flyInHeight 30} forEach [vAir_1, vAir_2];
	{_x disableAI "AUTOTARGET"; _x disableAI "CHECKVISIBLE"; _x setBehaviour "CARELESS"} forEach units _c;
	waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
	{if !(isNil "_x") then {{deleteVehicle _x} forEach (crew _x); deleteVehicle _x; _x = nil}} forEach [vAir_1, vAir_2];
};

// Sitrep
[] spawn {
	waitUntil {sleep 10; ADF_init_AO};
	waitUntil {
		private ["_o", "_b", "_s"];
		sleep 600 + (random 1200);
		if (ADF_endMission) exitWith {};
		_s = 10 + (round 20);
		_o = {side _x == EAST} count allUnits;
		_b = count (allPlayers - entities "HeadlessClient_F");
		[_o, _b, _s] remoteExec ["ADF_msg_sitrep",-2,true];
		ADF_endMission
	};	
};

#include "SOD_mortar_op.sqf"
#include "init_ao.sqf"

