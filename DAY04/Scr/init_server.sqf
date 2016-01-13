diag_log "ADF RPT: Init - executing Scr\init_server.sqf"; // Reporting. Do NOT edit/remove

call compile preprocessFileLineNumbers "Core\F\ADF_fnc_position.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_distance.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_defendArea.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_footPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createIED.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";
call compile preprocessFileLineNumbers "scr\ADF_redress_NRF.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_Pashtun.sqf";

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
[MEDTENT] execVM "Core\C\ADF_vCargo_B_TruckMedi.sqf";
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD, MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA, MRAP_2_1_BRAVO, MRAP_2_2_ALPHA, MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1, MRAP_2_3_WT2];

///// NRF JOHNSON

// Static Defences & Ambient Vehicles
NRF_grp_3 = createGroup west; 
_u = NRF_grp_3 createUnit ["B_Soldier_F", getPos uSpawn, [], 0, "SERGEANT"]; _u moveInGunner oStat_01;
_u = NRF_grp_3 createUnit ["B_Soldier_F", getPos uSpawn, [], 0, "CORPORAL"]; _u moveInGunner oStat_02;
NRF_grp_3 setGroupIdGlobal ["5-1 CHARLIE"];

{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_3;

// Foot patrols	
NRF_grp_1 = [getPos uSpawn, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_1;
NRF_grp_1 setGroupIdGlobal ["5-1 ALPHA"];

NRF_grp_2 = [getPos uSpawn, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_2;
NRF_grp_2 setGroupIdGlobal ["5-1 BRAVO"];

{[_x, position leader _x, 150, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;} forEach [NRF_grp_1, NRF_grp_2];

sleep .5;
{{_x setObjectTextureGlobal [0, "\a3\characters_f\BLUFOR\Data\clothing_sage_co.paa"];} forEach units _x} forEach [NRF_grp_1, NRF_grp_2, NRF_grp_3];

// Create random IED's
private ["_a"];
_a = ["mIED_1","mIED_2","mIED_3","mIED_4","mIED_5","mIED_6","mIED_7","mIED_8","mIED_9","mIED_10","mIED_11","mIED_12","mIED_13","mIED_14","mIED_15","mIED_16"];
for "_i" from 1 to 12 do {
	private ["_p"];
	_p = _a call BIS_fnc_selectRandom;
	_a = _a - [_p];
	[_p, 100, 250, 6] call ADF_fnc_createRandomIEDs;
};

// Create the Pashtn base of operations
execVM "Scr\SOD_BOP.sqf";

// Reinforcement vehicles
{_x hideObject true; _x enableSimulationGlobal false;} forEach [vOpforAPC_1, vOpforAPC_2, vOpforAPC_3];

#include "init_ao.sqf"