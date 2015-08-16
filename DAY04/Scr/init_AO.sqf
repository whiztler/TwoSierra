// init
call compile preprocessFileLineNumbers "scr\ADF_redress_NRF.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_Pashtun.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";

// Reinforcement vehicles
{_x hideObject true; _x enableSimulationGlobal true;} forEach [vOpforAPC_1,vOpforAPC_2,vOpforAPC_3];

// NRF LMAB
{{[_x] call ADF_fnc_redressNRF} forEach units _x} forEach [gNRF_static,gNRF_patrol_1,gNRF_patrol_2];

gNRF_static_u1 moveInGunner oStat_01;
gNRF_static_u2 moveInGunner oStat_02;

{_x enableSimulationGlobal false;} forEach units gNRF_static;
{[_x, position leader _x, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "", "", [1,2,3]] call CBA_fnc_taskPatrol;} forEach [gNRF_patrol_1,gNRF_patrol_2];

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

_ADF_vehPool = {
	_vPoolArray = ["I_G_Offroad_01_armed_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","O_APC_Wheeled_02_rcws_F"] call BIS_fnc_selectRandom;
	_vPoolArray;
};

// Random vehicle patrols
for "_i" from 1 to 5 do {
	private ["_spawnPos","_spawnDir","_v","_cX","_vX","_vp"];
	_spawnPos	= format ["mGuerVeh_%1",_i];
	_spawnDir	= markerDir _spawnPos;
	_vp			= call _ADF_vehPool;

	_c = createGroup INDEPENDENT;
	_v = [getMarkerPos _spawnPos, _spawnDir, _vp, _c] call BIS_fnc_spawnVehicle;
	_cX = units _c; {[_x] call ADF_fnc_redressPashtun} forEach _cX;	
	_vX = _v select 0;
	
	_vX setVariable ["BIS_enableRandomization", false];
	if (_vp == "I_G_Offroad_01_armed_F") then {
		[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
	} else {
		_vX setObjectTextureGlobal [0, "Img\NRF_cusTex_pashtun.jpg"];
		_vX setObjectTextureGlobal [2, "Img\NRF_cusTex_pashtun.jpg"];
	};
	
	[_c, _spawnPos, 2000, 4, "MOVE", "SAFE", "RED", "LIMITED",25] call ADF_fnc_vehiclePatrol;
};

// AO Defence Fire Team
for "_i" from 1 to 12 do {
	private ["_g","_gX","_spawnPos"];
	_spawnPos = format ["mGuerPaxDef_%1",_i];
	_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
	_gX = units _g; {[_x] call ADF_fnc_redressPashtun} forEach _gX;
	[_g, getMarkerPos _spawnPos, 75, 2, true] call CBA_fnc_taskDefend;	
};

// AO Defence Squad
for "_i" from 20 to 21 do {
	private ["_g","_gX","_spawnPos"];
	_spawnPos = format ["mGuerPaxDef_%1",_i];
	_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
	_gX = units _g; {[_x] call ADF_fnc_redressPashtun} forEach _gX;
	[_g, getMarkerPos _spawnPos, 125, 1, true] call CBA_fnc_taskDefend;	
};

// Create the Pashtn base of operations
execVM "Scr\SOD_BOP.sqf";

// Count units for reporting
_ADF_OpforCnt = {(side _x == INDEPENDENT) && (alive _x)} count allUnits;

diag_log	"-----------------------------------------------------";
diag_log format ["TWO SIERRA: AO (excl Opfor Base) spawned. Number of OpFor: %1",_ADF_OpforCnt];
diag_log	"-----------------------------------------------------";