if (!isServer) exitWith {};

// Mosque SAD
for "_i" from 30 to 34 do {
	private ["_spawnPos","_wp"];
	_spawnPos	= format ["mGuerPaxDef_%1",_i];
	
	_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	_wp = _g addWaypoint [getPos tMosque, 0];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "FULL";
};

private ["_spawnPos","_spawnDir","_v","_vX"];
_spawnPos = "mGuerVeh_40";
_spawnDir = markerDir _spawnPos;

_c = createGroup INDEPENDENT;
_v = [getMarkerPos _spawnPos, _spawnDir, "I_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
{[_x] call ADF_fnc_redressPashtun} forEach units _c;
_vX = _v select 0;
[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;

_wp = _c addWaypoint [getPos tMosque, 0];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";

deleteVehicle tMosque;

