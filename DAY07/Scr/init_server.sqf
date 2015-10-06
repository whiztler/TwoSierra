diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove

// init
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_position.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_distance.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createIED.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
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

///// FOB KEARNEY

// Foot patrols	
NRF_grp_1 = [getPos uSpawn, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
NRF_grp_1 setGroupIdGlobal ["5-1 ALPHA"];

NRF_grp_2 = [getPos uSpawn, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
NRF_grp_2 setGroupIdGlobal ["5-1 BRAVO"];

// Static Defences & Ambient Vehicles
NRF_grp_3 = CreateGroup WEST; 
_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "SERGEANT"]; _p moveInGunner bDef_01;
_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "CORPORAL"]; _p moveInGunner bDef_02;
//_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_03;
//_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_04;
//_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_05;
//_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "CORPORAL"]; _p moveInGunner oStat_06;
//_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_07;
//_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_08;
NRF_grp_3 setGroupIdGlobal ["5-1 CHARLIE"];

{_x enableSimulationGlobal false} forEach units NRF_grp_3;
{{[_x] call ADF_fnc_redressNRF;} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3];

{[_x, position leader _x, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "", "", [1,2,3]] call CBA_fnc_taskPatrol;} forEach [NRF_grp_1,NRF_grp_2];

sleep .5;
{{_x setObjectTextureGlobal [0, "\a3\characters_f\BLUFOR\Data\clothing_sage_co.paa"];} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3];

// Create random IED's
private ["_iedMarkerArr"];
_iedMarkerArr = ["mIED_1","mIED_2","mIED_3","mIED_4","mIED_5","mIED_6","mIED_7","mIED_8","mIED_9","mIED_10","mIED_11","mIED_12","mIED_13","mIED_14"];
for "_i" from 1 to 5 do {
	private ["_iedMarkerPos","_idx"];
	_iedMarkerPos		= _iedMarkerArr call BIS_fnc_selectRandom;
	_idx				= _iedMarkerArr find _iedMarkerPos;
	_iedMarkerArr deleteAt _idx;
	[_iedMarkerPos,100,250,4.5] call ADF_fnc_createRandomIEDs;
};

indep_cp1 = [CP_1a,CP_1b,CP_1c,CP_1d]; {_x enableSimulationGlobal false; _x hideObjectGlobal true;} forEach indep_cp1;
indep_cp2 = [CP_2a,CP_2b,CP_2c,CP_2d]; {_x enableSimulationGlobal false; _x hideObjectGlobal true;} forEach indep_cp2;
indep_cp3 = [CP_3a,CP_3b,CP_3c,CP_3d]; {_x enableSimulationGlobal false; _x hideObjectGlobal true;} forEach indep_cp3;
indep_cp4 = [CP_4a,CP_4b,CP_4c,CP_4d]; {_x enableSimulationGlobal false; _x hideObjectGlobal true;} forEach indep_cp4;


diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

///// RUSSIAN AA SITES

// AA Sites crew
_g = createGroup EAST;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "SERGEANT"]; _p moveInGunner vAA_1;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "CORPORAL"]; _p moveInGunner vAA_2;
{[_x] call ADF_fnc_redressRussian} forEach units _g;

// Russian defense team at AA sites
for "_i" from 1 to 2 do {
	private ["_g","_spawnPos","_defArr"];
	_spawnPos = format ["mObj_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRussian} forEach units _g;

	_defArr = [_g, _spawnPos, 50, 2, true];
	_defArr call CBA_fnc_taskDefend;
	_g setVariable ["ADF_HC_garrison_CBA",true];
	_g setVariable ["ADF_HC_garrisonArr",_defArr];	
};

// Russian Lopatino patrols
for "_i" from 1 to 2 do {
	private ["_g","_spawnPos"];
	_spawnPos = format ["mObj_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRussian} forEach units _g;
	
	[_g, _spawnPos, 350, 4, "MOVE", "SAFE", "RED", "LIMITED", "", "", [0,0,0]] call CBA_fnc_taskPatrol;
};

///// REBEL FORCES

// DIANA Static crews
_g = createGroup EAST;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "SERGEANT"]; _p moveInGunner sDiana_1;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "CORPORAL"]; _p moveInGunner sDiana_2;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sDiana_3;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sDiana_4;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "CORPORAL"]; _p moveInGunner sDiana_5;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sDiana_6;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sDiana_7;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sDiana_8;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sDiana_9;
{[_x] call ADF_fnc_redressRebel} forEach units _g;

// ODIN Static crews
_g = createGroup EAST;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "SERGEANT"]; _p moveInGunner sApt_1;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "CORPORAL"]; _p moveInGunner sApt_2;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sApt_3;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sApt_4;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "CORPORAL"]; _p moveInGunner sApt_5;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sApt_6;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sApt_7;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sApt_8;
_p = _g createUnit ["O_Soldier_F", getPos oSpawn, [], 0, "PRIVATE"]; _p moveInGunner sApt_9;
{[_x] call ADF_fnc_redressRebel} forEach units _g;

// Random vehicle patrols
for "_i" from 1 to 5 do {
	private ["_spawnPos","_spawnDir","_c","_v","_vX"];
	_spawnPos = format ["mVeh_%1",_i];
	_spawnDir = markerDir _spawnPos;
	_spawnPos = getMarkerPos _spawnPos;		

	_c = createGroup EAST;
	_v = [_spawnPos, _spawnDir, "O_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressRebel} forEach units _c;
	
	_vX = _v select 0;
	_vX setVariable ["BIS_enableRandomization", false];
	[_vX, "ADF_rebelOffroad", nil] call bis_fnc_initVehicle;
	
	[_c, _spawnPos, 1500, 4, "MOVE", "SAFE", "RED", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
};

// AO Defence teams
for "_i" from 1 to 10 do {
	private ["_g","_spawnPos","_defArr"];
	_spawnPos = format ["mDef_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;

	_defArr = [_g, _spawnPos, 150, 2, true];
	_defArr call CBA_fnc_taskDefend;
	_g setVariable ["ADF_HC_garrison_CBA",true];
	_g setVariable ["ADF_HC_garrisonArr",_defArr];	
};

// Foot patrols
for "_i" from 1 to 10 do {
	private ["_g","_spawnPos"];
	_spawnPos = format ["mPat_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;
	
	[_g, _spawnPos, 700, 4, "MOVE", "SAFE", "RED", "LIMITED", "", "", [0,0,0]] call CBA_fnc_taskPatrol;
};

// Count spawned units
_ADF_OpforCnt = {(side _x == EAST) && (alive _x)} count allUnits;
_ADF_IndepCnt = {(side _x == INDEPENDENT) && (alive _x)} count allUnits;
_ADF_WestCnt = {(side _x == WEST) && (alive _x) && !isPlayer _x} count allUnits;

diag_log	"----------------------------------------------------------------------";
diag_log format ["TWO SIERRA: AO OpFor spawned, number of Opfor: %1",_ADF_OpforCnt];
diag_log format ["TWO SIERRA: AO Independent spawned, number of Independent: %1",_ADF_IndepCnt];
diag_log format ["TWO SIERRA: AO BluFor spawned, number of BluFor: %1",_ADF_WestCnt];
diag_log	"----------------------------------------------------------------------";



