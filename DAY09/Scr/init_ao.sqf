diag_log "ADF RPT: Init - executing Scr\init_ao.sqf"; // Reporting. Do NOT edit/remove

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: Started spawning AO ai's";
diag_log	"-----------------------------------------------------";

// AA sites
private ["_g", "_u"];
_g = createGroup east; 
_u = _g createUnit ["O_crew_F", getMarkerPos "mPat_1", [], 0, "SERGEANT"]; _u moveInGunner vAA_1;
_u = _g createUnit ["O_crew_F", getMarkerPos "mPat_1", [], 0, "SERGEANT"]; _u moveInGunner vAA_2;
{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

// Sea patrol
private "_i";
for "_i" from 1 to 2 do {
	private ["_p", "_d", "_c", "_v"];
	_p = format ["mSea_%1", _i];
	_d = markerDir _p;
	_p = getMarkerPos _p;		

	_c = createGroup east;
	_v = [_p, _d, "O_Boat_Armed_01_hmg_F", _c] call BIS_fnc_spawnVehicle;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _c;

	[_c, _p, 500, 4, "MOVE", "SAFE", "RED", "NORMAL", "FILE", 5] call ADF_fnc_seaPatrol;	
};

// AO Defence Squad
for "_i" from 1 to 14 do {
	private ["_g", "_p", "_sqd"];
	_p = format ["mDef_%1", _i];
	_p = getMarkerPos _p;
	_sqd = "";
	if ((random 1) > .33) then {_sqd = "OIA_InfAssault"} else {_sqd = "OIA_InfSquad_Weapons"};
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> _sqd)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

	[_g, _p, 100, 2, true] call ADF_fnc_defendArea;
};

// Foot patrols
for "_i" from 1 to 10 do {
	private ["_g", "_p", "_r", "_p"];
	_p	= ["mPat_1", "mPat_2", "mPat_3"] call BIS_fnc_selectRandom;
	_r	= floor ((random 300) + (random 300));
	_p	= getMarkerPos _p;
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OI_reconSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

	[_g, _p, _r, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

private "_cnt_ObjCity";
_cnt_ObjCity = {side _x == east} count allUnits;

// Calvin Defence Squad
private ["_g", "_p", "_sqd"];
_p		= getMarkerPos "mDefCalvin";
_sqd		= "";
if ((random 1) < .45) then {_sqd = "OIA_InfAssault"} else {_sqd = "OIA_InfSquad_Weapons"};

_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> _sqd)] call BIS_fnc_spawnGroup;
{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

[_g, _p, 100, 2, true] call ADF_fnc_defendArea;


// Calvin Foot patrols
for "_i" from 1 to 3 do {
	private ["_g", "_p"];
	_p	= getMarkerPos "mPatCalvin";
	_r	= (random 150) + (random 150);
	
	_g = [_p, east, (configFile >> "CfgGroups" >> "east" >> "OPF_F" >> "Infantry" >> "OI_reconSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressCSAT3} forEach units _g;

	[_g, _p, _r, 3, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};

ADF_init_AO = true; publicVariable "ADF_init_AO";

private ["_cnt_ObjCalvin"];
_cnt_ObjCalvin = ({side _x == east} count allUnits) - _cnt_ObjCity;

diag_log	"-----------------------------------------------------";
diag_log format ["TWO SIERRA: AO Corazol spawned. Number of OpFor: %1", _cnt_ObjCity];
diag_log format ["TWO SIERRA: AO Calvin spawned. Number of OpFor: %1", _cnt_ObjCalvin];
diag_log format ["TWO SIERRA: AO TOTAL spawned. Number of OpFor: %1", {side _x == east} count allUnits];
diag_log	"-----------------------------------------------------";

// Track CORAZOL sectors
[] spawn {
	// Foxtrot
	waitUntil {
		sleep 8 + (random 1);
		(["mFoxtrot", west, 90, "MAN"] call ADF_fnc_countRadius) > 0;	
	};
	diag_log "TWO SIERRA: Objective FOXTROT activated";
	tFoxtrotBase enableSimulation true;
	tFoxtrotAmmo enableSimulation true;
	waitUntil {
		private "_o";
		sleep 5 + (random 1);			
		_o = ["mFoxtrot", east, 80, "MAN"] call ADF_fnc_countRadius;
		diag_log format ["TWO SIERRA: Objective FOXTROT condition - Opfor: %1", _o];
		_o == 0;
	};
	ADF_obj_foxtrot = true;
	remoteExec ["ADF_msg_foxtrotBlue", 0, true];
	sleep 10;	
};

[] spawn {
	// Golf
	waitUntil {
		sleep 8 + (random 1);
		(["mGolf", west, 55, "MAN"] call ADF_fnc_countRadius)) > 0
	};
	diag_log "TWO SIERRA: Objective GOLF activated";
	tGolfFuel enableSimulation true;
	waitUntil {
		private "_o";
		sleep 5 + (random 1);	
		_o = ["mGolf", east, 55, "MAN"] call ADF_fnc_countRadius;
		diag_log format ["TWO SIERRA: Objective GOLF condition - Opfor: %1", _o];
		_o == 0;
	};
	remoteExec ["ADF_msg_golfBlue", 0, true];
};

[] spawn {
	// Hotel
	waitUntil {
		sleep 8 + (random 1);			
		(["mHotel", west, 75, "MAN"] call ADF_fnc_countRadius)) > 0
	};
	diag_log "TWO SIERRA: Objective HOTEL activated";
	tHotelSupply enableSimulation true;
	waitUntil {
		private "_o";
		sleep 5 + (random 1);	
		_o = ["mHotel", east, 75, "MAN"] call ADF_fnc_countRadius;
		diag_log format ["TWO SIERRA: Objective HOTEL condition - Opfor: %1", _o];
		_o == 0;
	};
	remoteExec ["ADF_msg_hotelBlue", 0, true];
};

[] spawn {
	// Delta
	waitUntil {
		sleep 5 + (random 1);				
		(["mDelta", west, 75, "MAN"] call ADF_fnc_countRadius)) > 0
	};
	diag_log "TWO SIERRA: Objective DELTA activated";
	waitUntil {
		private "_o";
		sleep 5 + (random 1);	
		_o = ["mDelta", east, 75, "MAN"] call ADF_fnc_countRadius;
		diag_log format ["TWO SIERRA: Objective DELTA condition - Opfor: %1", _o];
		_o == 0;
	};
	remoteExec ["ADF_msg_DeltaBlue", 0, true];
};

[] spawn {
	// Echo
	waitUntil {
		sleep 5 + (random 1);	
		(["mEcho", west, 75, "MAN"] call ADF_fnc_countRadius)) > 0
	};
	diag_log "TWO SIERRA: Objective ECHO activated";
	waitUntil {
		private "_o";
		sleep 5 + (random 1);	
		_o = ["mEcho", east, 50, "MAN"] call ADF_fnc_countRadius;
		diag_log format ["TWO SIERRA: Objective ECHO condition - Opfor: %1", _o];
		_o == 0;
	};
	remoteExec ["ADF_msg_EchoBlue", 0, true];
};

