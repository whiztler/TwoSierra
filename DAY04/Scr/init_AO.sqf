// init
diag_log "ADF RPT: Init - executing Scr\init_AO.sqf"; // Reporting. Do NOT edit/remove
call compile preprocessFileLineNumbers "Scr\ADF_redress_Pashtun.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";

// Reinforcement vehicles
{_x hideObject true; _x enableSimulationGlobal true;} forEach [vOpforAPC_1,vOpforAPC_2,vOpforAPC_3];


diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

_ADF_vehPool = {
	_vPoolArray = ["I_G_Offroad_01_armed_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","O_APC_Wheeled_02_rcws_F"] call BIS_fnc_selectRandom;
	_vPoolArray;
};

// Random vehicle patrols
for "_i" from 1 to 5 do {
	private ["_spawnPos","_spawnDir","_v","_vX","_vp"];
	_spawnPos	= format ["mGuerVeh_%1",_i];
	_spawnDir	= markerDir _spawnPos;
	_vp			= call _ADF_vehPool;

	_c = createGroup INDEPENDENT;
	_v = [getMarkerPos _spawnPos, _spawnDir, _vp, _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressPashtun} forEach units _c;	
	_vX = _v select 0;
	
	_vX setVariable ["BIS_enableRandomization", false];
	if (_vp == "I_G_Offroad_01_armed_F") then {
		[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
	} else {
		_vX setObjectTextureGlobal [0, "Img\cusTex_pashtun.jpg"];
		_vX setObjectTextureGlobal [2, "Img\cusTex_pashtun.jpg"];
	};
	
	[_c, _spawnPos, 2000, 4, "MOVE", "SAFE", "RED", "LIMITED",25] call ADF_fnc_vehiclePatrol;
};

// AO Defence Fire Team
for "_i" from 1 to 12 do {
	private ["_g","_spawnPos"];
	_spawnPos = format ["mGuerPaxDef_%1",_i];
	_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	[_g, getMarkerPos _spawnPos, 75, 2, true] call CBA_fnc_taskDefend;	
};

// AO Defence Squad
for "_i" from 20 to 21 do {
	private ["_g","_spawnPos"];
	_spawnPos = format ["mGuerPaxDef_%1",_i];
	_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	[_g, getMarkerPos _spawnPos, 125, 1, true] call CBA_fnc_taskDefend;	
};

ADF_fnc_BOPactive = {
	// Spawn defence squads
	for "_i" from 1 to 3 do {
		private ["_g","_spawnPos"];
		_spawnPos = getPos tBOPspawn;
		_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressPashtun} forEach units _g;
		[_g, _spawnPos, 150, 1, true] call CBA_fnc_taskDefend;	
	};
	
	// Spawn patrol teams
	for "_i" from 1 to 5 do {
		private ["_g","_spawnPos"];
		_spawnPos = getPos tBOPspawn;
		_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressPashtun} forEach units _g;
		[_g, _spawnPos, 300, 3, "MOVE", "SAFE", "RED", "LIMITED", "", "", [0,0,0]] call CBA_fnc_taskPatrol;
	};
	
	// Static Vehicles/MG/AT/etc
	private ["_g","_p"];
	_g = CreateGroup INDEPENDENT; 
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_01; // Mortar
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_02; // HMG small bunker 1 
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_03; // HMG small bunker 2
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_04; // GMG tower
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_05; // HMG tower
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_06; // Madrid
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_07; // Strider
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	// Delete the spawn trigger
	tBOPspawnPos = getPos tBOPspawn; publicVariableServer "tBOPspawnPos";
	deleteVehicle tBOPspawn;
	true
};

ADF_fnc_BOPreenforce = {
	// Init
	private ["_c","_wp","_v","_t"];
	
	// enable the vehicles
	{_x hideObject false; _x enableSimulationGlobal false;} forEach [vOpforAPC_1,vOpforAPC_2,vOpforAPC_3];
	
	// Crew the vehicles and give them orders
	for "_i" from 1 to 3 do {
		_t = format ["vOpforAPC_%1",_i];
		_v = call compile format ["%1",_t];	
		_wpPos = getPos tBOPdetect;
		_c = CreateGroup INDEPENDENT; 
		_p = _c createUnit ["I_Crew_F", getMarkerPos "reEnfor", [], 0, "LIEUTENANT"]; _p moveInCommander _v;
		_p = _c createUnit ["I_Crew_F", getMarkerPos "reEnfor", [], 0, "SERGEANT"]; _p moveInGunner _v;
		_p = _c createUnit ["I_Crew_F", getMarkerPos "reEnfor", [], 0, "CORPORAL"]; _p moveInDriver _v;
		{[_x] call ADF_fnc_redressPashtun} forEach units _c;
		_wp = _c addWaypoint [_wpPos, 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "COMBAT"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED";
	};
	true
};

// Count units for reporting
_ADF_OpforCnt = {(side _x == INDEPENDENT) && (alive _x)} count allUnits;

diag_log	"-----------------------------------------------------";
diag_log format ["TWO SIERRA: AO (excl Opfor Base) spawned. Number of OpFor: %1",_ADF_OpforCnt];
diag_log	"-----------------------------------------------------";