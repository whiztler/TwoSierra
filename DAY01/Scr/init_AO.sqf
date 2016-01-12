diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Spawning CSAT + Pashtun CP's, Patrols";
diag_log	"-----------------------------------------------------";

// CSAT CP 1
// Static/Vehicle gunners
_g = createGroup independent; 
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mCSAT_CP_1", [], 0,  "PRIVATE"]; _p moveInGunner vCSAT_CP_veh_1;
{[_x] call ADF_fnc_redressCSAT} forEach units _g;

// CP pax
private ["_g"];
_g = [getMarkerPos "mCSAT_CP_1", independent, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
[_g, getMarkerPos "mCSAT_CP_1", 50,  1, true] call ADF_fnc_defendArea;
{[_x] call ADF_fnc_redressCSAT} forEach units _g;

// CSAT CP 2
// Static/Vehicle gunners
_g = createGroup independent; 
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mCSAT_CP_2", [], 0,  "PRIVATE"]; _p moveInGunner vCSAT_CP_veh_2;

// CP pax
private ["_g"];
_g = [getMarkerPos "mCSAT_CP_2", independent, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
[_g, getMarkerPos "mCSAT_CP_2", 50,  1, true] call ADF_fnc_defendArea;
{[_x] call ADF_fnc_redressCSAT} forEach units _g;


// CSAT CP 3
// Static/Vehicle gunners
private ["_g", "_p"];
_g = createGroup independent; 
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mCSAT_CP_3", [], 0,  "PRIVATE"]; _p moveInGunner vCSAT_CP_veh_3;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mCSAT_CP_3", [], 0,  "PRIVATE"]; _p moveInGunner vCSAT_CP_veh_4;
{[_x] call ADF_fnc_redressCSAT} forEach units _g;

// CP pax
private ["_g"];
_g = [getMarkerPos "mCSAT_CP_3", independent, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
[_g, getMarkerPos "mCSAT_CP_3", 50,  1, true] call ADF_fnc_defendArea;
{[_x] call ADF_fnc_redressCSAT} forEach units _g;

// CSAT random air traffic 
[] spawn {
	waitUntil {sleep 30; time > 660};
	while {true} do {
		waitUntil {sleep 10; !ADF_airActive};
		ADF_airActive = true;
		
		private ["_c", "_v", "_wp", "_pause", "_heli", "_startPos", "_exitPos"];
		_pause = [300,  600,  900,  1200,  1800] call BIS_fnc_selectRandom;
		_heli = ["O_Heli_Transport_04_F", "O_Heli_Transport_04_ammo_F", "O_Heli_Transport_04_bench_F", "O_Heli_Transport_04_box_F", "O_Heli_Transport_04_covered_F", "O_Heli_Transport_04_fuel_F", "O_Heli_Transport_04_medevac_F", "O_Heli_Transport_04_repair_F", "O_Heli_Light_02_unarmed_F", "O_Heli_Light_02_F"] call BIS_fnc_selectRandom;;			
		_startPos = ["mCSATair_1", "mCSATair_2", "mCSATair_3", "mCSATair_4", "mCSATair_5", "mCSATair_6", "mCSATair_7", "mCSATair_8"] call BIS_fnc_selectRandom;		
		_landPos = [land_1, land_2, land_1, land_2] call BIS_fnc_selectRandom;		
		
		_c = createGroup independent;
		_v = [getMarkerPos _startPos, 0,  _heli, _c] call BIS_fnc_spawnVehicle;
		{_x unassignItem "NVGoggles_OPFOR"; _x removeItem "NVGoggles_OPFOR"; _x enableGunlights "forceOn";} forEach units _c;
		v1 = _v select 0;
		_wp = _c addWaypoint [getPos _landPos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "NORMAL";
		_wp setWaypointStatements ["true", "v1 land 'LAND';"];	
		
		_cp = driver v1;
		_cp disableAI "AUTOTARGET";	
		_cp disableAI "TARGET";
		_cp setBehaviour "COMBAT";	
		_cp setCombatMode "BLUE";
		_cp enableAttack false;
		waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
		waitUntil {isTouchingGround v1};
		
		_pausePad = [60,  120,  180,  240,  300,  600] call BIS_fnc_selectRandom;
		v1 setFuel 0;
		ADF_airActive = false;
		sleep _pausePad;
		v1 setFuel 1;
		
		_exitPos = ["mCSATair_1", "mCSATair_2", "mCSATair_3", "mCSATair_4", "mCSATair_5", "mCSATair_6", "mCSATair_7", "mCSATair_8"] call BIS_fnc_selectRandom;
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
		
		private ["_startPos", "_endPos", "_pause", "_flyAlt", "_type"];
		_startPos	= ["mCSATair_1", "mCSATair_7", "mCSATair_8"] call BIS_fnc_selectRandom;
		_endPos		= ["mCSATair_3", "mCSATair_4", "mCSATair_5"] call BIS_fnc_selectRandom;
		_pause		= [360, 600, 1200, 2400] call BIS_fnc_selectRandom;
		_flyAlt		= [30, 50, 150, 200, 250, 300, 350] call BIS_fnc_selectRandom;
		_type		= ["O_Plane_CAS_02_F", "O_Heli_Attack_02_black_F", "O_Heli_Light_02_F"] call BIS_fnc_selectRandom;
		
		[getMarkerPos _startPos, getMarkerPos _endPos, _flyAlt, "FULL", _type, EAST] call BIS_fnc_ambientFlyby; 		
		sleep 5;		
		[getMarkerPos _startPos, getMarkerPos _endPos, _flyAlt, "FULL", _type, EAST] call BIS_fnc_ambientFlyby;
		sleep _pause;
	};
};

for "_i" from 1 to 6 do {
	private ["_p", "_vc", "_d", "_g", "_v"];	
	_p	= format ["mCSATVeh_%1",_i];
	_d	= markerDir _p;
	_p	= getMarkerPos _p;
	_vc 	= ["O_MRAP_02_hmg_F", "O_MRAP_02_gmg_F", "O_APC_Wheeled_02_rcws_F"] call BIS_fnc_selectRandom;
	
	_g = createGroup independent;
	_v = [_p, _d, _vc, _g] call BIS_fnc_spawnVehicle;
	[_g, _p, 2500,  5, "MOVE", "SAFE", "RED", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
	{[_x] call ADF_fnc_redressCSAT} forEach units _g;
};

for "_i" from 7 to 8 do {
	private ["_p", "_vc", "_d", "_g", "_v"];	
	_p 	= format ["mCSATVeh_%1",_i];
	_d	= markerDir _p;
	_p	= getMarkerPos _p;	
	_vc		= ["O_Truck_02_covered_F", "O_Truck_03_transport_F", "O_MRAP_02_F", "O_Truck_03_ammo_F", "O_Truck_02_box_F", "O_Truck_03_covered_F"] call BIS_fnc_selectRandom;	
	
	_g = createGroup independent;
	_v = [_p, _d, _vc, _g] call BIS_fnc_spawnVehicle;
	[_g, _p, 2500,  5, "MOVE", "SAFE", "RED", "LIMITED",25] call ADF_fnc_vehiclePatrol;
	{[_x] call ADF_fnc_redressCSAT} forEach units _g;
};

// Pashtun Veh patrols (map)
_mapVehArray = ["mGuerVeh_30", "mGuerVeh_31", "mGuerVeh_32", "mGuerVeh_33", "mGuerVeh_34", "mGuerVeh_35"];

for "_i" from 0 to 2 do {
	private ["_p", "_vc", "_d", "_c", "_v"];	
	_p 		= _mapVehArray call BIS_fnc_selectRandom;
	_idx 	= _mapVehArray find _p;
	_d 		= markerDir _p;
	_p		= getMarkerPos _p;
	_vc 		= ["I_G_Offroad_01_armed_F", "I_Truck_02_transport_F", "I_G_Offroad_01_F"] call BIS_fnc_selectRandom;	
	_mapVehArray deleteAt _idx;

	_c = createGroup east;
	_v = [_p, _d, _vc, _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressPashtun} forEach units _c;
	
	_v = _v select 0;
	_v setVariable ["BIS_enableRandomization", false];
	
	if (_vc == "I_Truck_02_transport_F") then {
		_v setObjectTextureGlobal [0,  "Img\cusTex_zamak.jpg"];
		_v setObjectTextureGlobal [1, "Img\cusTex_pashtun.jpg"];
		
	} else {
		[_v, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
	};

	[_c, _p, 800,  4, "MOVE", "SAFE", "RED", "LIMITED",25] call ADF_fnc_vehiclePatrol;
};

[] spawn { // CSAT switch side random timer
	private ["_t", "_w", "_s"];
	_t	= [45, 60, 75, 90, 105, 120] call BIS_fnc_selectRandom;
	_w	= 60 * _t;
	
	waitUntil {sleep 10; time > _w};
	
	CSAThostile 	= true; publicVariable "CSAThostile";
	_s	= 5 * _t;
	sleep _s;

	{
		if (side _x == independent) then {
			private "_g";
			_g = createGroup east;
			(units _x) joinSilent _g
		}
	} forEach allGroups;		
};

ADF_AO_alpha = {
	_ADF_perfDiagStart = diag_tickTime;

	diag_log	"-----------------------------------------------------";
	diag_log "TWO SIERRA: Spawning ALPHA AO";
	diag_log	"-----------------------------------------------------";

	// Create random mortar positions
	private ["_a", "_g", "_u", "_i"];
	_a = ["mGuerMortar_1", "mGuerMortar_2", "mGuerMortar_3", "mGuerMortar_4", "mGuerMortar_5", "mGuerMortar_6", "mGuerMortar_7", "mGuerMortar_8", "mGuerMortar_9", "mGuerMortar_10"];
	_g = [getPos tAlpha, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	_u = units _g;
	{[_x] call ADF_fnc_redressPashtun} forEach _u;

	for "_i" from 0 to 2 do {
		private ["_p", "_v"];
		_p = _a call BIS_fnc_selectRandom;
		_a = _a - [_p];
		
		_v = createVehicle ["I_Mortar_01_F", getMarkerPos _p, [], 0, "CAN_COLLIDE"];
		_v setDir (markerDir _p);
		_u select _i moveInGunner _v;
	};

	// Random vehicle patrols
	private "_a";
	_a	= ["mGuerVeh_1", "mGuerVeh_2", "mGuerVeh_3", "mGuerVeh_4", "mGuerVeh_5"];
	for "_i" from 1 to 2 do {
		private ["_p", "_d", "_c", "_v", "_idx"];	
		_p	= _a call BIS_fnc_selectRandom;
		_a	= _a - [_p];
		_d	= markerDir _p;
		_p	= getMarkerPos _p;

		_c = createGroup east;
		_v = [_p, _d, "I_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
		{[_x] call ADF_fnc_redressPashtun} forEach units _c;
		_v = _v select 0;
		_v setVariable ["BIS_enableRandomization", false];
		[_v, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
		[_c, _p, 1200, 4, "MOVE", "SAFE", "RED", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
	};

	// Random foot patrols
	private "_a";
	_a	= ["mGuerPaxPatrol_1", "mGuerPaxPatrol_2", "mGuerPaxPatrol_3", "mGuerPaxPatrol_4", "mGuerPaxPatrol_5", "mGuerPaxPatrol_6", "mGuerPaxPatrol_7", "mGuerPaxPatrol_8", "mGuerPaxPatrol_9", "mGuerPaxPatrol_10"] call BIS_fnc_selectRandom;
	for "_i" from 0 to 3 do {
		private ["_p", "_g"];
		_p	= _a call BIS_fnc_selectRandom;
		_a	= _a - [_p];
		_p	= getMarkerPos _p;

		_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressPashtun} forEach units _g;
		[_g, _p, 600, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
	};

	// Bearclaw foot patrols
	for "_i" from 1 to 3 do {
		private ["_g"];
		_g = [getPos objBearclaw, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressPashtun} forEach units _g;
		[_g, getPos objBearclaw, 80, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
	};

	// Defence groups
	for "_i" from 1 to 8 do {
		private ["_g", "_p"];
		_p 	= format ["mGuerPaxDef_%1", _i];
		_p	= getMarkerPos _p;
		
		_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressPashtun} forEach units _g;
		[_g, _p, 100, 2, true] call ADF_fnc_defendArea;
	};

	// Bearclaw Defence Team
	private "_g";
	_g = [getPos objBearclaw, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	[_g, getPos objBearclaw, 20, 2, true] call ADF_fnc_defendArea;
};

ADF_AO_bravo = {
	diag_log	"-----------------------------------------------------";
	diag_log "TWO SIERRA: Spawning BRAVO AO";
	diag_log	"-----------------------------------------------------";

	// Random vehicle patrols
	private ["_a", "_i"];
	_a = ["mGuerVeh_20", "mGuerVeh_21", "mGuerVeh_22", "mGuerVeh_23", "mGuerVeh_24", "mGuerVeh_25"];
	for "_i" from 1 to 2 do {
		private ["_p", "_d", "_v"];
		_p	= _a call BIS_fnc_selectRandom;
		_a	= _a - [_p];
		_d 	= markerDir _p;
		_p	= getMarkerPos _p;

		_c = createGroup east;
		_v = [_p, _d, "I_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
		{[_x] call ADF_fnc_redressPashtun} forEach units _c;	
		_v = _v select 0;
		_v setVariable ["BIS_enableRandomization", false];
		[_v, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
		[_c, _p, 1000, 4, "MOVE", "SAFE", "RED", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
	};

	// Random foot patrols
	private ["_a", "_i"];
	_a = ["mGuerPaxPatrol_20", "mGuerPaxPatrol_21", "mGuerPaxPatrol_22", "mGuerPaxPatrol_23", "mGuerPaxPatrol_24", "mGuerPaxPatrol_25", "mGuerPaxPatrol_26"];
	for "_i" from 1 to 3 do {
		private ["_p", "_g"];
		_p	= _a call BIS_fnc_selectRandom;
		_a	= _a - [_p];
		_p	= getMarkerPos _p;

		_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressPashtun} forEach units _g;
		[_g, _p, 600, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
	};

	// Defence groups
	for "_i" from 10 to 13 do {
		private ["_g", "_p"];
		_p 	= format ["mGuerPaxDef_%1",_i];
		_p	= getMarkerPos _p;	
		
		_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressPashtun} forEach units _g;
		
		[_g, _p, 150, 2, true] call ADF_fnc_defendArea;	
	};

	// Defence Oil Rigs
	for "_i" from 1 to 2 do {
		private ["_g", "_p"];
		_p = format ["mGuerPaxTwr_%1",_i];
		_p = getMarkerPos _p;	
		
		_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressPashtun; _x setPosATL [_p select 0, _p select 1, 5.8]; _x setUnitPos "MIDDLE"} forEach units _g;
	};
};

ADF_AO_apt = {
	// Static
	private ["_g", "_p", "_i"];
	_g = createGroup independent; 
	_p = _g createUnit ["I_crew_F", getMarkerPos "mCSAT_base_2", [], 0, "SERGEANT"]; _p moveInGunner vCSAT_apt_AA;
	_p = _g createUnit ["I_Soldier_F", getMarkerPos "mCSAT_base_2", [], 0, "PRIVATE"]; _p moveInGunner vCSAT_stat_2;
	{[_x] call ADF_fnc_redressCSAT} forEach units _g;

	if (CSAThostile) then {[_g] call ADF_fnc_csatSwitch};

	// Airport Pax Defence
	for "_i" from 1 to 3 do {
		private ["_g", "_p"];
		_p	= format ["mAirport_%1",_i];
		_p	= getMarkerPos _p;
		
		_g = [_p, INDEPENDENT, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressCSAT} forEach units _g;
		
		[_g, _p, 50, 1, true] call ADF_fnc_defendArea;
		
		if (CSAThostile) then {[_g] call ADF_fnc_csatSwitch};
	};

	// Patrol groups
	for "_i" from 1 to 2 do {
		private ["_g", "_p"];
		_p	= getMarkerPos "mCSAT_base_2";
		
		_g = [_p, INDEPENDENT, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressCSAT} forEach units _g;
		
		[_g, _p, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
			
		if (CSAThostile) then {[_g] call ADF_fnc_csatSwitch};
	};

	// Patrol groups
	for "_i" from 10 to 12 do {
		private ["_g", "_p"];
		_p	= format ["mAirport_%1",_i];
		_p	= getMarkerPos _p;
		
		_g = [_p, INDEPENDENT, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressCSAT} forEach units _g;
		
		[_g, _p, 300, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
		
		if (CSAThostile) then {[_g] call ADF_fnc_csatSwitch};
	};
};

ADF_AO_base = {
	// Hazar Bagh Military Base

	// Defense groups
	private "_i";
	for "_i" from 1 to 7 do {
		private ["_p", "_g"];
		_p	= format ["mHazarBaghBase_%1",_i];
		_p	= getMarkerPos _p;		
		
		_g = [_p, independent, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressCSAT} forEach units _g;

		[_g, _p, 50, 2, true] call ADF_fnc_defendArea;
		
		if (CSAThostile) then {[_g] call ADF_fnc_csatSwitch};
	};

	// Foot patrols at base
	for "_i" from 1 to 2 do {
		private ["_g"];
		_g = [getMarkerPos "mCSAT_base_1", independent, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
		[_g, getMarkerPos "mCSAT_base_1", 100, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
		
		{[_x] call ADF_fnc_redressCSAT} forEach units _g;
		
		if (CSAThostile) then {[_g] call ADF_fnc_csatSwitch};
	};

	// Foot patrols AO
	for "_i" from 10 to 12 do {
		private ["_p", "_g"];
		_p 	= format ["mHazarBaghBase_%1",_i];
		_p	= getMarkerPos _p;
		
		_g = [_p, independent, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
		[_g, _p, 800, 5, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
		
		{[_x] call ADF_fnc_redressCSAT} forEach units _g;
		
		if (CSAThostile) then {[_g] call ADF_fnc_csatSwitch};
	};
};

ADF_AO_mosque = {
	// Mosque SAD
	private "_i";
	for "_i" from 30 to 34 do {
		private ["_p", "_g", "_wp"];
		_p	= format ["mGuerPaxDef_%1",_i];
		_p	= getMarkerPos _p;
		
		_g = [_p, EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressPashtun} forEach units _g;
		
		_wp = _g addWaypoint [getPos tZargMosque, 0];
		_wp setWaypointType "SAD";
		_wp setWaypointBehaviour "COMBAT";
		_wp setWaypointSpeed "FULL";
	};

	private ["_p", "_d ", "_c", "_v"];
	_p = "mGuerVeh_40";
	_d  = markerDir _p;
	_p = getMarkerPos _p;

	_c = createGroup east;
	_v = [_p, _d , "I_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressPashtun} forEach units _c;
	_v = _v select 0;
	[_v, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;

	_wp = _c addWaypoint [getPos tZargMosque, 0];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "FULL";
};

ADF_fnc_csatSwitch = {
	params ["_g"];
	private "_gEAST";
	_gEAST = createGroup east;
	(units _g) joinSilent _gEAST;
	true
};

ADF_init_AO = true; publicVariable "ADF_init_AO";
