ADF_SOD_zones = {
	if (!ADF_HC_execute) exitWith {}; // HC Autodetect. If no HC present execute on the Server.
	// init
	params ["_t"];
	private ["_startMarker","_endMarker","_endMarkerVictors","_patrolsGrp","_garrisonGrp","_victorsVeh","_r","_patrolRad","_garrisonRad"];
	_r 				= ((triggerArea _t) select 0) / 2;
	_patrolRad		= _r / 1.2;
	_garrisonRad		= 250;
	_uCache			= [];
	_vCache			= [];

	_patrolsGrp 		= "OIA_InfSentry";
	_garrisonGrp		= "OIA_InfTeam";
	_victorsVeh		= "O_G_Offroad_01_armed_F";
	
	_startMarker		= 0;
	_endMarker		= 0;
	_redress			= ADF_fnc_redressRussian;
	_vSkin			= "ADF_rebelOffroad";

	///// Russian zones
	if (_t == tRusZone_1) then {_startMarker = 10; _endMarker = 15; _endMarkerVictors = 13; _redress = ADF_fnc_redressRussian; _vSkin = "ADF_russianOffroad";};
	if (_t == tRusZone_2) then {_startMarker = 20; _endMarker = 25; _endMarkerVictors = 23; _redress = ADF_fnc_redressRussian; _vSkin = "ADF_russianOffroad";};
	
	///// Rebel zones
	if (_t == tRebelZone_1) then {_startMarker = 50; _endMarker = 55; _endMarkerVictors = 53; _redress = ADF_fnc_redressRebel; _vSkin = "ADF_rebelOffroad";};
	if (_t == tRebelZone_2) then {_startMarker = 60; _endMarker = 65; _endMarkerVictors = 63; _redress = ADF_fnc_redressRebel; _vSkin = "ADF_rebelOffroad";};
	if (_t == tRebelZone_3) then {_startMarker = 70; _endMarker = 75; _endMarkerVictors = 73; _redress = ADF_fnc_redressRebel; _vSkin = "ADF_rebelOffroad";};

	// spawn/create groups

	for "_i" from _startMarker to _endMarker do {
		private ["_g","_spawnPos"];	
		_spawnPos = format ["mPaxPat_%1",_i];
		_g = [getMarkerPos _spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _patrolsGrp)] call BIS_fnc_spawnGroup;
		{[_x] call _redress} forEach units _g;
		[_g, getMarkerPos _spawnPos, _patrolRad, 4, "MOVE", "SAFE", "RED", "LIMITED", "", "", [0,0,0]] call CBA_fnc_taskPatrol;
	};
	for "_i" from _startMarker to _endMarker do {
		private ["_g","_spawnPos"];
		_spawnPos = format ["mPaxDef_%1",_i];
		_g = [getMarkerPos _spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _garrisonGrp)] call BIS_fnc_spawnGroup;
		{[_x] call _redress} forEach units _g;
		[_g, getMarkerPos _spawnPos, _garrisonRad, 2, true] call CBA_fnc_taskDefend;	
	};
	for "_i" from _startMarker to _endMarkerVictors do {
		private ["_spawnPos","_spawnDir","_v","_vX","_c"];
		_spawnPos = format ["mVehPat_%1",_i];
		_spawnDir = markerDir _spawnPos;		
		_c = createGroup EAST;
		_v = [getMarkerPos _spawnPos, _spawnDir, _victorsVeh, _c] call BIS_fnc_spawnVehicle;		
		{[_x] call _redress} forEach units _c;
		_vX = _v select 0;
		_vX setVariable ["BIS_enableRandomization", false];
		[_vX, _vSkin, nil] call bis_fnc_initVehicle;
		[_c, _spawnPos, 1000, 6, "MOVE", "SAFE", "RED", "LIMITED",25] call ADF_fnc_vehiclePatrol;
	};
};