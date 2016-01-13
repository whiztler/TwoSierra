diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove

// init
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_pition.sqf";
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

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD,MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA,MRAP_2_1_BRAVO,MRAP_2_2_ALPHA,MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1,MRAP_2_3_WT2];
{[_x] execVM "Core\C\ADF_vCargo_B_TruckMedi.sqf"} forEach [MEDITRUCK_XO,MedFacil];

///// NRF FARGO

// Foot patrols	
NRF_grp_1 = [getPos oGunshipPad_1, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
NRF_grp_1 setGroupIdGlobal ["5-1 ALPHA"];

NRF_grp_2 = [getPos oAirbusPad_1, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
NRF_grp_2 setGroupIdGlobal ["5-1 BRAVO"];

// Static Defences & Ambient Vehicles
NRF_grp_3 = createGroup west; 
_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "SERGEANT"]; _p moveInGunner oStat_01;
_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "CORPORAL"]; _p moveInGunner oStat_02;
_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_03;
//_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_04;
//_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_05;
//_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "CORPORAL"]; _p moveInGunner oStat_06;
//_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_07;
//_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_08;
NRF_grp_3 setGroupIdGlobal ["5-1 CHARLIE"];

{_x enableSimulationGlobal false} forEach units NRF_grp_3;
{{[_x] call ADF_fnc_redressNRF;} forEach units _x} forEach [NRF_grp_1, NRF_grp_2, NRF_grp_3];

