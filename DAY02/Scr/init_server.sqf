diag_log "ADF RPT: Init - executing Scr\init_server.sqf"; // Reporting. Do NOT edit/remove

call compile preprocessFileLineNumbers "Core\F\ADF_fnc_position.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_distance.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_defendArea.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_footPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createIED.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_Aegis.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_Pashtun.sqf";

foggyBottom = [.30,0,0];	
publicVariable "foggyBottom";
0 setFog foggyBottom;
forceWeatherChange;

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
[medFacil] execVM "Core\C\ADF_vCargo_B_TruckMedi.sqf"; 
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD,MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA,MRAP_2_1_BRAVO,MRAP_2_2_ALPHA,MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1,MRAP_2_3_WT2];

///// AEGIS

// Redress Aegis units
{{[_x] call ADF_fnc_redressAegis} forEach units _x} forEach [gAegis_1,gAegis_2,gAegis_3,gAegis_4,gAegis_5,gAegis_6,gAegis_10];

// (Static) defences airport
uAegis_g1_1 moveInGunner sApt_1;
uAegis_g1_2 moveInGunner sApt_2;
uAegis_g1_3 moveInGunner sApt_3;
uAegis_g1_4 moveInGunner sApt_4;

_defArr = [gAegis_2, getMarkerPos "mAegisText_1", 50, 1, true];
_defArr call ADF_fnc_defendArea;
gAegis_2 setVariable ["ADF_HC_garrison_ADF",true];
gAegis_2 setVariable ["ADF_HC_garrisonArr",_defArr];

// Oil Storage Facility defence
_defArr = [gAegis_4, getMarkerPos "mAegisText_1", 50, 1, true];
_defArr call ADF_fnc_defendArea;
gAegis_4 setVariable ["ADF_HC_garrison_ADF",true];
gAegis_4 setVariable ["ADF_HC_garrisonArr",_defArr];

// Checkpoint defence
uAegis_g5_1 moveInGunner sCP_1;
uAegis_g5_2 moveInGunner sCP_2;

