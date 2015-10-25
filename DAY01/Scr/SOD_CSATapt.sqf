_p = [];
_g = [];

if (!isServer) exitWith {};

// Airport Pax Defence
for "_i" from 1 to 3 do {
	private ["_g","_spawnPos","_gEAST","_defArr"];
	_spawnPos	= format ["mAirport_%1",_i];
	_spawnPos	= getMarkerPos _spawnPos;
	
	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	_defArr = [_g, _spawnPos, 50, 1, true];
	_defArr call ADF_fnc_defendArea;
	_g setVariable ["ADF_HC_garrison_ADF",true];
	_g setVariable ["ADF_HC_garrisonArr",_defArr];

	{[_x] call ADF_fnc_redressCSAT} forEach units _g;
	if (CSAThostile) then {_gEAST = createGroup EAST; (units _g) joinSilent _gEAST};
};

// Patrol groups
for "_i" from 1 to 2 do {
	private ["_g","_spawnPos","_gEAST"];
	_spawnPos	= getMarkerPos "mCSAT_base_2";
	
	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	[_g, _spawnPos, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
	{[_x] call ADF_fnc_redressCSAT} forEach units _g;
	if (CSAThostile) then {_gEAST = createGroup EAST; (units _g) joinSilent _gEAST};
};

// Patrol groups
for "_i" from 10 to 12 do {
	private ["_g","_spawnPos","_gEAST"];
	_spawnPos	= format ["mAirport_%1",_i];
	_spawnPos	= getMarkerPos _spawnPos;
	
	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	[_g, _spawnPos, 300, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
	{[_x] call ADF_fnc_redressCSAT} forEach units _g;
	if (CSAThostile) then {_gEAST = createGroup EAST; (units _g) joinSilent _gEAST};
};

// Static
private ["_g","_p","_gEAST"];
_g = CreateGroup INDEPENDENT; 
_p = _g createUnit ["I_crew_F", getMarkerPos "mCSAT_base_2", [], 0, "SERGEANT"]; _p moveInGunner vCSAT_apt_AA;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mCSAT_base_2", [], 0, "PRIVATE"]; _p moveInGunner vCSAT_stat_2;
{[_x] call ADF_fnc_redressCSAT} forEach units _g;
if (CSAThostile) then {_gEAST = createGroup EAST; (units _g) joinSilent _gEAST};
