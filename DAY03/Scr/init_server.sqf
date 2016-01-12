diag_log "ADF RPT: Init - executing Scr\init_server.sqf"; // Reporting. Do NOT edit/remove
if (!isServer) exitWith {};

call compile preprocessFileLineNumbers "Core\F\ADF_fnc_position.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_distance.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_vehiclePatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_defendArea.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_footPatrol.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createIED.sqf";
call compile preprocessFileLineNumbers "Core\F\ADF_fnc_objectMarker.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_NRF.sqf";
call compile preprocessFileLineNumbers "Scr\ADF_redress_Pashtun.sqf";

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
[medTruck] execVM "Core\C\ADF_vCargo_B_TruckMedi.sqf"; 
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD,MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA,MRAP_2_1_BRAVO,MRAP_2_2_ALPHA,MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1,MRAP_2_3_WT2];

///// NRF LMAB

// Static Defences
NRF_grp_4 = createGroup west; 
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "SERGEANT"]; _p moveInGunner oStat_01;
_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "CORPORAL"]; _p moveInGunner oStat_02;
//_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "CORPORAL"]; _p moveInGunner oStat_03;
//_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "PRIVATE"]; _p moveInGunner oStat_04;
//_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "PRIVATE"]; _p moveInGunner oStat_05;
//_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "PRIVATE"]; _p moveInGunner oStat_06;
//_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "PRIVATE"]; _p moveInGunner oStat_07;
{[_x] call ADF_fnc_redressNRF; _x enableSimulationGlobal false;} forEach units NRF_grp_4;
NRF_grp_4 setGroupIdGlobal ["5-3 CHARLIE"];

// Foot patrols	
NRF_grp_1 = [getPos oLand_1, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_1;
NRF_grp_1 setGroupIdGlobal ["5-1 ALPHA"];
[NRF_grp_1, position leader NRF_grp_1, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;

NRF_grp_2 = [getPos oLand_2, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_2;
NRF_grp_2 setGroupIdGlobal ["5-1 BRAVO"];
[NRF_grp_2, position leader NRF_grp_2, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;

NRF_grp_3 = [getPos (b_net), WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_3;
NRF_grp_3 setGroupIdGlobal ["5-2 ALPHA"];
[NRF_grp_3, position leader NRF_grp_3, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;

// Create random IED's
_iedMarkerArr = ["mIED_1", "mIED_2", "mIED_3", "mIED_4", "mIED_5", "mIED_6", "mIED_7", "mIED_8", "mIED_9", "mIED_10", "mIED_11", "mIED_12", "mIED_13", "mIED_14", "mIED_15", "mIED_16"];
for "_i" from 1 to 10 do {
	private ["_iedMarkerPos", "_idx"];
	_iedMarkerPos 	= _iedMarkerArr call BIS_fnc_selectRandom;
	_idx 			=  _iedMarkerArr find _iedMarkerPos;
	_iedMarkerArr deleteAt _idx;
	[_iedMarkerPos,100,250,6] call ADF_fnc_createRandomIEDs;
};

// Dolphin vehicle
[vDolphin, 0, 120] call bis_fnc_setpitchbank;
vDolphin setDamage .7;
vDolphin setHit ["wheel_1_2_steering", 1];
vDolphin setHit ["wheel_1_4_steering", 1];
vDolphin setHit ["wheel_1_1_steering", 1];
	
{{_x setObjectTextureGlobal [0, "\a3\characters_f\BLUFOR\Data\clothing_sage_co.paa"];} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3,NRF_grp_4];

ADF_wpPosRdm = {
	private "_wpPos";
	_wpPos = ["mAirPos_1", "mAirPos_2", "mAirPos_3", "mAirPos_4", "mAirPos_5"] call BIS_fnc_selectRandom;
	_wpPos
};

[] spawn {
	sleep 25;
	while {true} do {
		private ["_c", "_v", "_wp", "_heli", "_startPos", "_exitPos", "_pause"];
		_pause = [300,600,900,1200,1800] call BIS_fnc_selectRandom;
		_startPos = call ADF_wpPosRdm;
		_exitPos = call ADF_wpPosRdm;
		_heli = "B_Heli_Transport_03_F";
		_landPos = [oLand_1,oLand_2] call BIS_fnc_selectRandom;		
		_c = createGroup west;
		_c setCombatMode "GREEN";
		_v = [getMarkerPos _startPos, 0, _heli, _c] call BIS_fnc_spawnVehicle;
		_c setGroupIdGlobal ["6-1 AIRBUS"];
		vAirbus = _v select 0;
		vAirbus setObjectTextureGlobal [0, "Img\cusTex_NRFcamo.jpg"]; vAirbus setObjectTextureGlobal [1, "Img\cusTex_NRFcamo.jpg"];		
		{_x unassignItem "NVGoggles"; _x removeItem "NVGoggles"; _x enableGunlights "forceOn";} forEach units _c;
		vAirbus flyInHeight 75;
		_wp = _c addWaypoint [getPos _landPos, 0];
		_wp setWaypointType "MOVE";
		_wp setWaypointBehaviour "SAFE";
		_wp setWaypointSpeed "NORMAL";
		_wp setWaypointStatements ["true", "vAirbus land 'LAND';"];
		{_x disableAI "AUTOTARGET"; _x disableAI "CHECKVISIBLE"; _x setBehaviour "CARELESS"} forEach units _c;
		waitUntil {(currentWaypoint (_wp select 0)) > (_wp select 1)};
		waitUntil {isTouchingGround vAirbus};
		{vAirbus animateDoor [_x, 1];} forEach ["door_L_source", "door_R_source", "Door_rear_source"];
		_pausePad = [60,120,180,240,300,600] call BIS_fnc_selectRandom;
		vAirbus setFuel 0;
		sleep _pausePad;
		vAirbus setFuel 1;
		{vAirbus animateDoor [_x, 0];} forEach ["door_L_source", "door_R_source", "Door_rear_source"];
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
	sleep random 300;
	while {alive vGunship} do {
		private ["_c", "_wp", "_wpPos", "_pausePad"];	
		_c = createGroup west;
		_c setCombatMode "GREEN";
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
		{_x disableAI "AUTOTARGET"; _x disableAI "CHECKVISIBLE"; _x setBehaviour "CARELESS"} forEach units _c;
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

ADF_fnc_greenZone = {
	ADF_greenCnt = ADF_greenCnt + 1;
	[ADF_greenCnt] remoteExec ["ADF_msg_greenZone", -2, true];
};

ADF_msg_start = {
	ADF_missionStartTime = time;
};

ADF_AO_mosque = {
	// Mosque SAD
	for "_i" from 30 to 34 do {
		private ["_p", "_wp"];
		_p	= format ["mGuerPaxDef_%1",_i];
		
		_g = [getMarkerPos _p, independent, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
		{[_x] call ADF_fnc_redressPashtun} forEach units _g;
		
		_wp = _g addWaypoint [getPos tMosque, 0];
		_wp setWaypointType "SAD";
		_wp setWaypointBehaviour "COMBAT";
		_wp setWaypointSpeed "FULL";
	};

	private "_v";

	_c = createGroup independent;
	_v = [getMarkerPos "mGuerVeh_40", markerDir "mGuerVeh_40", "I_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressPashtun} forEach units _c;
	_v = _v select 0;
	[_v, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;

	_wp = _c addWaypoint [getPos tMosque, 0];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "FULL";

	deleteVehicle tMosque;
};

#include "init_AO.sqf"