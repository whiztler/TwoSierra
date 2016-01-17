diag_log "ADF RPT: Init - executing Scr\init_ao.sqf"; // Reporting. Do NOT edit/remove

private ["_i", "_wave1", "_wave2", "_cnt_Win", "_cnt_Obj"];

ADF_assaultTimer = [240, 300, 360, 420, 480] call BIS_fnc_selectRandom; publicVariable "ADF_assaultTimer";

diag_log	"-----------------------------------------------------";
diag_log format ["TWO SIERRA: Pashtun assault timer: %1 min",round (ADF_assaultTimer/60)];
diag_log	"-----------------------------------------------------";
sleep ADF_assaultTimer;

ADF_assaultStart = true; publicVariable "ADF_assaultStart";

sleep 30;
diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: CSAT para assault - first wave started";
diag_log	"-----------------------------------------------------";

ADF_AO_assault = {
	params ["_g"];
	private "_wp";
	
	_g allowFleeing 0;
	(leader _g) setSkill ['commanding', 1];
	
	_wp = _g addWaypoint [getMarkerPos "mBronson", 0];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointCombatMode "RED";
};

for "_i" from 1 to 9 do {
	private ["_ps", "_pd", "_s"];
	_ps = format ["mPs_%1", _i];
	_pd = format ["mPd_%1", _i];
	
	[_ps, _pd, east, 2, "ADF_fnc_redressCSAT3", "ADF_AO_assault"] spawn ADF_fnc_createPara;
	
	_s = ((random 15) + (random 15));
	if (_s < 5) then {_s = 5};
	sleep _s;
};

sleep ((random 75) + (random 75));

[getMarkerPos "mMSR_11", getMarkerPos "mMSR_5", 30, "FULL", "O_Plane_CAS_02_F", east] call BIS_fnc_ambientFlyby;

// add ground troops
for "_i" from 1 to 9 step 2 do {
	private ["_g", "_p", "_r", "_t"];
	_p	= format ["mPd_%1", _i];
	_p	= getMarkerPos _p;
	_t	= "";
	if ((random 1) < .33) then {_t = "OIA_InfAssault"} else {_t = "OIA_InfSquad_Weapons"};
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

	_g allowFleeing 0;
	(leader _g) setSkill ['commanding', 1];
	_wp = _g addWaypoint [getMarkerPos "mBronson", 0];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointCombatMode "RED";
};

ADF_init_AO = true; publicVariable "ADF_init_AO";
diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: CSAT para assault - first wave finished";
diag_log	"-----------------------------------------------------";

sleep 60;
private "_wave1";
_wave1 = {side _x == east} count allUnits;

[getMarkerPos "mMSR_20", getMarkerPos "mBase_6", 30, "FULL", "O_Plane_CAS_02_F", east] call BIS_fnc_ambientFlyby;
[getMarkerPos "mPS_5", getMarkerPos "mBase_9", 40, "FULL", "O_Plane_CAS_02_F", east] call BIS_fnc_ambientFlyby;
[getMarkerPos "mBase_3", getMarkerPos "mBronson", east, 3, 1200, 30, 4, "MOVE", "COMBAT", "RED", "LIMITED", "FILE", 150] call ADF_fnc_createAirPatrol;

sleep 600 + (random 800);

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: CSAT para assault - Second wave started";
diag_log	"-----------------------------------------------------";

private "_i";
for "_i" from 1 to 3 do {
	private ["_ps", "_pd", "_s"];
	_ps = format ["mPs_%1", _i];
	_pd = getMarkerPos "mBaseDrop";
	[_ps, _pd, east, 2, "ADF_fnc_redressCSAT3", "ADF_AO_assault"] spawn ADF_fnc_createPara;
	sleep 5;
};

_wave2	= 24;
_cnt_Obj	= ["mOpforScan", east, 600, "MAN"] call ADF_fnc_countRadius;
_cnt_Win = floor ((_cnt_Obj / 10) + (random 10));

if (_cnt_Obj < 50) then {_cnt_Win = 10};
if (_cnt_Win < 10) then {_cnt_Win = 10};

diag_log	"----------------------------------------------------------------------";
diag_log format ["TWO SIERRA: AO OpFor spawned, first wave: %1", _wave1];
diag_log format ["TWO SIERRA: AO OpFor spawned, second wave: %1", _wave2];
diag_log format ["TWO SIERRA: AO OpFor spawned, current total: %1", {side _x == east} count allUnits];
diag_log format ["TWO SIERRA: AO Opfor in Objective area: %1 (mission success count: %2)", _cnt_Obj, _cnt_Win];
diag_log	"----------------------------------------------------------------------";

ADF_motsSpawned = true;

waitUntil {
	sleep 10;
	private ["_c", "_q"];
	_c = ["mOpforScan", east, 600, "MAN"] call ADF_fnc_countRadius;
	diag_log format ["TWO SIERRA: Current AO Objective Opfor count: %1 (condition: < %2)", _c, _cnt_Win];
	if (_c < 25 && !ADF_sweepMsg) then {remoteExec ["ADF_msg_sweep",0,true]; ADF_sweepMsg = true;};
	_c < _cnt_Win;
};

ADF_endMission = true; publicVariable "ADF_endMission";

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: End Mission process started";
diag_log format ["TWO SIERRA: Current AO Opfor count: %1 (condition: < %2)", _c, _cnt_Win];
diag_log	"-----------------------------------------------------";

remoteExec ["ADF_msg_endMission", 0, true];

#include "ADF_comp_end.sqf"