// Airport patrols
[gAegis_3,  getMarkerPos "mAegisText_1", 150, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
[gAegis_6,  getMarkerPos "mAegisText_1", 150, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;

private ["_mmObjArray"];
_mmObjArray = [
"Land_fortified_nest_big",
"Land_fortified_nest_small_EP1",
"Land_Fort_Watchtower_EP1",
"Land_HBarrier_large",
"Land_HBarrier_5_F",
"Land_HBarrier_3_F",
"US_WarfareBFieldhHospital_Base_EP1",
"US_WarfareBBarracks_Base_EP1",
"Land_Barrack2_EP1",
"StorageBladder_01_fuel_sand_F",
"Land_Ind_TankSmall2_EP1",
"PowGen_Big_EP1",
"US_WarfareBVehicleServicePoint_Base_EP1",
"US_WarfareBUAVterminal_Base_EP1",
"Land_CncBarrier_stripes_F"
];

// Obj Map markerAlpha
[_mmObjArray,	"mAegisCP",75] call ADF_fnc_objectMarker;
[_mmObjArray,	"mAegisText_1",300] call ADF_fnc_objectMarker;

// Re-create critical markers
{[_x] call ADF_fnc_reMarker} forEach ["mAegisHQ","mAegisFort_1","mAegisFort","mAegisMed","mAegisFort_2","mAegisFort_3","mVehRepair"];

///// PASHTUN

// Airport assault forces

ADF_fnc_TargetRandom = {
	private ["_return","_p"];
	_p		= getMarkerPos "mAegisText_1";
	_return	= [_p, 600, random 360] call ADF_fnc_randomPos;  
	_return
};

[] spawn {
	private ["_assaultTimer","_opforCnt","_opforCntWin","_assaultStartTime"];
	// Init
	_assaultTimer			= [600,700,800,900,1000,1100,1200] call BIS_fnc_selectRandom;
	_assaultTimer 		= _assaultTimer - (random floor 300);
	_assaultTimer			= round _assaultTimer;
	_opforCnt			= 0;
	_opforCntWin			= 0;
	ADF_vehSpawnCnt		= 0;	
	ADF_assaultLine1		= false;
	ADF_assaultLine2		= false;
	ADF_assaultLine3		= false;
	ADF_redZoneOpforCnt	= 0;

	diag_log	"-----------------------------------------------------";
	diag_log format ["TWO SIERRA: Pashtun assault timer: %1 min",round (_assaultTimer/60)];
	diag_log	"-----------------------------------------------------";
	
	ADF_mots_assaultTimer = (_assaultTimer + 510); publicVariable "ADF_mots_assaultTimer"; // MOTS

	// Wait till the timer runs out
	if (ADF_debug) then {_assaultTimer = 45};
	while {(_assaultTimer != 1) && !(triggerActivated tShapur1 || triggerActivated tShapur2)} do {
		_assaultTimer = _assaultTimer - 1;
		uiSleep 1;
		//hintSilent str _assaultTimer;
	};
	
	_assaultStartTime = time;
	diag_log	"-----------------------------------------------------";
	diag_log "TWO SIERRA: Pashtun assault started";
	diag_log	"-----------------------------------------------------";
	
	// Simulated mortar assault
	[] spawn {
		private ["_TargetCount"];
		sleep ((random 60) + (random 60));
		_TargetCount	= [8,10,12,14,16,18,22,30] call BIS_fnc_selectRandom;
		
		for "_i" from 0 to _TargetCount do {
			private ["_return","_mortar"];
			_return = call ADF_fnc_TargetRandom;
			_mortar = createVehicle ["M_Mo_82mm_AT_LG", _return, [], 0, "NONE"];
			sleep (random 5);
		};
	};
	
	// Infantry assault groups
	[] spawn {
		for "_i" from 0 to 2 do {
			private ["_spawnPos","_g","_wp","_spawnPause"];
			_spawnPos = "mGueAssaultLine1_1";
			
			_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
			{[_x] call ADF_fnc_redressPashtun} forEach units _g;
			
			_wp = _g addWaypoint [getMarkerPos "mGueAssaultLine1_2", 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
			_wp = _g addWaypoint [getMarkerPos "mAegisText_1", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "COMBAT"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "RED";
			
			_spawnPause = [15,30,45,60,90,120] call BIS_fnc_selectRandom;
			sleep _spawnPause;
			ADF_vehSpawnCnt = ADF_vehSpawnCnt + _spawnPause;
		};
		ADF_assaultLine1 = true;
	};
	[] spawn {
		for "_i" from 0 to 2 do {
			private ["_spawnPos","_g","_wp","_spawnPause"];
			_spawnPos = "mGueAssaultLine3_1";
			
			_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
			{[_x] call ADF_fnc_redressPashtun} forEach units _g;
			
			_wp = _g addWaypoint [getMarkerPos "mGueAssaultLine3_2", 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
			_wp = _g addWaypoint [getMarkerPos "mAegisText_1", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "COMBAT"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "RED";
			
			_spawnPause = [15,30,45,60,90,120] call BIS_fnc_selectRandom;
			sleep _spawnPause;
			ADF_vehSpawnCnt = ADF_vehSpawnCnt + _spawnPause;
		};
		ADF_assaultLine3 = true;
	};
	[] spawn {
		sleep 70;
		for "_i" from 0 to 2 do {
			private ["_spawnPos","_g","_wp","_spawnPause"];
			_spawnPos = "mGueAssaultLine2_1";
			
			_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad_Weapons")] call BIS_fnc_spawnGroup;
			{[_x] call ADF_fnc_redressPashtun} forEach units _g;
			
			_wp = _g addWaypoint [getMarkerPos "mGueAssaultLine2_2", 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
			_wp = _g addWaypoint [getMarkerPos "mAegisText_1", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "COMBAT"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "RED";
			
			_spawnPause = [15,30,45,60,90,120] call BIS_fnc_selectRandom;
			sleep _spawnPause;
			ADF_vehSpawnCnt = ADF_vehSpawnCnt + _spawnPause;
		};
		ADF_assaultLine2 = true;
	};
	
	// Victor Assault groups
	waitUntil {ADF_assaultLine1 && ADF_assaultLine3}; // Wait till all Pashtun infantry has spawned
	
	diag_log	"-----------------------------------------------------";
	diag_log format ["TWO SIERRA: Pashtun vehicle spawn timer: %1",(ADF_vehSpawnCnt/3)];
	diag_log	"-----------------------------------------------------";
	sleep (ADF_vehSpawnCnt/3); // Pashtun victor assault force spawns xx min after the infantry assault	
	
	ADF_fnc_PashtunVehAssault = {
		params ["_line","_vType"];
		private ["_spawnPos","_spawnDir","_c","_wp"];
		
		_spawnPos	= format ["mGueAssaultLine%1_1",_line];
		_wpPos		= format ["mGueAssaultLine%1_2",_line];
		_spawnDir	= markerDir _spawnPos;
		_spawnPos	= getMarkerPos _spawnPos;	
		
		
		_c = createGroup INDEPENDENT;
		_v = [_spawnPos, _spawnDir, _vType, _c] call BIS_fnc_spawnVehicle;
		{[_x] call ADF_fnc_redressPashtun} forEach units _c;
		_vX = _v select 0;
		_vX setVariable ["BIS_enableRandomization", false];
		[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
		
		_wp = _c addWaypoint [getMarkerPos _wpPos, 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
		_wp = _c addWaypoint [getMarkerPos "mAegisText_1", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "COMBAT"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "RED";
		true
	};
	
	ADF_fnc_PashtunArmVehAssault = {
		params ["_line","_v"];
		private ["_c","_wp","_wpPos"];		
		_wpPos = format ["mGueAssaultLine%1_2",_line];
		
		_c = CreateGroup INDEPENDENT; 
		_p = _c createUnit ["I_Crew_F", getMarkerPos "mPashtunSpawn", [], 0, "LIEUTENANT"]; _p moveInCommander _v;
		_p = _c createUnit ["I_Crew_F", getMarkerPos "mPashtunSpawn", [], 0, "SERGEANT"]; _p moveInGunner _v;
		_p = _c createUnit ["I_Crew_F", getMarkerPos "mPashtunSpawn", [], 0, "CORPORAL"]; _p moveInDriver _v;
		{[_x] call ADF_fnc_redressPashtun} forEach units _c;
		
		_wp = _c addWaypoint [getMarkerPos _wpPos, 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
		_wp = _c addWaypoint [getMarkerPos "mAegisText_1", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "COMBAT"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "RED";
		true
	};

	for "_i" from 1 to 2 do {
		[1,"I_G_Offroad_01_armed_F"] call ADF_fnc_PashtunVehAssault; sleep 5;
		[3,"I_G_Offroad_01_armed_F"] call ADF_fnc_PashtunVehAssault; sleep 25;
		[2,"I_G_Offroad_01_armed_F"] call ADF_fnc_PashtunVehAssault;
	};
	
	sleep ((random floor 200) + (random floor 200)); // Pause before activating the APC's
			
	// Activate APC's / IFV's
	[1,vOpforAPC_1] call ADF_fnc_PashtunArmVehAssault; sleep 2;
	[3,vOpforAPC_2] call ADF_fnc_PashtunArmVehAssault; sleep 2;
	[2,vOpforAPC_3] call ADF_fnc_PashtunArmVehAssault;
	
	// Count spawned Opfor
	_opforCnt = {(side _x == INDEPENDENT) && (alive _x)} count allUnits;
	if (ADF_pashtunAOtriggered) then {_opforCnt = _opforCnt - ADF_redZoneOpforCnt;}; // Redzone was triggered, Deduct units from assault force
	_opforCntWin = (_opforCnt / 9) + (random 15);
	
	diag_log	"-----------------------------------------------------";
	diag_log format ["TWO SIERRA: Pashtun spawned: %1",_opforCnt];
	diag_log format ["TWO SIERRA: Opfor Win count: %1",_opforCntWin];
	diag_log	"-----------------------------------------------------";
	
	// Track Opfor count for win scenario
	waitUntil {
		sleep 15;
		_opforCnt = {(side _x == INDEPENDENT) && (alive _x)} count allUnits;
		if (ADF_pashtunAOtriggered) then {_opforCnt = _opforCnt - ADF_redZoneOpforCnt;};
		((_opforCnt < _opforCntWin) || (time > 7200));
	};
	
	_assaultEndTime = time;
	
	ADF_pashtunWaveClear = true; publicVariable "ADF_pashtunWaveClear";
	
	// Reporting
	diag_log			"-----------------------------------------------------";
	diag_log format ["TWO SIERRA: Assault waved cleared, %1 pax left",round _opforCntWin];
	diag_log format ["TWO SIERRA: Time needed to defeat the assault: %1 mins",round ((_assaultStartTime - _assaultEndTime)/60)];
	diag_log			"-----------------------------------------------------";
}; // close spawn


// Pashtun RedZone defences
waitUntil {sleep 3; triggerActivated tShapur1 || triggerActivated tShapur2};
ADF_pashtunAOtriggered = true; publicVariable "ADF_pashtunAOtriggered";
if !(isNil "tShapur1") then {deleteVehicle tShapur1};
if !(isNil "tShapur2") then {deleteVehicle tShapur2};
// Reporting
diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Red Zone trigger activated";
diag_log	"-----------------------------------------------------";

// Static Vehicles/MG/AT/etc
private ["_g","_p","_m"];
_g = CreateGroup INDEPENDENT; 
_m = getMarkerPos "mPashtunSpawn";
_p = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _p moveInGunner vOpfor_01; // 50 cal offroad 1
_p = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _p moveInGunner vOpfor_02; // 50 cal offroad 2
_p = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _p moveInGunner vOpfor_03; // 50 cal offroad 3
_p = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _p moveInGunner vOpfor_04; // 50 cal offroad 4
_p = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_01; // Mortar 1
_p = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_02; // Mortar 2
_p = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_03; // AT 1
_p = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_04; // AT 2
_p = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_05; // GMG 1
_p = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_06; // GMG 2
_p = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_07; // AT 3
_p = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_08; // MG 1
{[_x] call ADF_fnc_redressPashtun} forEach units _g;

// Defence groups (FT's)
for "_i" from 1 to 4 do {
	private ["_g","_spawnPos","_defArr"];
	_spawnPos	= format ["mGuerPaxDef_%1",_i];
	_spawnPos	= getMarkerPos _spawnPos;
	
	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	_defArr = [_g, _spawnPos, 100, 1, true];
	_defArr call ADF_fnc_defendArea;
	_g setVariable ["ADF_HC_garrison_ADF",true];
	_g setVariable ["ADF_HC_garrisonArr",_defArr];
};

// Defence groups (Sentries)
for "_i" from 10 to 20 do {
	private ["_g","_spawnPos","_defArr"];
	_spawnPos 	= format ["mGuerPaxDef_%1",_i];
	_spawnPos	= getMarkerPos _spawnPos;
	
	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	_defArr = [_g, _spawnPos, 50, 2, true];
	_defArr call ADF_fnc_defendArea;
	_g setVariable ["ADF_HC_garrison_ADF",true];
	_g setVariable ["ADF_HC_garrisonArr",_defArr];
};

// Foot patrols
for "_i" from 1 to 6 do {
	private ["_g","_spawnPos"];
	_spawnPos	= format ["mGuerFootPatrol_%1",_i];
	_spawnPos	= getMarkerPos _spawnPos;
	
	_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	[_g, _spawnPos, 400, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

// Count & track spawned units for win/loose scenario
_redZoneRadius = nearestObjects [getMarkerPos "mJonahRadius", ["Man"], 750]; // 750m ex marker
ADF_redZoneOpforCnt = {(side _x == INDEPENDENT) && (alive _x)} count _redZoneRadius;
_opforCntWinAO = (ADF_redZoneOpforCnt / 10) + (random 10);

diag_log	"-----------------------------------------------------";
diag_log format ["TWO SIERRA: AO OpFor spawned, number of Opfor: %1",ADF_redZoneOpforCnt];
diag_log format ["TWO SIERRA: AO OpFor success mission count: %1",_opforCntWinAO];
diag_log	"-----------------------------------------------------";

waitUntil {
	sleep 30;
	_redZoneRadius = nearestObjects [getMarkerPos "mJonahRadius", ["Man"], 750]; // 750m ex marker
	ADF_redZoneOpforCnt = {(side _x == INDEPENDENT) && (alive _x)} count _redZoneRadius;
	((ADF_redZoneOpforCnt <= _opforCntWinAO) || (time > 10800)); // 3 hours
};

// End mission
if (ADF_redZoneOpforCnt < _opforCntWinAO) then {ADF_SatanControl = true; publicVariable "ADF_SatanControl";};
ADF_SatanClearUp = true; publicVariable "ADF_SatanClearUp";