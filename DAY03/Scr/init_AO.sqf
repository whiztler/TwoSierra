diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

private "_i";
// Random vehicle patrols
for "_i" from 1 to 5 do {
	private ["_p", "_d", "_c", "_v"];
	_p 	= format ["mGuerVeh_%1",_i];
	_d	= markerDir _p;
	_p	= getMarkerPos _p;

	_c = createGroup independent;
	_v = [_p, _d, "I_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressPashtun} forEach units _c;
	
	_v = _v select 0;
	_v setVariable ["BIS_enableRandomization", false];
	[_v, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
	[_c, _p, 2500, 4, "MOVE", "SAFE", "RED", "LIMITED",25] call ADF_fnc_vehiclePatrol;
};

// AO Defence Fire Team
for "_i" from 1 to 12 do {
	private ["_g", "_p"];
	_p 	= format ["mGuerPaxDef_%1",_i];
	_p	= getMarkerPos _p;
	
	_g = [_p, independent, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	[_g, _p, 150, 2, true] call ADF_fnc_defendArea;
};

// AO Defence Squad
for "_i" from 20 to 25 do {
	private ["_g", "_p"];
	_p	= format ["mGuerPaxDef_%1",_i];
	_p	= getMarkerPos _p;
	
	_g = [_p, independent, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	[_g, _p, 150, 2, true] call ADF_fnc_defendArea;

};

// Foot patrols
for "_i" from 1 to 6 do {
	private ["_g", "_p"];
	_p	= format ["mGuerPatrol_%1", _i];
	_p	= getMarkerPos _p;
	
	_g = [_p, independent, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	[_g, _p, 750, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

if (!isNil "tStart") then {deleteVehicle tStart};

private ["_opforCntWin", "_ADF_OpforCnt"];
// Count units/track time for win/loose scenario
_ADF_OpforCnt = {side _x == independent} count allUnits;
_opforCntWin = round ((_ADF_OpforCnt / 7) + (random 10));

diag_log	"-----------------------------------------------------";
diag_log format ["TWO SIERRA: AO spawned. Number of OpFor: %1", _ADF_OpforCnt];
diag_log format ["TWO SIERRA: Success mission OpFor count: %1", _opforCntWin];
diag_log	"-----------------------------------------------------";

ADF_init_AO = true; publicVariable "ADF_init_AO";

waitUntil {
	sleep 30;
	private "_c";
	_c = {side _x == independent} count allUnits;
	((_c < _opforCntWin) || (time > (ADF_missionStartTime + 7200))); // 2 hours + prep time
};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: End Mission process started";
diag_log	"-----------------------------------------------------";

ADF_endMission = true; publicVariable "ADF_endMission";



