if (hasInterface) then {

};

if (!ADF_HC_execute) exitWith {};

// Counter Fireteams
for "_i" from 1 to 2 do {
	private ["_g","_maryPos","_rX","_rY"];
	_maryPos = getMarkerPos ADF_maryLoc;
	_rX = 100 + (random 250);
	_rY = 100 + (random 300); 
	_spawnPos = [(_maryPos select 0) + _rX,(_maryPos select 1) + _rY,0];
	_g = [ _spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	//{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	_wp = _g addWaypoint [_maryPos, 0];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "FAST";
};
/*
// Counter Vehicles
for "_i" from 1 to 2 do {
	private ["_g","_maryPos","_rX","_rY"];
	_maryPos = getMarkerPos ADF_maryLoc;
	_rX = random 100;
	_rY = random 150; 
	_spawnPos = [(_maryPos select 0) + _rX,(_maryPos select 1) + _rY,0];
	_g = [ _spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	//{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	_wp = _g addWaypoint [_maryPos, 0];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "FAST";
};