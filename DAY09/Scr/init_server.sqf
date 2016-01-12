diag_log "ADF RPT: Init - executing Scr\init_server.sqf"; // Reporting. Do NOT edit/remove

call compile preprocessFileLineNumbers "Core\F\ADF_fnc_position.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_distance.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_defendArea.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_footPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_seaPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_airPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createIED.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";
call compile preprocessFileLineNumbers "scr\ADF_redress_NRF.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_CSAT3.sqf";

#include "ADF_SOD_comp.sqf"

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD,MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA,MRAP_2_1_BRAVO,MRAP_2_2_ALPHA,MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1,MRAP_2_3_WT2];
//{[_x] execVM "Core\C\ADF_vCargo_B_TruckMedi.sqf"} forEach [MEDITRUCK_XO_1,MedFacil];

// Trigger simulation
tFoxtrotBase enableSimulation false;
tFoxtrotAmmo enableSimulation false;
tHotelSupply enableSimulation false;
tGolfFuel enableSimulation false;

_p = ["mCarBomb_1","mCarBomb_2","mCarBomb_3"] call BIS_fnc_selectRandom;
[_p,	75, west, "C_Van_01_fuel_F"] call ADF_fnc_createCarBomb;

vTiger addEventHandler ["killed", {
	[getMarkerPos "mBase_3", getMarkerPos "mPat_1", east, 3, 700, 30, 4, "MOVE", "SAFE", "RED", "NORMAL", "FILE", 150] call ADF_fnc_createAirPatrol;
	[getMarkerPos "mMSR_8", getMarkerPos "mOp", 30, "FULL", "O_Plane_CAS_02_F", EAST] call BIS_fnc_ambientFlyby;
	[getMarkerPos "mMSR_16", getMarkerPos "mBase_9", random 40, "FULL", "O_Plane_CAS_02_F", EAST] call BIS_fnc_ambientFlyby;
}];

#include "init_ao.sqf"