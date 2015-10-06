if (!isServer) exitWith {};

// Mosque SAD
// init
params ["_ADF_SOD_spawnCity"];
private ["_ADF_SOD_mStart","_ADF_SOD_mEnd","_ADF_SOD_sadPos"];
_ADF_SOD_mStart	= 0;
_ADF_SOD_mEnd		= 0;
_ADF_SOD_sadPos	= [];

if (_ADF_SOD_spawnCity == "nagara") then {
	_ADF_SOD_mStart = 30;
	_ADF_SOD_mEnd = 34;
	_ADF_SOD_sadPos = getPos tMosque_1;
};
if (_ADF_SOD_spawnCity == "nur") then {
	_ADF_SOD_mStart = 40;
	_ADF_SOD_mEnd = 44;
	_ADF_SOD_sadPos = getPos tMosque_2;
};

for "_i" from _ADF_SOD_mStart to _ADF_SOD_mEnd do {
	private ["_spawnPos","_wp","_g"];
	_spawnPos = format ["mGuerPaxDef_%1",_i];
	
	_g = [getMarkerPos _spawnPos, EAST, (configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	_wp = _g addWaypoint [_ADF_SOD_sadPos, 0];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "FULL";
};

if (_ADF_SOD_spawnCity == "nagara") then {deleteVehicle tMosque_1} else {deleteVehicle tMosque_2};