[] spawn {
	// Romeo
	waitUntil {
		sleep 5 + (random 1);		
		(["mRomeo", west, 75, "MAN"] call ADF_fnc_countRadius)) > 0
	};
	diag_log "TWO SIERRA: Objective ECHO activated";
	waitUntil {
		private "_o";
		sleep 5 + (random 1);
		_o = ["mRomeo", east, 50, "MAN"] call ADF_fnc_countRadius;
		diag_log format ["TWO SIERRA: Objective ECHO condition - Opfor: %1", _o];
		_o < 3;
	};
	remoteExec ["ADF_msg_RomeoBlue", 0, true];
};

// Track Corazol scenario win
[] spawn {
	waitUntil {
		private ["_a", "_o", "_b"];
		sleep 60 + (random 2);
		_o = ["mRad", east, 550, "MAN"] call ADF_fnc_countRadius;
		_b = {alive _x} count allPlayers;
		diag_log format ["TWO SIERRA: Mission win condition  (O < B) CORAZOL - Opfor: %1 | BluFor: %2 ", _o, _b];
		((_o < _b) || (time > 10800)); // 3 hours		
	};
	remoteExec ["ADF_msg_corazolBlue", 0, true];
};

// Track Calvin scenario win
[] spawn {
	waitUntil {
		private "_o";
		sleep 60 + (random 2);		
		_o = ["mCalvin", east, 150, "MAN"] call ADF_fnc_countRadius;
		diag_log format ["TWO SIERRA: Mission win condition (O = 4) CALVIN - Opfor: %1", _o];
		(triggerActivated tCalvin && ((_o < 5) || (time > 12600))); // 3,5 hours		
	};
	remoteExec ["ADF_msg_calvinBlue", 0, true];
};
