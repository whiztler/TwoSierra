diag_log "ADF RPT: Init - executing Scr\init_ao.sqf"; // Reporting. Do NOT edit/remove

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

// Random vehicle patrols
for "_i" from 1 to 5 do {
	private ["_spawnPos","_spawnDir","_v","_vX","_vp","_patArr"];
	_spawnPos	= format ["mGuerVeh_%1",_i];
	_spawnDir	= markerDir _spawnPos;
	_spawnPos 	= getMarkerPos _spawnPos;
	_vp			= ["I_G_Offroad_01_armed_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","O_APC_Wheeled_02_rcws_F"] call BIS_fnc_selectRandom;

	_c = createGroup INDEPENDENT;
	_v = [_spawnPos, _spawnDir, _vp, _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressPashtun} forEach units _c;	
	_vX = _v select 0;	
	_vX setVariable ["BIS_enableRandomization", false];
	if (_vp == "I_G_Offroad_01_armed_F") then {
		[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
	} else {
		_vX setObjectTextureGlobal [0, "Img\cusTex_pashtun.jpg"];
		_vX setObjectTextureGlobal [2, "Img\cusTex_pashtun.jpg"];
	};

	[_c, _spawnPos, 2000, 4, "MOVE", "SAFE", "RED", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
};

// AO Defence Fire Team
for "_i" from 1 to 12 do {
	private ["_g","_spawnPos","_defArr"];
	_spawnPos = format ["mGuerPaxDef_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	
	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	_defArr = [_g, _spawnPos, 150, 2, true];
	_defArr call CBA_fnc_taskDefend;
	_g setVariable ["ADF_HC_garrison_CBA",true];
	_g setVariable ["ADF_HC_garrisonArr",_defArr];
};

// AO Defence Squad
for "_i" from 20 to 21 do {
	private ["_g","_spawnPos","_defArr"];
	_spawnPos = format ["mGuerPaxDef_%1",_i];
	_spawnPos = getMarkerPos _spawnPos;
	
	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	_defArr = [_g, _spawnPos, 150, 2, true];
	_defArr call CBA_fnc_taskDefend;
	_g setVariable ["ADF_HC_garrison_CBA",true];
	_g setVariable ["ADF_HC_garrisonArr",_defArr];
};

// Foot patrols
for "_i" from 1 to 6 do {
	private ["_g","_spawnPos"];
	_spawnPos	= format ["mGuerPatrol_%1",_i];
	_spawnPos	= getMarkerPos _spawnPos;
	
	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	[_g, _spawnPos, 750, 4, "MOVE", "SAFE", "RED", "LIMITED", "", "", [0,0,0]] call CBA_fnc_taskPatrol;
};

ADF_fnc_BOPactive = {
	diag_log	"-----------------------------------------------------";
	diag_log "TWO SIERRA: BOP active trigger activated";
	diag_log	"-----------------------------------------------------";

	// Spawn defence squads
	for "_i" from 1 to 3 do {
		private ["_g","_spawnPos","_defArr"];
		_spawnPos = getPos tBOPspawn;
		
		_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressPashtun} forEach units _g;
		
		_defArr = [_g, _spawnPos, 150, 2, true];
		_defArr call CBA_fnc_taskDefend;
		_g setVariable ["ADF_HC_garrison_CBA",true];
		_g setVariable ["ADF_HC_garrisonArr",_defArr];
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
	tBOPspawnPos = getPos tBOPspawn; publicVariable "tBOPspawnPos";
	if (!isNil "tBOPspawn") then {deleteVehicle tBOPspawn};
	true
};

// Count units for reporting
_ADF_OpforCnt = {(side _x == INDEPENDENT) && (alive _x)} count allUnits;

diag_log	"-----------------------------------------------------";
diag_log format ["TWO SIERRA: AO (excl Opfor Base) spawned. Number of OpFor: %1",_ADF_OpforCnt];
diag_log	"-----------------------------------------------------";