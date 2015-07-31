private ["_diagTestStart","_diagTestEnd"];
_diagTestStart = diag_tickTime;
diag_log "ADF RPT: Init - executing Scr\init.sqf"; // Reporting. Do NOT edit/remove

// init
_g = [];
_p = [];
CSAThostile 		= false;
xRayDestroyed 	= false;
bearclawRescued 	= false;
if (isServer) then {
	#include "zebra_server.sqf"
	#include "init_server.sqf"
};
if (hasInterface) then {
	#include "init_client.sqf"
};
#include "bearclaw_client.sqf"
execVM "Core\ADF_SOD_CAS.sqf";

if (!ADF_HC_execute) exitWith {}; // HC Autodetect. If no HC present execute on the Server.

// Init Server/HC
execVM "Scr\pashtun.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
ADF_airActive = false;

// CSAT CP 1
[] spawn {
	waitUntil {sleep 30; time > 600};
	private ["_g","_p"];
	// CP pax
	_g = [getMarkerPos "mCSAT_CP_1", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	[_g, getMarkerPos "mCSAT_CP_1", 50, 1, true] call CBA_fnc_taskDefend;
	{_x addPrimaryWeaponItem "acc_flashlight"; _x unassignItem "NVGoggles_OPFOR"; _x removeItem "NVGoggles_OPFOR"; _x enableGunlights "forceOn";} forEach units _g;
	// Static/Vehicle gunners
	_g = CreateGroup EAST; 
	_p = _g createUnit ["O_Soldier_F", getMarkerPos "mCSAT_CP_1", [], 0, "PRIVATE"]; _p moveInGunner vCSAT_CP_veh_1;
};

// CSAT CP 2
[] spawn {
	waitUntil {sleep 30; time > 605};
	private ["_g","_p"];
	// CP pax
	_g = [getMarkerPos "mCSAT_CP_2", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	[_g, getMarkerPos "mCSAT_CP_2", 50, 1, true] call CBA_fnc_taskDefend;
	{_x addPrimaryWeaponItem "acc_flashlight"; _x unassignItem "NVGoggles_OPFOR"; _x removeItem "NVGoggles_OPFOR"; _x enableGunlights "forceOn";} forEach units _g;
	// Static/Vehicle gunners
	_g = CreateGroup EAST; 
	_p = _g createUnit ["O_Soldier_F", getMarkerPos "mCSAT_CP_2", [], 0, "PRIVATE"]; _p moveInGunner vCSAT_CP_veh_2;
};	

// CSAT CP 3
// CP pax
_g = [getMarkerPos "mCSAT_CP_3", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
[_g, getMarkerPos "mCSAT_CP_3", 50, 1, true] call CBA_fnc_taskDefend;
{_x addPrimaryWeaponItem "acc_flashlight"; _x unassignItem "NVGoggles_OPFOR"; _x removeItem "NVGoggles_OPFOR"; _x enableGunlights "forceOn";} forEach units _g;
// Static/Vehicle gunners
_g = CreateGroup EAST; 
_p = _g createUnit ["O_Soldier_F", getMarkerPos "mCSAT_CP_3", [], 0, "PRIVATE"]; _p moveInGunner vCSAT_CP_veh_3;
_p = _g createUnit ["O_Soldier_F", getMarkerPos "mCSAT_CP_3", [], 0, "PRIVATE"]; _p moveInGunner vCSAT_CP_veh_4;

// CSAT random air traffic 
ADF_fnc_CSAT_airPool = {
	private ["_airVehicle"];
	_airVehicle = ["O_Heli_Transport_04_F","O_Heli_Transport_04_ammo_F","O_Heli_Transport_04_bench_F","O_Heli_Transport_04_box_F","O_Heli_Transport_04_covered_F","O_Heli_Transport_04_fuel_F","O_Heli_Transport_04_medevac_F","O_Heli_Transport_04_repair_F","O_Heli_Light_02_unarmed_F","O_Heli_Light_02_F"] call BIS_fnc_selectRandom;
	_airVehicle;
};

[] spawn {
	waitUntil {sleep 30; time > 660};
	while {true} do {
		ADF_airActive = true;
		private ["_c","_v","_wp","_pause","_heli","_startPos"];
		_pause = [300,600,900,1200,1800] call BIS_fnc_selectRandom;
		_heli = call ADF_fnc_CSAT_airPool;			
		_startPos = ["mCSATair_1","mCSATair_2","mCSATair_3","mCSATair_4","mCSATair_5","mCSATair_6","mCSATair_7","mCSATair_8"] call BIS_fnc_selectRandom;		
		_landPos = [land_1,land_2,land_1,land_2] call BIS_fnc_selectRandom;		
		_c = createGroup EAST;		
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
		_startPos = ["mCSATair_1","mCSATair_7","mCSATair_8"] call BIS_fnc_selectRandom;
		_endPos = ["mCSATair_3","mCSATair_4","mCSATair_5"] call BIS_fnc_selectRandom;
		_pause = [360,600,1200,2400] call BIS_fnc_selectRandom;
		_flyAlt = [30,50,150,200,250,300,350] call BIS_fnc_selectRandom;
		_type = ["O_Plane_CAS_02_F","O_Heli_Attack_02_black_F","O_Heli_Light_02_F"] call BIS_fnc_selectRandom;		
		[getMarkerPos _startPos, getMarkerPos _endPos, _flyAlt, "FULL", _type, EAST] call BIS_fnc_ambientFlyby; 		
		sleep 5;		
		[getMarkerPos _startPos, getMarkerPos _endPos, _flyAlt, "FULL", _type, EAST] call BIS_fnc_ambientFlyby;
		sleep _pause;
	};
};

// CSAT vehicle patrols
ADF_fnc_CSAT_liteVeh_pool = {
	private ["_vPoolArray"];
	_vPoolArray = ["O_Truck_02_covered_F","O_Truck_03_transport_F","O_MRAP_02_F","O_Truck_03_ammo_F","O_Truck_02_box_F","O_Truck_03_covered_F"] call BIS_fnc_selectRandom;
	_vPoolArray;
};

ADF_fnc_CSAT_armVeh_pool = {
	private ["_vPoolArray"];	
	_vPoolArray = ["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_APC_Wheeled_02_rcws_F"] call BIS_fnc_selectRandom;
	_vPoolArray;
};	

for "_i" from 1 to 6 do {
	private ["_spawnPos","_vPool"];	
	_vPool = call ADF_fnc_CSAT_liteVeh_pool;
	_spawnPos = format ["mCSATVeh_%1",_i];
	[EAST, _vPool, _spawnPos, "mCSATpatrol", 2500, 5, "MOVE", "SAFE", "WHITE", "LIMITED", 25] call ADF_fnc_createVehiclePatrol;
};

for "_i" from 7 to 8 do {
	private ["_spawnPos","_vPool"];	
	_vPool = call ADF_fnc_CSAT_armVeh_pool;
	_spawnPos = format ["mCSATVeh_%1",_i];
	[EAST, _vPool, _spawnPos, "mCSATpatrol", 2500, 5, "MOVE", "SAFE", "WHITE", "LIMITED", 25] call ADF_fnc_createVehiclePatrol;
};

// Pashtun Veh patrols (map)
_mapVehArray = ["mGuerVeh_30","mGuerVeh_31","mGuerVeh_32","mGuerVeh_33","mGuerVeh_34","mGuerVeh_35"];

for "_i" from 0 to 2 do {
	private ["_spawnPos","_spawnDir","_v","_mN","_m"];
	_spawnPos = _mapVehArray call BIS_fnc_selectRandom;
	_vPool = ["I_G_Offroad_01_armed_F","I_Truck_02_transport_F","I_G_Offroad_01_F"] call BIS_fnc_selectRandom;
	_idx =  _mapVehArray find _spawnPos;
	_mapVehArray deleteAt _idx;
	_spawnDir = markerDir _spawnPos;

	_c = createGroup INDEPENDENT;
	_v = [getMarkerPos _spawnPos, _spawnDir, _vPool, _c] call BIS_fnc_spawnVehicle;
	_cX = units _c; {[_x] call ADF_fnc_redress} forEach _cX;
	_vX = _v select 0;
	if (_vPool == "I_Truck_02_transport_F") then {
		_vX setObjectTextureGlobal [0, "Img\NRF_cusTex_zamak.jpg"];
		_vX setObjectTextureGlobal [1, "Img\NRF_cusTex_pashtun.jpg"];
		
	} else {
		[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
	};
	
	//[_c, getMarkerPos _spawnPos, 1200, 4, "MOVE", "SAFE", "RED", "LIMITED", "", "", [0,0,0]] call CBA_fnc_taskPatrol;
	[_c, _spawnPos, 800, 4, "MOVE", "SAFE", "RED", "LIMITED",25] call ADF_fnc_vehiclePatrol;
};

_diagTestEnd = diag_tickTime;
if (isServer) then {diag_log format ["ADF RPT: Init - FINISHED Scr\init.sqf  [ %1 ]",_diagTestStart - _diagTestEnd];};