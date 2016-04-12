
///// PASHTUN

// Airport assault forces

ADF_fnc_TargetRandom = {
	private ["_return", "_p"];
	_p		= getMarkerPos "mAegisText_1";
	_return	= [_p, 600, random 360] call ADF_fnc_randomPos;  
	_return
};

[] spawn {
	private ["_t", "_cnt_AO", "_cnt_Win", "_at"];
	// Init
	_assaultTimer			= [600,700,800,900,1000,1100,1200] call BIS_fnc_selectRandom;
	_assaultTimer 		= _assaultTimer - (random floor 300);
	_assaultTimer			= round _assaultTimer;
	_cnt_AO			= 0;
	_cnt_Win			= 0;
	ADF_vehSpawnCnt		= 0;	
	ADF_assaultLine1		= false;
	ADF_assaultLine2		= false;
	ADF_assaultLine3		= false;
	ADF_redZoneOpforCnt	= 0;

	diag_log	"-----------------------------------------------------";
	diag_log format ["TWO SIERRA: Pashtun assault timer: %1 min", round (_assaultTimer/60)];
	diag_log	"-----------------------------------------------------";
	
	ADF_mots_assaultTimer = (_assaultTimer + 510); publicVariable "ADF_mots_assaultTimer"; // MOTS

	// Wait till the timer runs out
	if (ADF_debug) then {_assaultTimer = 45};
	while {(_assaultTimer != 1) && !(triggerActivated tShapur1 || triggerActivated tShapur2)} do {
		_assaultTimer = _assaultTimer - 1;
		uiSleep 1;
		if (MotsActive) exitWith {};
		//hintSilent str _assaultTimer;
	};
	
	private "_assaultStartTime";
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
			private ["_return", "_mortar"];
			_return = call ADF_fnc_TargetRandom;
			_mortar = createVehicle ["M_Mo_82mm_AT_LG", _return, [], 0, "NONE"];
			sleep (random 5);
		};
	};
	
	// Infantry assault groups
	[] spawn {
		for "_i" from 0 to 2 do {
			private ["_p", "_g", "_wp"];
			_p = "mGueAssaultLine1_1";
			
			_g = [getMarkerPos _p, independent, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
			{[_x] call ADF_fnc_redressPashtun} forEach units _g;
			
			_wp = _g addWaypoint [getMarkerPos "mGueAssaultLine1_2", 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
			_wp = _g addWaypoint [getMarkerPos "mAegisText_1", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "COMBAT"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "RED";
			
			sleep ([15,30,45,60,90,120] call BIS_fnc_selectRandom);
			ADF_vehSpawnCnt = ADF_vehSpawnCnt + _s;
		};
		ADF_assaultLine1 = true;
	};
	[] spawn {
		for "_i" from 0 to 2 do {
			private ["_p", "_g", "_wp", "_s"];
			_p = "mGueAssaultLine3_1";
			
			_g = [getMarkerPos _p, independent, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
			{[_x] call ADF_fnc_redressPashtun} forEach units _g;
			
			_wp = _g addWaypoint [getMarkerPos "mGueAssaultLine3_2", 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
			_wp = _g addWaypoint [getMarkerPos "mAegisText_1", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "COMBAT"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "RED";
			
			sleep ([15,30,45,60,90,120] call BIS_fnc_selectRandom);
			ADF_vehSpawnCnt = ADF_vehSpawnCnt + _s;
		};
		ADF_assaultLine3 = true;
	};
	[] spawn {
		sleep 70;
		for "_i" from 0 to 2 do {
			private ["_p", "_g", "_wp", "_s"];
			_p = "mGueAssaultLine2_1";
			
			_g = [getMarkerPos _p, independent, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad_Weapons")] call BIS_fnc_spawnGroup;
			{[_x] call ADF_fnc_redressPashtun} forEach units _g;
			
			_wp = _g addWaypoint [getMarkerPos "mGueAssaultLine2_2", 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
			_wp = _g addWaypoint [getMarkerPos "mAegisText_1", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "COMBAT"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "RED";
			
			sleep ([15,30,45,60,90,120] call BIS_fnc_selectRandom);
			ADF_vehSpawnCnt = ADF_vehSpawnCnt + _s;
		};
		ADF_assaultLine2 = true;
	};
	
	// Victor Assault groups
	waitUntil {ADF_assaultLine1 && ADF_assaultLine3}; // Wait till all Pashtun infantry has spawned
	
	diag_log	"-----------------------------------------------------";
	diag_log format ["TWO SIERRA: Pashtun vehicle spawn timer: %1",(ADF_vehSpawnCnt/3)];
	diag_log	"-----------------------------------------------------";
	sleep (ADF_vehSpawnCnt / 3); // Pashtun victor assault force spawns xx min after the infantry assault	
	
	ADF_fnc_PashtunVehAssault = {
		params ["_line", "_vType"];
		private ["_p", "_d", "_c", "_wp"];
		
		_p		= format ["mGueAssaultLine%1_1",_line];
		_wpPos	= format ["mGueAssaultLine%1_2",_line];
		_d		= markerDir _p;
		_p		= getMarkerPos _p;		
		
		_c = createGroup independent;
		_v = [_p, _d, _vType, _c] call BIS_fnc_spawnVehicle;
		
		{[_x] call ADF_fnc_redressPashtun} forEach units _c;
		_v = _v select 0;
		_v setVariable ["BIS_enableRandomization", false];
		[_v, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
		
		_wp = _c addWaypoint [getMarkerPos _wpPos, 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
		_wp = _c addWaypoint [getMarkerPos "mAegisText_1", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "COMBAT"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "RED";
		true
	};
	
	ADF_fnc_PashtunArmVehAssault = {
		params ["_line", "_v"];
		private ["_c", "_wp", "_wpPos"];		
		_wpPos = format ["mGueAssaultLine%1_2",_line];
		
		_c = createGroup independent; 
		_p = _c createUnit ["I_Crew_F", getMarkerPos "mPashtunSpawn", [], 0, "LIEUTENANT"]; _p moveInCommander _v;
		_p = _c createUnit ["I_Crew_F", getMarkerPos "mPashtunSpawn", [], 0, "SERGEANT"]; _p moveInGunner _v;
		_p = _c createUnit ["I_Crew_F", getMarkerPos "mPashtunSpawn", [], 0, "CORPORAL"]; _p moveInDriver _v;
		{[_x] call ADF_fnc_redressPashtun} forEach units _c;
		
		_wp = _c addWaypoint [getMarkerPos _wpPos, 0]; _wp setWaypointType "MOVE"; _wp setWaypointBehaviour "AWARE"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "RED"; _wp setWaypointCompletionRadius 25; 
		_wp = _c addWaypoint [getMarkerPos "mAegisText_1", 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "COMBAT"; _wp setWaypointSpeed "NORMAL"; _wp setWaypointCombatMode "RED";
		true
	};

	private "_i";
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
	private ["_cnt_AO", "_cnt_Win", "_assaultEndTime"];
	_cnt_AO = {side _x == independent} count allUnits;
	if (ADF_pashtunAOtriggered) then {_cnt_AO = _cnt_AO - ADF_redZoneOpforCnt;}; // Redzone was triggered, Deduct units from assault force
	_cnt_Win = (_cnt_AO / 9) + (random 15);
	
	diag_log	"-----------------------------------------------------";
	diag_log format ["TWO SIERRA: Pashtun spawned: %1",_cnt_AO];
	diag_log format ["TWO SIERRA: Opfor Win condition: < %1",_cnt_Win];
	diag_log	"-----------------------------------------------------";
	
	// Track Opfor count for win scenario
	waitUntil {
		sleep 15;
		_cnt_AO = {side _x == independent} count allUnits;
		if (ADF_pashtunAOtriggered) then {_cnt_AO = _cnt_AO - ADF_redZoneOpforCnt;};
		((_cnt_AO < _cnt_Win) || (time > 7200));
	};
	
	_assaultEndTime = time;
	
	ADF_pashtunWaveClear = true; publicVariable "ADF_pashtunWaveClear";
	
	// Reporting
	diag_log			"-----------------------------------------------------";
	diag_log format ["TWO SIERRA: Assault waved cleared, %1 pax left",round _cnt_Win];
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
private ["_g", "_u", "_m"];
_g = createGroup independent; 
_m = getMarkerPos "mPashtunSpawn";
_u = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _u moveInGunner vOpfor_01; // 50 cal offroad 1
_u = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _u moveInGunner vOpfor_02; // 50 cal offroad 2
_u = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _u moveInGunner vOpfor_03; // 50 cal offroad 3
_u = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _u moveInGunner vOpfor_04; // 50 cal offroad 4
_u = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _u moveInGunner sOpfor_01; // Mortar 1
_u = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _u moveInGunner sOpfor_02; // Mortar 2
_u = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _u moveInGunner sOpfor_03; // AT 1
_u = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _u moveInGunner sOpfor_04; // AT 2
_u = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _u moveInGunner sOpfor_05; // GMG 1
_u = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _u moveInGunner sOpfor_06; // GMG 2
_u = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _u moveInGunner sOpfor_07; // AT 3
_u = _g createUnit ["I_Soldier_F", _m, [], 0, "PRIVATE"]; _u moveInGunner sOpfor_08; // MG 1
{[_x] call ADF_fnc_redressPashtun} forEach units _g;

// Defence groups (FT's)
for "_i" from 1 to 4 do {
	private ["_g", "_p"];
	_p	= format ["mGuerPaxDef_%1",_i];
	_p	= getMarkerPos _p;
	
	_g = [_p, independent, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;

	[_g, _p, 100, 1, true] call ADF_fnc_defendArea;
};

// Defence groups (Sentries)
for "_i" from 10 to 20 do {
	private ["_g", "_p"];
	_p 	= format ["mGuerPaxDef_%1",_i];
	_p	= getMarkerPos _p;
	
	_g = [_p, independent, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;

	[_g, _p, 50, 2, true] call ADF_fnc_defendArea;
};

// Foot patrols
for "_i" from 1 to 6 do {
	private ["_g", "_p"];
	_p	= format ["mGuerFootPatrol_%1",_i];
	_p	= getMarkerPos _p;
	
	_g = [_p, independent, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	
	[_g, _p, 400, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

// Count & track spawned units for win/loose scenario
private "_cnt_Win";
ADF_redZoneOpforCnt = ["mJonahRadius", independent, 750, "MAN"] call ADF_fnc_countRadius;
_cnt_Win = (ADF_redZoneOpforCnt / 10) + (random 10);

diag_log	"-----------------------------------------------------";
diag_log format ["TWO SIERRA: AO OpFor spawned, number of Opfor: %1",ADF_redZoneOpforCnt];
diag_log format ["TWO SIERRA: AO OpFor success mission count: %1",_cnt_Win];
diag_log	"-----------------------------------------------------";

waitUntil {
	sleep 30;
	private "_c";
	_c = ["mJonahRadius", independent, 750, "MAN"] call ADF_fnc_countRadius;
	((_c <= _cnt_Win) || (time > 12800)); // 3,5 hours
};

// End mission
if (ADF_redZoneOpforCnt < _cnt_Win) then {ADF_SatanControl = true; publicVariable "ADF_SatanControl";};
ADF_SatanClearUp = true; publicVariable "ADF_SatanClearUp";

