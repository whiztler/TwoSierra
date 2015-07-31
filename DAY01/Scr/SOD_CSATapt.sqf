_p = [];
_g = [];

// Run below scripts only on the HC or server
if (!ADF_HC_execute) exitWith {}; // Autodetect: execute on the HC else execute on the server

// Airport Pax Defence
for "_i" from 1 to 3 do {
	private ["_spawnPos"];
	_spawnPos = format ["mAirport_%1",_i];
	_g = [getMarkerPos _spawnPos, EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	[_g, getMarkerPos _spawnPos, 50, 1, true] call CBA_fnc_taskDefend;
};

for "_i" from 1 to 2 do {
	_g = [getMarkerPos "mCSAT_base_2", EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	[_g, getMarkerPos "mCSAT_base_2", 150, 3, "MOVE", "SAFE", "YELLOW", "LIMITED", "COLUMN", "", [2,15,30]] call CBA_fnc_taskPatrol;
};

for "_i" from 10 to 12 do {
	private ["_spawnPos"];
	_spawnPos = format ["mAirport_%1",_i];
	_g = [getMarkerPos _spawnPos, EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	[_g, getMarkerPos _spawnPos, 300, 5, "MOVE", "SAFE", "YELLOW", "LIMITED", "COLUMN", "", [1,2,3]] call CBA_fnc_taskPatrol;
};

// Static
_g = CreateGroup EAST; 
_p = _g createUnit ["O_crew_F", getMarkerPos "mCSAT_base_2", [], 0, "SERGEANT"]; _p moveInGunner vCSAT_apt_AA;
_p = _g createUnit ["O_Soldier_F", getMarkerPos "mCSAT_base_2", [], 0, "PRIVATE"]; _p moveInGunner vCSAT_stat_2;
