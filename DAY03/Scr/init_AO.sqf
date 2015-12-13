waitUntil {sleep 10; triggerActivated tStart || time > 1250};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

ADF_missionStartTime = time;

// Random vehicle patrols
for "_i" from 1 to 5 do {
	private ["_spawnPos","_spawnDir","_c","_v","_vX"];
	_spawnPos 	= format ["mGuerVeh_%1",_i];
	_spawnDir	= markerDir _spawnPos;
	_spawnPos	= getMarkerPos _spawnPos;

	_c = createGroup INDEPENDENT;
	_v = [_spawnPos, _spawnDir, "I_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressPashtun} forEach units _c;
	
	_vX = _v select 0;
	_vX setVariable ["BIS_enableRandomization", false];
	[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
	[_c, _spawnPos, 2500, 4, "MOVE", "SAFE", "RED", "LIMITED",25] call ADF_fnc_vehiclePatrol;
};

// AO Defence Fire Team
for "_i" from 1 to 12 do {
	private ["_g","_spawnPos","_defArr"];
	_spawnPos 	= format ["mGuerPaxDef_%1",_i];
	_spawnPos	= getMarkerPos _spawnPos;
	
	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	_defArr = [_g, _spawnPos, 150, 2, true];
	_defArr call ADF_fnc_defendArea;
};

// AO Defence Squad
for "_i" from 20 to 25 do {
	private ["_g","_spawnPos","_defArr"];
	_spawnPos	= format ["mGuerPaxDef_%1",_i];
	_spawnPos	= getMarkerPos _spawnPos;
	
	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	_defArr = [_g, _spawnPos, 150, 2, true];
	_defArr call ADF_fnc_defendArea;

};

// Foot patrols
for "_i" from 1 to 6 do {
	private ["_g","_spawnPos"];
	_spawnPos	= format ["mGuerPatrol_%1",_i];
	_spawnPos	= getMarkerPos _spawnPos;
	
	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	[_g, _spawnPos, 750, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

if (!isNil "tStart") then {deleteVehicle tStart};

private ["_opforCntWin","_ADF_missionTime"];
// Count units/track time for win/loose scenario
ADF_OpforCnt = {(side _x == INDEPENDENT) && (alive _x)} count allUnits;
_opforCntWin = round ((ADF_OpforCnt / 7) + (random 10));
_ADF_missionTime = ADF_missionStartTime + 7200;

diag_log	"-----------------------------------------------------";
diag_log format ["TWO SIERRA: AO spawned. Number of OpFor: %1",ADF_OpforCnt];
diag_log format ["TWO SIERRA: Success mission OpFor count: %1",_opforCntWin];
diag_log	"-----------------------------------------------------";

ADF_init_AO = true; publicVariable "ADF_init_AO";

waitUntil {
	sleep 30;
	_cnt = {(side _x == INDEPENDENT) && (alive _x)} count allUnits;
	((_cnt < _opforCntWin) || (time > _ADF_missionTime)); // 2 hours + prep time
};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: End Mission process started";
diag_log	"-----------------------------------------------------";

ADF_endMission = true; publicVariable "ADF_endMission";



