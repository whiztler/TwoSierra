_p = [];
_g = [];

if (!isServer) exitWith {};

// Hazar Bagh Military Base Pax Defence
for "_i" from 1 to 7 do {
	private ["_spawnPos","_g","_defArr","_gEAST"];
	_spawnPos	= format ["mHazarBaghBase_%1",_i];
	_spawnPos	= getMarkerPos _spawnPos;		
	
	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT} forEach units _g;
	
	_defArr = [_g, _spawnPos, 50, 2, true];
	_defArr call ADF_fnc_defendArea;
	
	if (CSAThostile) then {_gEAST = createGroup EAST; (units _g) joinSilent _gEAST};
};

for "_i" from 1 to 2 do {
	private ["_g","_gEAST"];
	_g = [getMarkerPos "mCSAT_base_1", INDEPENDENT, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	[_g, getMarkerPos "mCSAT_base_1", 100, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
	
	{[_x] call ADF_fnc_redressCSAT} forEach units _g;
	if (CSAThostile) then {_gEAST = createGroup EAST; (units _g) joinSilent _gEAST};
};

for "_i" from 10 to 12 do {
	private ["_spawnPos","_g","_gEAST"];
	_spawnPos 	= format ["mHazarBaghBase_%1",_i];
	_spawnPos	= getMarkerPos _spawnPos;
	
	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	[_g, _spawnPos, 800, 5, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
	
	{[_x] call ADF_fnc_redressCSAT} forEach units _g;
	if (CSAThostile) then {_gEAST = createGroup EAST; (units _g) joinSilent _gEAST};
};

// Static
private ["_g","_p","_gEAST"];
_g = CreateGroup INDEPENDENT; 
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mCSAT_base_1", [], 0, "PRIVATE"]; _p moveInGunner vCSAT_stat_1;
{[_x] call ADF_fnc_redressCSAT} forEach units _g;
if (CSAThostile) then {_gEAST = createGroup EAST; (units _g) joinSilent _gEAST};