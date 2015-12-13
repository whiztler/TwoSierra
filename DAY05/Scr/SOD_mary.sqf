// Foot patrols around Mary
for "_i" from 1 to 4 do {
	private ["_g","_spawnPos","_r","_w"];
	_spawnPos = getMarkerPos ADF_maryLoc;
	_r = ((random 300) + (random 300));
	_w = [3,4,5] call BIS_fnc_selectRandom;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;

	[_g, _spawnPos, _r, _w, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};