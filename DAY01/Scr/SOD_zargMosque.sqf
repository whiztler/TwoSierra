// Run below scripts only on the HC or server
if (!ADF_HC_execute) exitWith {}; // Autodetect: execute on the HC else execute on the server

// Mosque SAD
for "_i" from 30 to 34 do {
	private ["_spawnPos","_wp"];
	_spawnPos	= format ["mGuerPaxDef_%1",_i];
	_g = [getMarkerPos _spawnPos, EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	_gX = units _g; {[_x] call ADF_fnc_redressPashtun} forEach _gX;
	_wp = _g addWaypoint [getPos tZargMosque, 0];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "FULL";
};

private ["_spawnPos","_spawnDir","_v","_cX","_vX"];
_spawnPos = "mGuerVeh_40";
_spawnDir = markerDir _spawnPos;
_c = createGroup INDEPENDENT;
_v = [getMarkerPos _spawnPos, _spawnDir, "I_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
_cX = units _c; {[_x] call ADF_fnc_redressPashtun} forEach _cX;
_vX = _v select 0;
[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
_wp = _c addWaypoint [getPos tZargMosque, 0];
_wp setWaypointType "SAD";
_wp setWaypointBehaviour "COMBAT";
_wp setWaypointSpeed "FULL";


