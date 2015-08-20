// init
call compile preprocessFileLineNumbers "Scr\ADF_redress_Pashtun.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_fnc_createIED.sqf";

ADF_wpPosRdm = {
	private "_wpPos";
	_wpPos = ["mAirPos_1","mAirPos_2","mAirPos_3","mAirPos_4","mAirPos_5"] call BIS_fnc_selectRandom;
	_wpPos
};

[] spawn {
	sleep 25;
	while {true} do {
		private ["_c","_v","_wp","_heli","_startPos","_exitPos","_pause"];
		_pause = [300,600,900,1200,1800] call BIS_fnc_selectRandom;
		_startPos = call ADF_wpPosRdm;
		_exitPos = call ADF_wpPosRdm;
		_heli = "B_Heli_Transport_03_F";
		_landPos = [oLand_1,oLand_2] call BIS_fnc_selectRandom;		
		_c = createGroup WEST;
		_v = [getMarkerPos _startPos, 0, _heli, _c] call BIS_fnc_spawnVehicle;
		_c setGroupIdGlobal ["6-1 AIRBUS"];
		vAirbus = _v select 0;
		vAirbus setObjectTextureGlobal [0, "Img\NRF_cusTex_NRFcamo.jpg"]; vAirbus setObjectTextureGlobal [1, "Img\NRF_cusTex_NRFcamo.jpg"];		
		{_x unassignItem "NVGoggles"; _x removeItem "NVGoggles"; _x enableGunlights "forceOn";} forEach units _c;
		vAirbus flyInHeight 75;
		_wp = _c addWaypoint [getPos _landPos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "NORMAL";
		_wp setWaypointStatements ["true", "vAirbus land 'LAND';"];	
		waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
		waitUntil {isTouchingGround vAirbus};
		_pausePad = [60,120,180,240,300,600] call BIS_fnc_selectRandom;
		vAirbus setFuel 0;
		sleep _pausePad;
		vAirbus setFuel 1;	
		_wp = _c addWaypoint [getMarkerPos _exitPos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "NORMAL";
		waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
		sleep 2;
		if !(isNil "vAirbus") then {{deleteVehicle _x} forEach (crew vAirbus); deleteVehicle vAirbus; vAirbus = nil};
		sleep _pause;
	};
};

[] spawn {
	sleep 300;
	while {alive vGunship} do {
		private ["_c","_wp","_wpPos","_pausePad"];	
		_c = createGroup WEST;
		_p = _c createUnit ["B_helipilot_F", getMarkerPos "mLMAB",[],0,"LIEUTENANT"]; _p moveInDriver vGunship;
		_p = _c createUnit ["B_helipilot_F", getMarkerPos "mLMAB",[],0,"LIEUTENANT"]; _p moveInGunner vGunship;
		_c setGroupIdGlobal ["6-6 CONDOR"];
		vGunship flyInHeight 50;
		_wpPos = call ADF_wpPosRdm;
		_wp = _c addWaypoint [getMarkerPos _wpPos, 0];
		_wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "NORMAL";
		_wpPos = call ADF_wpPosRdm;
		_wp = _c addWaypoint [getMarkerPos _wpPos, 0]; _wp setWaypointType "MOVE";
		_wp = _c addWaypoint [getPos oGunshipPad, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "NORMAL";
		_wp setWaypointStatements ["true", "vGunship land 'LAND';"];		
		waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
		waitUntil {isTouchingGround vGunship};
		_pausePad = [300,600,900,1200] call BIS_fnc_selectRandom;
		vGunship setFuel 0;
		if !(isNil "vGunship") then {{deleteVehicle _x} forEach (crew vGunship);};
		vGunship setDir (getDir oGunshipPad);
		sleep _pausePad;
		vGunship setFuel 1;		
	};
};

// Create random IED's
_iedMarkerArr = ["mIED_1","mIED_2","mIED_3","mIED_4","mIED_5","mIED_6","mIED_7","mIED_8","mIED_9","mIED_10","mIED_11","mIED_12","mIED_13","mIED_14","mIED_15","mIED_16"];
for "_i" from 1 to 10 do {
	private ["_iedMarkerPos","_v","_mN","_m","_idx"];
	_iedMarkerPos = _iedMarkerArr call BIS_fnc_selectRandom;
	_idx =  _iedMarkerArr find _iedMarkerPos;
	_iedMarkerArr deleteAt _idx;
	[_iedMarkerPos,100,250] call ADF_fnc_createRandomIEDs;
};

// Dolphin vehicle
[vDolphin,0, 120] call bis_fnc_setpitchbank;
vDolphin setDamage .7;
vDolphin setHit ["wheel_1_2_steering", 1];
vDolphin setHit ["wheel_1_4_steering", 1];
vDolphin setHit ["wheel_1_1_steering", 1];

waitUntil {sleep 10; triggerActivated tStart};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

// Random vehicle patrols
for "_i" from 1 to 5 do {
	private ["_spawnPos","_spawnDir","_v","_vX"];
	_spawnPos = format ["mGuerVeh_%1",_i];
	_spawnDir = markerDir _spawnPos;

	_c = createGroup INDEPENDENT;
	_v = [getMarkerPos _spawnPos, _spawnDir, "I_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressPashtun} forEach units _c;
	_vX = _v select 0;
	_vX setVariable ["BIS_enableRandomization", false];
	[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
	[_c, _spawnPos, 2500, 4, "MOVE", "SAFE", "RED", "LIMITED",25] call ADF_fnc_vehiclePatrol;
};

// AO Defence Fire Team
for "_i" from 1 to 12 do {
	private ["_g","_spawnPos"];
	_spawnPos = format ["mGuerPaxDef_%1",_i];
	_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	[_g, getMarkerPos _spawnPos, 75, 2, true] call CBA_fnc_taskDefend;	
};

// AO Defence Squad
for "_i" from 20 to 25 do {
	private ["_g","_spawnPos"];
	_spawnPos = format ["mGuerPaxDef_%1",_i];
	_g = [getMarkerPos _spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressPashtun} forEach units _g;
	[_g, getMarkerPos _spawnPos, 125, 1, true] call CBA_fnc_taskDefend;	
};

// Count units/track time for win/loose scenario
ADF_OpforCnt = {(side _x == INDEPENDENT) && (alive _x)} count allUnits;
_opforCntWin = round ((ADF_OpforCnt / 7) + (random 10));
_ADF_missionTime = ADF_missionStartTime + 7200;

diag_log	"-----------------------------------------------------";
diag_log format ["TWO SIERRA: AO spawned. Number of OpFor: %1",ADF_OpforCnt];
diag_log	"-----------------------------------------------------";

waitUntil {
	sleep 30;
	_cnt = {(side _x == INDEPENDENT) && (alive _x)} count allUnits;
	((_cnt <= _opforCntWin) || (time > _ADF_missionTime)); // 2 hours + prep time
};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: End Mission process started";
diag_log	"-----------------------------------------------------";

ADF_endMission = true; publicVariable "ADF_endMission";

// Create end mission trigger at LMAB
tEndMission = createTrigger ["EmptyDetector", getMarkerPos "mLMAB", true];
tEndMission setTriggerActivation ["WEST","PRESENT",false];
tEndMission setTriggerArea [200,325,240,true];
tEndMission setTriggerTimeout [0,0,0,false];
tEndMission setTriggerStatements [
	"{vehicle _x in thisList && isPlayer _x && ((getPosATL _x) select 2) < 5} count allUnits > 0;",
	"",
	""
];