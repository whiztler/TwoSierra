diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove

// init
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_position.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_distance.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_defendArea.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_footPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createIED.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";
call compile preprocessFileLineNumbers "scr\ADF_redress_NRF.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_Rebels.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_Russians.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_Cherno.sqf";
call compile preprocessFileLineNumbers "scr\ADF_redress_NRF.sqf";

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD,MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA,MRAP_2_1_BRAVO,MRAP_2_2_ALPHA,MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1,MRAP_2_3_WT2];
{[_x] execVM "Core\C\ADF_vCargo_B_TruckMedi.sqf"} forEach [MEDITRUCK_XO_1,MedFacil,MedFacil_1];
{[_x] execVM "Core\C\ADF_vCargo_B_TruckAmmo.sqf"} forEach [AMMOTRUCK1,AMMOTRUCK2];

///// NOLA Support

// Foot patrols	
NRF_grp_1 = [getPos bSpawn1, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
NRF_grp_1 setGroupIdGlobal ["5-1 ALPHA"];
NRF_grp_2 = [getPos bSpawn2, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
NRF_grp_2 setGroupIdGlobal ["5-1 BRAVO"];
NRF_grp_3 = [getPos bSpawn3, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
NRF_grp_3 setGroupIdGlobal ["5-2 ALPHA"];

// Static Defences & Gunners
NRF_grp_4 = CreateGroup WEST; 
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos bSpawn3, [], 0, "SERGEANT"]; _p moveInGunner sApt_1;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos bSpawn3, [], 0, "CORPORAL"]; _p moveInGunner sApt_2;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos bSpawn3, [], 0, "PRIVATE"]; _p moveInGunner sApt_3;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos bSpawn3, [], 0, "PRIVATE"]; _p moveInGunner sApt_4;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos bSpawn3, [], 0, "SERGEANT"]; _p moveInGunner bDef_01;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos bSpawn3, [], 0, "SERGEANT"]; _p moveInGunner bDef_02;
NRF_grp_4 setGroupIdGlobal ["5-2 BRAVO"];

{{[_x] call ADF_fnc_redressNRF;} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3,NRF_grp_4];

{[_x, position leader _x, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3];

sleep .5;
{{_x setObjectTextureGlobal [0, "\a3\characters_f\BLUFOR\Data\clothing_sage_co.paa"];} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3,NRF_grp_4];

///// DIANA

_g = createGroup INDEPENDENT;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mDiana", [], 0, "SERGEANT"]; _p moveInGunner sDiana_1;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mDiana", [], 0, "CORPORAL"]; _p moveInGunner sDiana_6;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mDiana", [], 0, "PRIVATE"]; _p moveInGunner sDiana_3;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mDiana", [], 0, "PRIVATE"]; _p moveInGunner sDiana_2;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mDiana", [], 0, "SERGEANT"]; _p moveInGunner sDiana_8;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mDiana", [], 0, "SERGEANT"]; _p moveInGunner sDiana_20;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mDiana", [], 0, "SERGEANT"]; _p moveInGunner sDiana_21;
{[_x] call ADF_fnc_redressCherno} forEach units _g;

///// Airbus
vAirbus1TO = false;

[] spawn {
	private ["_c","_p","_wp"];
	sleep ((random 150) + (random 150));
	vAirbus1TO = true;
	_c = createGroup WEST;
	_p = _c createUnit ["B_Helipilot_F", getPos bSpawn3, [], 0, "SERGEANT"]; _p moveInDriver vAirbus1;
	_wp = _c addWaypoint [getMarkerPos "mFargo", 0];
	_wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "GREEN";
	vAirbus1 flyInHeight 20;
	waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
	sleep 2;
	if !(isNil "vAirbus1") then {{deleteVehicle _x} forEach (crew vAirbus1); deleteVehicle vAirbus1; vAirbus1 = nil};
};

[] spawn {
	private ["_c","_p","_wp"];
	waitUntil {sleep 5; vAirbus1TO};
	sleep 5;
	_c = createGroup WEST;
	_p = _c createUnit ["B_Helipilot_F", getPos bSpawn3, [], 0, "SERGEANT"]; _p moveInDriver vAirbus2;
	_wp = _c addWaypoint [getMarkerPos "mFargo", 0];
	_wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "GREEN";
	vAirbus2 flyInHeight 20;
	waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
	sleep 2;
	if !(isNil "vAirbus2") then {{deleteVehicle _x} forEach (crew vAirbus2); deleteVehicle vAirbus2; vAirbus2 = nil};
};

#include "init_AO.sqf"