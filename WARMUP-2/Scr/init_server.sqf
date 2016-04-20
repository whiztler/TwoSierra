diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_position.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_distance.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_defendArea.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_footPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createIED.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_ur_Rebels.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_ur_Russians.sqf";
call compile preprocessFileLineNumbers "scr\ADF_ur_NRF.sqf";

{_x setMarkerBrush "SolidFull"; _x setMarkerColor "ColorRed"; _x setMarkerAlpha 0.1;} forEach ["mRed_1", "mRed_2"];
{_x setMarkerBrush "SolidFull"; _x setMarkerColor "ColorGreen"; _x setMarkerAlpha 0.1;} forEach ["mGreen_1", "mGreen_2", "mGreen_3"];

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
{[_x] execVM "Core\C\ADF_vCargo_B_TruckMedi.sqf"} forEach [uSpawn,medTruck];
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
NRF_grp_3 setGroupIdGlobal ["5-1 CHARLIE"];

{_x enableSimulationGlobal false} forEach units NRF_grp_3;
{{[_x] call ADF_fnc_urNRF;} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3];

{[_x, position leader _x, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE",5] call ADF_fnc_footPatrol;} forEach [NRF_grp_1,NRF_grp_2];

sleep .5;
{{_x setObjectTextureGlobal [0, "\a3\characters_f\BLUFOR\Data\clothing_sage_co.paa"];} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3];

// Create random IED's
private ["_a", "_i"];
_a = ["mIED_1", "mIED_2", "mIED_3", "mIED_4", "mIED_5", "mIED_6", "mIED_7", "mIED_8", "mIED_9", "mIED_10", "mIED_11", "mIED_12", "mIED_13", "mIED_14", "mIED_15", "mIED_16", "mIED_17", "mIED_18", "mIED_19", "mIED_20", "mIED_21", "mIED_22", "mIED_23", "mIED_24", "mIED_25"];
for "_i" from 1 to 13 do {
	private ["_p", "_m", "_idx"];
	_p = _a call BIS_fnc_selectRandom;
	_a = _a - [_p];
	[_p, 100, 250, 6] call ADF_fnc_createRandomIEDs;
};

ADF_clearedZones = 0;

ADF_SOD_zonesTracker = {
	// init
	params ["_t", "_m", "_o"];
	
	// Set marker to active AO
	if (_m == "mRed_1" || _m == "mRed_2") then {
		_m setMarkerColor "ColorOPFOR";
	} else {
		_m setMarkerColor "Colorindependent";
	};	
	_m setMarkerAlpha 0.3;
	
	waitUntil {
		private ["_a", "_c"];
		sleep 5;				
		_a = (getPos _t) nearEntities ["Man", 1250];
		_c = {(side _x == independent) || (side _x == east)} count _a;
		_c < 5;
	};

	_m setMarkerColor "ColorBLUFOR";
	_m setMarkerAlpha 0.2;
	
	ADF_clearedZones = ADF_clearedZones + 1;
	[ADF_clearedZones] remoteExec ["ADF_msg_clearedAO", -2, true];
};

ADF_SOD_zones = {
	// init
	params ["_t"];
	private ["_ps", "_pe", "_pev", "_gp", "_gd", "_vc", "_r", "_pr", "_dr", "_i", "_ur", "_s"];
	_r	= ((triggerArea _t) select 0) / 2;
	_m	= "";
	_pr	= _r / 1.2;
	_dr	= 150;

	_gp	= "OIA_InfSentry";
	_gd	= "OIA_InfSquad";
	_vc	= "O_G_Offroad_01_armed_F";
	
	_ps	= 0;
	_pe	= 0;
	_ur	= ADF_fnc_urRussian;
	_s	= "ADF_russianOffroad";

	switch _t do {
		///// Russian zones
		case tRusZone_1 : {_ps = 10; _pe = 15; _pev = 13; _m = "mRed_1"};
		case tRusZone_2 : {_ps = 20; _pe = 25; _pev = 23; _m = "mRed_2"};
		
		///// Rebel zones
		case tRebelZone_1 : {_ps = 50; _pe = 55; _pev = 53; _ur = ADF_fnc_urRebel; _s = "ADF_rebelOffroad"; _m = "mGreen_1"};
		case tRebelZone_2 : {_ps = 60; _pe = 65; _pev = 63; _ur = ADF_fnc_urRebel; _s = "ADF_rebelOffroad"; _m = "mGreen_2"};
		case tRebelZone_3 : {_ps = 70; _pe = 75; _pev = 73; _ur = ADF_fnc_urRebel; _s = "ADF_rebelOffroad"; _m = "mGreen_3"};
	};
	
	// spawn/create groups

	for "_i" from _ps to _pe do {
		private ["_g", "_p", "_w"];	
		_p = format ["mPaxPat_%1", _i];
		_w = [3,4,5] call BIS_fnc_selectRandom;
		
		_g = [getMarkerPos _p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> _gp)] call BIS_fnc_spawnGroup;
		{[_x] call _ur} forEach units _g;

		[_g, getMarkerPos _p, _pr, _w, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
	};
	
	for "_i" from _ps to _pe do {
		private ["_g", "_p", "_r", "_w"];
		_p = format ["mPaxDef_%1", _i];
		
		_g = [getMarkerPos _p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> _gd)] call BIS_fnc_spawnGroup;
		{[_x] call _ur} forEach units _g;
		
		[_g, _p, _dr, 2, true] call ADF_fnc_defendArea;
	};
	
	for "_i" from _ps to _pev do {
		private ["_p", "_d", "_v", "_c"];
		_p = format ["mVehPat_%1", _i];
		_d = markerDir _p;	
		
		_c = createGroup east;
		_v = [getMarkerPos _p, _d, _vc, _c] call BIS_fnc_spawnVehicle;		
		{[_x] call _ur} forEach units _c;
		_v = _v select 0;
		_v setVariable ["BIS_enableRandomization", false];
		[_v, _s, nil] call bis_fnc_initVehicle;
		
		[_c, _p, 1000, 5, "MOVE", "SAFE", "RED", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
	};
	
	sleep 3;

	[_t, _m] spawn ADF_SOD_zonesTracker;
};