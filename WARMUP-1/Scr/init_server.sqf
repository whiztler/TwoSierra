diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_position.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_distance.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_defendArea.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_footPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createIED.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_Pashtun.sqf";
call compile preprocessFileLineNumbers "scr\ADF_redress_NRF.sqf";

{_x setMarkerBrush "SolidFull"; _x setMarkerColor "ColorRed"; _x setMarkerAlpha 0.1;} forEach ["mRed_1", "mRed_2", "mRed_3", "mRed_4", "mRed_5"];

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
[medTruck] execVM "Core\C\ADF_vCargo_B_TruckMedi.sqf"; 
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD, MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA, MRAP_2_1_BRAVO, MRAP_2_2_ALPHA, MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1, MRAP_2_3_WT2];

///// NRF FARGO

// Foot patrols	
NRF_grp_1 = [getPos uSpawn, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
NRF_grp_1 setGroupIdGlobal ["5-1 ALPHA"];

NRF_grp_2 = [getPos uSpawn, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
NRF_grp_2 setGroupIdGlobal ["5-1 BRAVO"];

// Static Defences & Ambient Vehicles
NRF_grp_3 = createGroup west; 
_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos uSpawn, [], 0, "SERGEANT"]; _p moveInGunner oStat_01;
_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos uSpawn, [], 0, "SERGEANT"]; _p moveInGunner oStat_02;
NRF_grp_3 setGroupIdGlobal ["5-1 CHARLIE"];

{_x enableSimulationGlobal false} forEach units NRF_grp_3;
{{[_x] call ADF_fnc_redressNRF;} forEach units _x} forEach [NRF_grp_1, NRF_grp_2, NRF_grp_3];

{[_x, getPos uSpawn, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 25] call ADF_fnc_footPatrol;} forEach [NRF_grp_1, NRF_grp_2];

sleep .5;
{{_x setObjectTextureGlobal [0, "\a3\characters_f\BLUFOR\Data\clothing_sage_co.paa"];} forEach units _x} forEach [NRF_grp_1, NRF_grp_2, NRF_grp_3];

// Object markers
_objArr = ["Land_HBarrierWall6_F", "Land_HBarrier_5_F", "Land_Radar", "US_WarfareBBarracks_Base_EP1", "Fort_Barracks_USMC", "US_WarfareBFieldhHospital_Base_EP1"];
[_objArr,uSpawn,150] call ADF_fnc_objectMarker;
{[_x] call ADF_fnc_reMarker} forEach ["respawn_west", "mVehRepair"];

// Create random IED's
private ["_a", "_i"];
_a = ["mIED_1", "mIED_2", "mIED_3", "mIED_4", "mIED_5", "mIED_6", "mIED_7", "mIED_8", "mIED_9", "mIED_10", "mIED_11", "mIED_12", "mIED_13", "mIED_14", "mIED_15", "mIED_16", "mIED_17", "mIED_18", "mIED_19", "mIED_20", "mIED_21", "mIED_22", "mIED_23", "mIED_24", "mIED_25"];
for "_i" from 1 to 13 do {
	private ["_p", "_m", "_idx"];
	_p	= _a call BIS_fnc_selectRandom;
	_a	= _a - [_p]; 
	[_p, 100, 250, 6] call ADF_fnc_createRandomIEDs;
};

ADF_clearedZones = 0;

ADF_SOD_zonesTracker = {
	// init
	params ["_t", "_m", "_o"];
	
	// Set marker to active AO
	_m setMarkerColor "ColorOPFOR";
	_m setMarkerAlpha 0.3;
	
	waitUntil {
		private ["_a", "_c"];
		sleep 5;				
		_a = (getPos _t) nearEntities ["Man", 1000];
		_c = {side _x == independent} count _a;
		_c < 5;
	};

	_m setMarkerColor "ColorBLUFOR";
	_m setMarkerAlpha 0.2;
	
	ADF_clearedZones = ADF_clearedZones + 1;
	[ADF_clearedZones] remoteExec ["ADF_msg_clearedAO", -2, true];
};

ADF_SOD_zones = {
	// init
	params ["_t", "_m"];
	private ["_ps", "_pe", "_pev", "_gp", "_gd", "_vc", "_r", "_pr", "_dr", "_a", "_o"];
	_r	= ((triggerArea _t) select 0) / 2;
	_m	= "";
	_pr	= _r / 1.2;
	_dr	= 150;

	_gp	= "HAF_InfSentry";
	_gd	= "HAF_InfTeam";
	_vc	= "I_G_Offroad_01_armed_F";
	
	_ps	= 0;
	_pe	= 0;
	_pev	= 0;

	switch _t do {
		case tRedZone_1 : {_ps = 10; _pe = 15; _pev = 13; _m = "mRed_1"};
		case tRedZone_2 : {_ps = 20; _pe = 25; _pev = 23; _m = "mRed_2"};
		case tRedZone_3 : {_ps = 50; _pe = 55; _pev = 53; _m = "mRed_3"};
		case tRedZone_4 : {_ps = 60; _pe = 65; _pev = 63; _m = "mRed_4"};
		case tRedZone_5 : {_ps = 70; _pe = 75; _pev = 73; _m = "mRed_5"};
	};
	
	// spawn/create groups
	for "_i" from _ps to _pe do {
		private ["_g", "_p"];	
		_p	= format ["mPaxPat_%1",_i];
		_p	= getMarkerPos _p;
		
		_g = [_p, independent, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> _gp)] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressPashtun} forEach units _g;

		[_g, _p, _pr, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
	};

	for "_i" from _ps to _pe do {
		private ["_g", "_p", "_defArr"];
		_p 	= format ["mPaxDef_%1",_i];
		_p	= getMarkerPos _p;
		
		_g = [_p, independent, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> _gd)] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressPashtun} forEach units _g;

		[_g, _p, _dr, 2, true] call ADF_fnc_defendArea;
	};

	for "_i" from _ps to _pev do {
		private ["_p", "_d", "_v", "_c"];
		_p	= format ["mVehPat_%1",_i];
		_d	= markerDir _p;
		_p	= getMarkerPos _p;
		
		_c = createGroup independent;
		_v = [_p, _d, _vc, _c] call BIS_fnc_spawnVehicle;		
		{[_x] call ADF_fnc_redressPashtun} forEach units _c;
		_v = _v select 0;
		_v setVariable ["BIS_enableRandomization", false];
		[_v, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
		
		[_c, _p, 800, 4, "MOVE", "SAFE", "RED", "LIMITED",25] call ADF_fnc_vehiclePatrol;		
	};
	
	sleep 3;

	[_t, _m] spawn ADF_SOD_zonesTracker;
};