{[_x, position leader _x, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;} forEach [NRF_grp_1, NRF_grp_2];

sleep .5;
{{_x setObjectTextureGlobal [0, "\a3\characters_f\BLUFOR\Data\clothing_sage_co.paa"];} forEach units _x} forEach [NRF_grp_1, NRF_grp_2, NRF_grp_3];

// Create random IED's
private ["_a", "_i"];
_a = ["mIED_1", "mIED_2", "mIED_3", "mIED_4", "mIED_5", "mIED_6", "mIED_7", "mIED_8", "mIED_9", "mIED_10", "mIED_11", "mIED_12", "mIED_13", "mIED_14", "mIED_15", "mIED_16", "mIED_17", "mIED_18", "mIED_19"];
for "_i" from 1 to 7 do {
	private ["_p"];
	_p = _a call BIS_fnc_selectRandom;
	_a = _a - [_p];
	[_p, 100, 250, 4.5] call ADF_fnc_createRandomIEDs;
};

indep_cp1 = [CP_1a,CP_1b,CP_1c,CP_1d]; {_x enableSimulationGlobal false; _x hideObjectGlobal true;} forEach indep_cp1;
indep_cp2 = [CP_2a,CP_2b,CP_2c,CP_2d]; {_x enableSimulationGlobal false; _x hideObjectGlobal true;} forEach indep_cp2;
indep_cp3 = [CP_3a,CP_3b,CP_3c,CP_3d]; {_x enableSimulationGlobal false; _x hideObjectGlobal true;} forEach indep_cp3;
indep_cp4 = [CP_4a,CP_4b,CP_4c,CP_4d]; {_x enableSimulationGlobal false; _x hideObjectGlobal true;} forEach indep_cp4;

#include "init_AO.sqf"

// Caches

_ADF_debug_testALL = false;

{_x addEventHandler ["killed", {remoteExec ["ADF_fnc_CacheDestroyed", 0, true];}]} forEach [cacheObj1, cacheObj2, cacheObj3, cacheObj4, cacheObj5, cacheObj6];

{	
	_x allowDamage false;
	_x addEventHandler ["Killed",{[_this select 0] spawn ADF_fnc_CacheExplosion}];
} forEach [cacheObj1, cacheObj2, cacheObj3, cacheObj4, cacheObj5, cacheObj6];

// Test all compositions
if (_ADF_debug_testALL) exitWith {
	private ["_p", "_p", "_d", "_c", "_n", "_m", "_i"];
	for "_i" from 1 to 24 do {
		_p = format ["mObj%1",_i];
		_p = getMarkerPos _p;
		_p = [_p select 0, _p select 1, .30];
		_d = markerDir _p;
		diag_log format ["Cache: %1",_p];
		_c = createVehicle ["Box_FIA_Ammo_F", _p, [], 0, "NONE"];
		_c allowDamage false;
		_c setVectorUp surfaceNormal position _c;
		_c setDir _d;
		_c allowDamage true;
		_n = format ["CacheDebug_%1",_i];
		_m = createMarker [_n, getMarkerPos _p];
		_m setMarkerShape "ICON";
		_m setMarkerType "mil_dot";
		_m setMarkerColor "ColorGreen";
		sleep .1;	
	};	
	hint "All caches created...";
};

// Create random Weapoms Caches
private "_a";
_a = ["mObj1", "mObj2", "mObj3", "mObj4", "mObj5", "mObj6", "mObj7", "mObj8", "mObj9", "mObj10", "mObj11", "mObj12", "mObj13", "mObj14", "mObj15", "mObj16", "mObj17", "mObj18", "mObj19", "mObj20", "mObj21", "mObj22", "mObj23", "mObj24"];
diag_log	"-----------------------------------------------------";
{
	private ["_p", "_d", "_name", "_m"];
	_p = _a call BIS_fnc_selectRandom;
	_a = _a - [_p];
	
	_d = markerDir _p;
	_p = getMarkerPos _p;
	_p = [_p select 0, _p select 1, 1];	
	
	// Move Cache item to random selected position
	_x setPosATL _p;
	_x setDamage 0;
	_x setVectorUp surfaceNormal position _x;
	_x setDir _d;
	_x allowDamage true;
	
	diag_log format ["TWO SIERRA: cache objective %1 at marker %2 (position: %3 %4",_x,_p,round (_p select 0), round (_p select 1)];

	if (ADF_debug) then {
		private ["_n", "_m"];
		_n = format ["debug_%1",_p];
		_m = createMarker [_n, _p];
		_m setMarkerSize [1,1];
		_m setMarkerShape "ICON";
		_m setMarkerType "mil_dot";
		_m setMarkerColor "ColorGreen";
		_m setMarkerText format ["%1: %2",_x,_p];
	};
} forEach [cacheObj1, cacheObj2, cacheObj3, cacheObj4, cacheObj5, cacheObj6];
diag_log	"-----------------------------------------------------";

if (ADF_debug) then {
	{
		private ["_p", "_n", "_m"];
		_p = getPos _x;
		_n = format ["debug%1", _x];
		_m = createMarker [_n, _p];
		_m setMarkerSize [50, 50];
		_m setMarkerShape "ELLIPSE";
		_m setMarkerColor "ColorRed";
	} forEach [cacheObj1, cacheObj2, cacheObj3, cacheObj4, cacheObj5, cacheObj6];
};

ADF_fnc_CacheExplosion = {
	params ["_p"];
	_p = getPos _p;
	"Bo_GBU12_LGB" createVehicle _p; sleep random 1;
	"2Rnd_Mk82" createVehicle _p; sleep random 1;
	"Bo_GBU12_LGB" createVehicle _p; sleep random 1;
	"M_RPG32_AA_F" createVehicle _p; sleep random 1;
	"HelicopterExploBig" createVehicle _p; sleep random 1;
	"Bo_GBU12_LGB" createVehicle _p; sleep random 1;
	"2Rnd_Mk82" createVehicle _p; sleep random 1;
	"Bo_GBU12_LGB" createVehicle _p; sleep random 1;
	"M_RPG32_AA_F" createVehicle _p; sleep random 1;
	"HelicopterExploSmall" createVehicle _p; sleep 1;
	"Bo_GBU12_LGB" createVehicle _p; sleep 1;
	"HelicopterExploBig" createVehicle _p;
	ADF_cacheCount = ADF_cacheCount + 1;
	publicVariable "ADF_cacheCount";
	if (ADF_cacheCount == 3) then {ADF_endMission = true};
};

waitUntil {time > 40};

// Additional AO Defence Team at actual cache locations
for "_i" from 1 to 6 do {
	private ["_g", "_c", "_p"];
	_c	= format ["cacheObj%1", _i];
	_p	= call compile format ["%1", _c];
	_p	= getPos _p;
	
	_g = [_p, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;

	[_g, _p, 150, 2, true] call ADF_fnc_defendArea;
};

// Foot patrols cache locations
for "_i" from 1 to 5 do {
	private ["_c", "_g", "_p"];
	_c	= format ["cacheObj%1", _i];
	_p	= call compile format ["%1", _c];
	_p	= getPos _p;
	
	_g = [_p, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;

	[_g, _p, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};