diag_log "ADF RPT: Init - executing Scr\init_server.sqf"; // Reporting. Do NOT edit/remove

call compile preprocessFileLineNumbers "Core\F\ADF_fnc_position.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_distance.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_defendArea.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_footPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_seaPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_airPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createPara.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_ambientCombatManager.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";
call compile preprocessFileLineNumbers "scr\ADF_redress_NRF.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_CSAT3.sqf";

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
{[_x] execVM "Core\C\ADF_vCargo_B_TruckAmmo.sqf"} forEach [SUPPLYTRUCK_AMMO, SUPPLYTRUCK_AMMO_1];
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD,MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA,MRAP_2_1_BRAVO,MRAP_2_2_ALPHA,MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1,MRAP_2_3_WT2];
{[_x] execVM "Core\C\ADF_vCargo_B_TruckMedi.sqf"} forEach [MEDITRUCK_XO,MedFacil];

// Static Defences & Ambient Vehicles
NRF_grp_3 = createGroup west; 
_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos uSpawn, [], 0, "SERGEANT"]; _p moveInGunner oStat_01;
_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos uSpawn, [], 0, "CORPORAL"]; _p moveInGunner oStat_02;
NRF_grp_3 setGroupIdGlobal ["5-1 CHARLIE"];

[] spawn {
	waitUntil {sleep 10; ADF_assaultStart};
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

// ACM
["mZulu", 1200, 120, true, true, true, east, 2, 150] spawn ADF_fnc_ACM;

#include "init_ao.sqf"