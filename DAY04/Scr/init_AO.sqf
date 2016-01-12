diag_log "ADF RPT: Init - executing Scr\init_ao.sqf"; // Reporting. Do NOT edit/remove

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

// Random vehicle patrols
for "_i" from 1 to 5 do {
	private ["_p", "_d", "_v", "_vp", "_patArr"];
	_p	= format ["mGuerVeh_%1",_i];
	_d	= markerDir _p;
	_p 	= getMarkerPos _p;
	_vp	= ["I_G_Offroad_01_armed_F", "I_MRAP_03_hmg_F", "I_MRAP_03_gmg_F", "O_APC_Wheeled_02_rcws_F"] call BIS_fnc_selectRandom;

	_c = createGroup independent;
	_v = [_p, _d, _vp, _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressPashtun} forEach units _c;	
	
	_v = _v select 0;	
	_v setVariable ["BIS_enableRandomization", false];
	
	if (_vp == "I_G_Offroad_01_armed_F") then {
		[_v, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
	} else {
		_v setObjectTextureGlobal [0, "Img\cusTex_pashtun.jpg"];
		_v setObjectTextureGlobal [2, "Img\cusTex_pashtun.jpg"];
	};

	[_c, _p, 2000, 4, "MOVE", "SAFE", "RED", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
};

// AO Defence Fire Team
for "_i" from 1 to 12 do {
	private ["_g", "_p"];
	_p = format ["mGuerPaxDef_%1",_i];
	_p = getMarkerPos _p;
	
	_g = [_p, independent, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;

	[_g, _p, 150, 2, true] call ADF_fnc_defendArea;
};

// AO Defence Squad
for "_i" from 20 to 21 do {
	private ["_g", "_p"];
	_p = format ["mGuerPaxDef_%1",_i];
	_p = getMarkerPos _p;
	
	_g = [_p, independent, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;

	[_g, _p, 150, 2, true] call ADF_fnc_defendArea;
};

// Foot patrols
for "_i" from 1 to 6 do {
	private ["_g", "_p"];
	_p	= format ["mGuerPatrol_%1",_i];
	_p	= getMarkerPos _p;
	
	_g = [_p, independent, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;

	[_g, _p, 750, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

ADF_fnc_BOPactive = {
	diag_log	"-----------------------------------------------------";
	diag_log "TWO SIERRA: BOP active trigger activated";
	diag_log	"-----------------------------------------------------";

	// Static Vehicles/MG/AT/etc
	private ["_g", "_p"];
	_g = createGroup independent; 
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_01; // Mortar
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_02; // HMG small bunker 1 
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_03; // HMG small bunker 2
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_04; // GMG tower
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_05; // HMG tower
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_06; // Madrid
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_07; // Strider
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;	
	
	// Spawn defence squads
	for "_i" from 1 to 3 do {
		private ["_g", "_p"];
		_p = getPos tBOPspawn;
		
		_g = [_p, independent, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressPashtun} forEach units _g;

		[_g, _p, 150, 2, true] call ADF_fnc_defendArea;
	};
	
	// Spawn patrol teams
	for "_i" from 1 to 5 do {
		private ["_g", "_p"];
		_p = getPos tBOPspawn;
		
		_g = [_p, independent, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressPashtun} forEach units _g;

		[_g, _p, 300, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
	};
	
	// Delete the spawn trigger
	tBOPspawnPos = getPos tBOPspawn; publicVariable "tBOPspawnPos";
	if (!isNil "tBOPspawn") then {deleteVehicle tBOPspawn};
	true
};

ADF_AO_mosque = {
	// Mosque SAD
	// init
	params ["_c"];
	private ["_s", "_e", "_p", "_i"];
	_s	= 0;
	_e	= 0;
	_p	= [];

	if (_c == "nagara") then {
		_s = 30;
		_e = 34;
		_p = getPos tMosque_1;
	};
	if (_c == "nur") then {
		_s = 40;
		_e = 44;
		_p = getPos tMosque_2;
	};

	for "_i" from _s to _e do {
		private ["_spawnPos", "_wp", "_g"];
		_spawnPos = format ["mGuerPaxDef_%1",_i];
		
		_g = [getMarkerPos _spawnPos, EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressPashtun} forEach units _g;
		
		_wp = _g addWaypoint [_p, 0];
		_wp setWaypointType "SAD";
		_wp setWaypointBehaviour "COMBAT";
		_wp setWaypointSpeed "FULL";
	};

	if (_c == "nagara") then {deleteVehicle tMosque_1} else {deleteVehicle tMosque_2};
};

// Count units for reporting
_ADF_OpforCnt = {(side _x == independent) && (alive _x)} count allUnits;

diag_log	"-----------------------------------------------------";
diag_log format ["TWO SIERRA: AO (excl Opfor Base) spawned. Number of OpFor: %1",_ADF_OpforCnt];
diag_log	"-----------------------------------------------------";

ADF_init_AO = true; publicVariable "ADF_init_AO";