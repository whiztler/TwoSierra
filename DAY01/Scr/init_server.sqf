diag_log "ADF RPT: Init - executing Scr\init_server.sqf"; // Reporting. Do NOT edit/remove
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_position.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_distance.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_defendArea.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_footPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createIED.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_Pashtun.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_CSAT.sqf";

execVM "Scr\bearclaw_server.sqf";
execVM "Scr\xray_server.sqf";	

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD,MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA,MRAP_2_1_BRAVO,MRAP_2_2_ALPHA,MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1,MRAP_2_3_WT2];

ADF_airActive = false;

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Spawning CSAT + Pashtun CP's, Patrols";
diag_log	"-----------------------------------------------------";

// CSAT CP 1
// CP pax
private ["_g","_defArr"];
_g = [getMarkerPos "mCSAT_CP_1", INDEPENDENT, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
_defArr = [_g, getMarkerPos "mCSAT_CP_1", 50, 1, true];
_defArr call ADF_fnc_defendArea;
_g setVariable ["ADF_HC_garrison_ADF",true];
_g setVariable ["ADF_HC_garrisonArr",_defArr];
{[_x] call ADF_fnc_redressCSAT} forEach units _g;
// Static/Vehicle gunners
_g = CreateGroup INDEPENDENT; 
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mCSAT_CP_1", [], 0, "PRIVATE"]; _p moveInGunner vCSAT_CP_veh_1;
{[_x] call ADF_fnc_redressCSAT} forEach units _g;

// CSAT CP 2
// CP pax
private ["_g","_defArr"];
_g = [getMarkerPos "mCSAT_CP_2", INDEPENDENT, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
_defArr = [_g, getMarkerPos "mCSAT_CP_2", 50, 1, true];
_defArr call ADF_fnc_defendArea;
_g setVariable ["ADF_HC_garrison_ADF",true];
_g setVariable ["ADF_HC_garrisonArr",_defArr];
{[_x] call ADF_fnc_redressCSAT} forEach units _g;
// Static/Vehicle gunners
_g = CreateGroup INDEPENDENT; 
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mCSAT_CP_2", [], 0, "PRIVATE"]; _p moveInGunner vCSAT_CP_veh_2;

// CSAT CP 3
// CP pax
private ["_g","_defArr"];
_g = [getMarkerPos "mCSAT_CP_3", INDEPENDENT, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
_defArr = [_g, getMarkerPos "mCSAT_CP_3", 50, 1, true];
_defArr call ADF_fnc_defendArea;
_g setVariable ["ADF_HC_garrison_ADF",true];
_g setVariable ["ADF_HC_garrisonArr",_defArr];
{[_x] call ADF_fnc_redressCSAT} forEach units _g;
// Static/Vehicle gunners
private ["_g","_p"];
_g = CreateGroup INDEPENDENT; 
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mCSAT_CP_3", [], 0, "PRIVATE"]; _p moveInGunner vCSAT_CP_veh_3;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mCSAT_CP_3", [], 0, "PRIVATE"]; _p moveInGunner vCSAT_CP_veh_4;
{[_x] call ADF_fnc_redressCSAT} forEach units _g;

// CSAT random air traffic 
ADF_fnc_CSAT_airPool = {
	private ["_airVehicle"];
	_airVehicle = ["O_Heli_Transport_04_F","O_Heli_Transport_04_ammo_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_box_F","O_Heli_Transport_04_covered_F","O_Heli_Transport_04_fuel_F","O_Heli_Transport_04_medevac_F","O_Heli_Transport_04_repair_F","O_Heli_Light_02_unarmed_F","O_Heli_Light_02_F"] call BIS_fnc_selectRandom;
	_airVehicle;
};

[] spawn {
	waitUntil {sleep 30; time > 660};
	while {true} do {
		waitUntil {sleep 10; !ADF_airActive};
		ADF_airActive = true;
		
		private ["_c","_v","_wp","_pause","_heli","_startPos"];
		_pause = [300,600,900,1200,1800] call BIS_fnc_selectRandom;
		_heli = call ADF_fnc_CSAT_airPool;			
		_startPos = ["mCSATair_1","mCSATair_2","mCSATair_3","mCSATair_4","mCSATair_5","mCSATair_6","mCSATair_7","mCSATair_8"] call BIS_fnc_selectRandom;		
		_landPos = [land_1,land_2,land_1,land_2] call BIS_fnc_selectRandom;		
		
		_c = createGroup INDEPENDENT;
		_v = [getMarkerPos _startPos, 0, _heli, _c] call BIS_fnc_spawnVehicle;
		{_x unassignItem "NVGoggles_OPFOR"; _x removeItem "NVGoggles_OPFOR"; _x enableGunlights "forceOn";} forEach units _c;
		v1 = _v select 0;
		_wp = _c addWaypoint [getPos _landPos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "NORMAL";
		_wp setWaypointStatements ["true", "v1 land 'LAND';"];	
		
		waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
		waitUntil {isTouchingGround v1};
		
		_pausePad = [60,120,180,240,300,600] call BIS_fnc_selectRandom;
		v1 setFuel 0;
		ADF_airActive = false;
		sleep _pausePad;
		v1 setFuel 1;
		
		_exitPos = ["mCSATair_1","mCSATair_2","mCSATair_3","mCSATair_4","mCSATair_5","mCSATair_6","mCSATair_7","mCSATair_8"] call BIS_fnc_selectRandom;
		_wp = _c addWaypoint [getMarkerPos _exitPos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "NORMAL";
		
		waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
		sleep 2;
		
		if !(isNil "v1") then {{deleteVehicle _x} forEach (crew v1); deleteVehicle v1; v1 = nil};		
		sleep _pause;
	};
};

// Randomized Ambient fly-by's
[] spawn {
	waitUntil {sleep 30; time > 1200};
	while {true} do {
		waitUntil {sleep 10; !ADF_airActive};
		
		private ["_startPos","_endPos","_pause","_flyAlt","_type"];
		_startPos	= ["mCSATair_1","mCSATair_7","mCSATair_8"] call BIS_fnc_selectRandom;
		_endPos		= ["mCSATair_3","mCSATair_4","mCSATair_5"] call BIS_fnc_selectRandom;
		_pause		= [360,600,1200,2400] call BIS_fnc_selectRandom;
		_flyAlt		= [30,50,150,200,250,300,350] call BIS_fnc_selectRandom;
		_type		= ["O_Plane_CAS_02_F","O_Heli_Attack_02_black_F","O_Heli_Light_02_F"] call BIS_fnc_selectRandom;
		
		[getMarkerPos _startPos, getMarkerPos _endPos, _flyAlt, "FULL", _type, EAST] call BIS_fnc_ambientFlyby; 		
		sleep 5;		
		[getMarkerPos _startPos, getMarkerPos _endPos, _flyAlt, "FULL", _type, EAST] call BIS_fnc_ambientFlyby;
		sleep _pause;
	};
};

for "_i" from 1 to 6 do {
	private ["_spawnPos","_vPool","_spawnDir","_g","_v"];	
	_spawnPos	= format ["mCSATVeh_%1",_i];
	_spawnDir	= markerDir _spawnPos;
	_spawnPos	= getMarkerPos _spawnPos;
	_vPool 		= ["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_APC_Wheeled_02_rcws_F"] call BIS_fnc_selectRandom;
	
	_g = createGroup INDEPENDENT;
	_v = [_spawnPos, _spawnDir, _vPool, _g] call BIS_fnc_spawnVehicle;
	[_g, _spawnPos, 2500, 5, "MOVE", "SAFE", "RED", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
	{[_x] call ADF_fnc_redressCSAT} forEach units _g;
};

for "_i" from 7 to 8 do {
	private ["_spawnPos","_vPool","_spawnDir","_g","_v"];	
	_spawnPos 	= format ["mCSATVeh_%1",_i];
	_spawnDir	= markerDir _spawnPos;
	_spawnPos	= getMarkerPos _spawnPos;	
	_vPool		= ["O_Truck_02_covered_F","O_Truck_03_transport_F","O_MRAP_02_F","O_Truck_03_ammo_F","O_Truck_02_box_F","O_Truck_03_covered_F"] call BIS_fnc_selectRandom;	
	
	_g = createGroup INDEPENDENT;
	_v = [_spawnPos, _spawnDir, _vPool, _g] call BIS_fnc_spawnVehicle;
	[_g, _spawnPos, 2500, 5, "MOVE", "SAFE", "RED", "LIMITED",25] call ADF_fnc_vehiclePatrol;
	{[_x] call ADF_fnc_redressCSAT} forEach units _g;
};

// Pashtun Veh patrols (map)
_mapVehArray = ["mGuerVeh_30","mGuerVeh_31","mGuerVeh_32","mGuerVeh_33","mGuerVeh_34","mGuerVeh_35"];

for "_i" from 0 to 2 do {
	private ["_spawnPos","_vPool","_spawnDir","_c","_v","_vX"];	
	_spawnPos 	= _mapVehArray call BIS_fnc_selectRandom;
	_idx 		= _mapVehArray find _spawnPos;
	_spawnDir 	= markerDir _spawnPos;
	_spawnPos	= getMarkerPos _spawnPos;
	_vPool 		= ["I_G_Offroad_01_armed_F","I_Truck_02_transport_F","I_G_Offroad_01_F"] call BIS_fnc_selectRandom;	
	_mapVehArray deleteAt _idx;

	_c = createGroup EAST;
	_v = [_spawnPos, _spawnDir, _vPool, _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressPashtun} forEach units _c;
	
	_vX = _v select 0;
	_vX setVariable ["BIS_enableRandomization", false];
	
	if (_vPool == "I_Truck_02_transport_F") then {
		_vX setObjectTextureGlobal [0, "Img\cusTex_zamak.jpg"];
		_vX setObjectTextureGlobal [1, "Img\cusTex_pashtun.jpg"];
		
	} else {
		[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
	};

	[_c, _spawnPos, 800, 4, "MOVE", "SAFE", "RED", "LIMITED",25] call ADF_fnc_vehiclePatrol;
};

[] spawn { // CSAT switch side random timer
	private ["_time","_CSATswitch","_CSAThostileSet"];
	_time			= [45,60,75,90,105,120] call BIS_fnc_selectRandom;
	_CSATswitch		= 60 * _time;
	
	waitUntil {sleep 10; time > _CSATswitch};
	
	CSAThostile 		= true; publicVariable "CSAThostile";
	_CSAThostileSet	= 5 * _time;
	sleep _CSAThostileSet;
	
	_validBlueFor 	= allPlayers + (units gBearclaw);	
	{if (side _x == INDEPENDENT) then {_gEAST = createGroup EAST; (units _x) joinSilent _gEAST}} forEach allGroups;		
};	
