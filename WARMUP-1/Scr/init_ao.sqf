call compile preprocessFileLineNumbers "Scr\ADF_redress_Pashtun.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";

// Spawn static Marid
_maridSpawnLoc = ["mMarid_1","mMarid_2","mMarid_3","mMarid_4","mMarid_5"] call BIS_fnc_selectRandom;
_v = [getMarkerPos _maridSpawnLoc, markerDir _maridSpawnLoc, "O_APC_Wheeled_02_rcws_F", INDEPENDENT] call BIS_fnc_spawnVehicle;
_vMadrid = _v select 0;
_vMadrid setObjectTextureGlobal [0, "Img\NRF_cusTex_pashtun.jpg"]; _vMadrid setObjectTextureGlobal [2, "Img\NRF_cusTex_pashtun.jpg"];

_g = CreateGroup INDEPENDENT; 
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mOpforSpawn", [], 0, "PRIVATE"]; _p moveInGunner oStat_1; 
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mOpforSpawn", [], 0, "PRIVATE"]; _p moveInGunner oStat_2;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mOpforSpawn", [], 0, "PRIVATE"]; _p moveInGunner oStat_3;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mOpforSpawn", [], 0, "PRIVATE"]; _p moveInGunner oStat_4;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mOpforSpawn", [], 0, "PRIVATE"]; _p moveInGunner oStat_5;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mOpforSpawn", [], 0, "PRIVATE"]; _p moveInGunner oStat_6;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mOpforSpawn", [], 0, "PRIVATE"]; _p moveInGunner oStat_7;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mOpforSpawn", [], 0, "PRIVATE"]; _p moveInGunner oStat_8; 
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mOpforSpawn", [], 0, "PRIVATE"]; _p moveInGunner oStat_9;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mOpforSpawn", [], 0, "PRIVATE"]; _p moveInGunner oStat_10;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mOpforSpawn", [], 0, "PRIVATE"]; _p moveInGunner oStat_11;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mOpforSpawn", [], 0, "PRIVATE"]; _p moveInGunner oStat_12;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mOpforSpawn", [], 0, "PRIVATE"]; _p moveInGunner oStat_13;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mOpforSpawn", [], 0, "PRIVATE"]; _p moveInGunner oStat_14;
_p = _g createUnit ["I_Soldier_F", getMarkerPos "mOpforSpawn", [], 0, "PRIVATE"]; _p moveInGunner _vMadrid;
_gX = units _g; {[_x] call ADF_fnc_redressPashtun} forEach _gX;

_ADF_vehPool = {
	_vPoolArray = ["I_G_Offroad_01_armed_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","I_G_Offroad_01_armed_F","O_APC_Wheeled_02_rcws_F","I_G_Offroad_01_armed_F"] call BIS_fnc_selectRandom;
	_vPoolArray;
};

// AO Defence Squad
for "_i" from 1 to 9 do {
	private ["_g","_spawnPos"];
	_spawnPos = format ["mGuerPaxDef_%1",_i];
	_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	[_g, getMarkerPos _spawnPos, 125, 1, true] call CBA_fnc_taskDefend;	
};

sleep 20; // let the defence teams settle in ese the vehicles will overrun them

// Vehicle patrols
for "_i" from 1 to 5 do {
	private ["_spawnPos","_spawnDir","_v","_vX"];
	_spawnPos 	= format ["mGuerVeh_%1",_i];
	_spawnDir 	= markerDir _spawnPos;
	_vp			= call _ADF_vehPool;

	_c = createGroup INDEPENDENT;
	_v = [getMarkerPos _spawnPos, _spawnDir, _vp, _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressPashtun} forEach units _c;
	_vX = _v select 0;

	_vX setVariable ["BIS_enableRandomization", false];
	if (_vp == "I_G_Offroad_01_armed_F") then {
		[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
	} else {
		_vX setObjectTextureGlobal [0, "Img\NRF_cusTex_pashtun.jpg"];
		_vX setObjectTextureGlobal [2, "Img\NRF_cusTex_pashtun.jpg"];
	};
	
	[_c, _spawnPos, 300, 5, "MOVE", "SAFE", "RED", "LIMITED",10] call ADF_fnc_vehiclePatrol;
};

// foot patrols
for "_i" from 2 to 9 do {
	private ["_spawnPos","_g"];
	_spawnPos = getMarkerPos "mOpforSpawn";

	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	[_g, _spawnPos, 225, 4, "MOVE", "SAFE", "RED", "LIMITED", "", "", [0,0,0]] call CBA_fnc_taskPatrol;
};

_opforCntWin = 5;

// Count and track alive OpFor
waitUntil {
	sleep 60;
	_cnt = {(side _x == INDEPENDENT) && (alive _x)} count allUnits;
	if (ADF_debug) then {systemChat format ["TWO SIERRA debug: Opfor remaining: %1",_cnt];};
	_cnt <= _opforCntWin
};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: End Mission process started";
diag_log	"-----------------------------------------------------";

ADF_endMission = true; publicVariable "ADF_endMission";