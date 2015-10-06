diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createIED.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_Rebels.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_Russians.sqf";
call compile preprocessFileLineNumbers "scr\ADF_redress_NRF.sqf";

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD,MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA,MRAP_2_1_BRAVO,MRAP_2_2_ALPHA,MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1,MRAP_2_3_WT2];

///// NRF FARGO

// Foot patrols	
NRF_grp_1 = [getPos uSpawn, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
NRF_grp_1 setGroupIdGlobal ["5-1 ALPHA"];

NRF_grp_2 = [getPos uSpawn, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
NRF_grp_2 setGroupIdGlobal ["5-1 BRAVO"];

// Static Defences & Ambient Vehicles
NRF_grp_3 = CreateGroup WEST; 
_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos uSpawn, [], 0, "SERGEANT"]; _p moveInGunner oStat_01;
NRF_grp_3 setGroupIdGlobal ["5-1 CHARLIE"];

{_x enableSimulationGlobal false} forEach units NRF_grp_3;
{{[_x] call ADF_fnc_redressNRF;} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3];

{[_x, position leader _x, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "", "", [1,2,3]] call CBA_fnc_taskPatrol;} forEach [NRF_grp_1,NRF_grp_2];

sleep .5;
{{_x setObjectTextureGlobal [0, "\a3\characters_f\BLUFOR\Data\clothing_sage_co.paa"];} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3];

// Object markers
_objArr = ["Land_HBarrierWall6_F","Land_HBarrier_5_F","Land_Radar","US_WarfareBBarracks_Base_EP1","Fort_Barracks_USMC","US_WarfareBFieldhHospital_Base_EP1"];
[_objArr,uSpawn,150] call ADF_fnc_objectMarker;
{[_x] call ADF_fnc_reMarker} forEach ["respawn_west","mVehRepair","mKav"];

// Create random IED's
_iedMarkerArr = ["mIED_1","mIED_2","mIED_3","mIED_4","mIED_5","mIED_6","mIED_7","mIED_8","mIED_9","mIED_10","mIED_11","mIED_12","mIED_13","mIED_14","mIED_15","mIED_16","mIED_17","mIED_18","mIED_19","mIED_20","mIED_21","mIED_22","mIED_23","mIED_24","mIED_25"];
for "_i" from 1 to 13 do {
	private ["_iedMarkerPos","_m","_idx"];
	_iedMarkerPos = _iedMarkerArr call BIS_fnc_selectRandom;
	_idx =  _iedMarkerArr find _iedMarkerPos;
	_iedMarkerArr deleteAt _idx;
	[_iedMarkerPos,100,250,6] call ADF_fnc_createRandomIEDs;
};

ADF_SOD_zones = {
	// init
	params ["_t"];
	private ["_startMarker","_endMarker","_endMarkerVictors","_patrolsGrp","_garrisonGrp","_victorsVeh","_r","_patrolRad","_garrisonRad"];
	_r 				= ((triggerArea _t) select 0) / 2;
	_patrolRad		= _r / 1.2;
	_garrisonRad		= 250;
	_uCache			= [];
	_vCache			= [];

	_patrolsGrp 		= "OIA_InfSentry";
	_garrisonGrp		= "OIA_InfTeam";
	_victorsVeh		= "O_G_Offroad_01_armed_F";
	
	_startMarker		= 0;
	_endMarker		= 0;
	_redress			= ADF_fnc_redressRussian;
	_vSkin			= "ADF_rebelOffroad";

	///// Russian zones
	if (_t == tRusZone_1) then {_startMarker = 10; _endMarker = 15; _endMarkerVictors = 13; _redress = ADF_fnc_redressRussian; _vSkin = "ADF_russianOffroad";};
	if (_t == tRusZone_2) then {_startMarker = 20; _endMarker = 25; _endMarkerVictors = 23; _redress = ADF_fnc_redressRussian; _vSkin = "ADF_russianOffroad";};
	
	///// Rebel zones
	if (_t == tRebelZone_1) then {_startMarker = 50; _endMarker = 55; _endMarkerVictors = 53; _redress = ADF_fnc_redressRebel; _vSkin = "ADF_rebelOffroad";};
	if (_t == tRebelZone_2) then {_startMarker = 60; _endMarker = 65; _endMarkerVictors = 63; _redress = ADF_fnc_redressRebel; _vSkin = "ADF_rebelOffroad";};
	if (_t == tRebelZone_3) then {_startMarker = 70; _endMarker = 75; _endMarkerVictors = 73; _redress = ADF_fnc_redressRebel; _vSkin = "ADF_rebelOffroad";};

	// spawn/create groups

	for "_i" from _startMarker to _endMarker do {
		private ["_g","_spawnPos"];	
		_spawnPos = format ["mPaxPat_%1",_i];
		_g = [getMarkerPos _spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _patrolsGrp)] call BIS_fnc_spawnGroup;
		{[_x] call _redress} forEach units _g;
		[_g, getMarkerPos _spawnPos, _patrolRad, 4, "MOVE", "SAFE", "RED", "LIMITED", "", "", [0,0,0]] call CBA_fnc_taskPatrol;
	};
	for "_i" from _startMarker to _endMarker do {
		private ["_g","_spawnPos"];
		_spawnPos = format ["mPaxDef_%1",_i];
		_g = [getMarkerPos _spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _garrisonGrp)] call BIS_fnc_spawnGroup;
		{[_x] call _redress} forEach units _g;
		[_g, getMarkerPos _spawnPos, _garrisonRad, 2, true] call CBA_fnc_taskDefend;	
	};
	for "_i" from _startMarker to _endMarkerVictors do {
		private ["_spawnPos","_spawnDir","_v","_vX","_c"];
		_spawnPos = format ["mVehPat_%1",_i];
		_spawnDir = markerDir _spawnPos;		
		_c = createGroup EAST;
		_v = [getMarkerPos _spawnPos, _spawnDir, _victorsVeh, _c] call BIS_fnc_spawnVehicle;		
		{[_x] call _redress} forEach units _c;
		_vX = _v select 0;
		_vX setVariable ["BIS_enableRandomization", false];
		[_vX, _vSkin, nil] call bis_fnc_initVehicle;
		[_c, _spawnPos, 1000, 6, "MOVE", "SAFE", "RED", "LIMITED",25] call ADF_fnc_vehiclePatrol;
	};
};