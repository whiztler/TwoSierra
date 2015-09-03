_p = [];
_g = [];

// Run below scripts only on the HC or server
if (!ADF_HC_execute) exitWith {}; // Autodetect: execute on the HC else execute on the server

// Hazar Bagh Military Base Pax Defence
for "_i" from 1 to 7 do {
	private ["_spawnPos"];
	_spawnPos = format ["mHazarBaghBase_%1",_i];
	_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	[_g, getMarkerPos _spawnPos, 50, 1, true] call CBA_fnc_taskDefend;
	{[_x] call ADF_fnc_redressCSAT} forEach units _g;
};

for "_i" from 1 to 2 do {
	_g = [getMarkerPos "mCSAT_base_1", INDEPENDENT, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	[_g, getMarkerPos "mCSAT_base_1", 100, 3, "MOVE", "SAFE", "YELLOW", "LIMITED", "COLUMN", "", [2,15,30]] call CBA_fnc_taskPatrol;
	{[_x] call ADF_fnc_redressCSAT} forEach units _g;
};

for "_i" from 10 to 12 do {
	private ["_spawnPos"];
	_spawnPos = format ["mHazarBaghBase_%1",_i];
	_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "Indep" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	[_g, getMarkerPos _spawnPos, 800, 5, "MOVE", "SAFE", "YELLOW", "LIMITED", "COLUMN", "", [1,2,3]] call CBA_fnc_taskPatrol;
	{[_x] call ADF_fnc_redressCSAT} forEach units _g;
};

// Static
_g = CreateGroup INDEPENDENT; 
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mCSAT_base_1", [], 0, "PRIVATE"]; _p moveInGunner vCSAT_stat_1;
{[_x] call ADF_fnc_redressCSAT} forEach units _g;
