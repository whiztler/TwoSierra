private ["_ADF_OpforCntTotal","_ADF_OpforCntBase"];
_ADF_OpforCntTotal = {side _x == EAST} count allUnits;
_ADF_OpforCntBase = _ADF_OpforCntTotal - _ADF_OpforCntCity;

diag_log	"-----------------------------------------------------";
diag_log format ["TWO SIERRA: AO Corazol spawned. Number of OpFor: %1",_ADF_OpforCntCity];
diag_log format ["TWO SIERRA: AO Calvin spawned. Number of OpFor: %1",_ADF_OpforCntBase];
diag_log format ["TWO SIERRA: AO TOTAL spawned. Number of OpFor: %1",_ADF_OpforCntTotal];
diag_log	"-----------------------------------------------------";

// Track CORAZOL sectors
[] spawn {
	// Foxtrot
	waitUntil {
		private ["_a"];
		sleep 8 + (random 1);				
		_a = nearestObjects [getMarkerPos "mFoxtrot", ["Man"], 90]; 
		({side _x == WEST} count _a) > 0;	
	};
	diag_log "TWO SIERRA: Objective FOXTROT activated";
	tFoxtrotBase enableSimulation true;
	tFoxtrotAmmo enableSimulation true;
	waitUntil {
		private ["_a","_o","_b"];
		sleep 5 + (random 1);			
		_a = nearestObjects [getMarkerPos "mFoxtrot", ["Man"], 80]; 
		_o = {side _x == EAST} count _a;
		diag_log format ["TWO SIERRA: Objective FOXTROT condition - Opfor: %1",_o];
		_o == 0;
	};
	ADF_obj_foxtrot = true;
	remoteExec ["ADF_msg_foxtrotBlue",0,true];
};

[] spawn {
	// Golf
	waitUntil {
		private ["_a"];
		sleep 8 + (random 1);			
		_a = nearestObjects [getMarkerPos "mGolf", ["Man"], 55]; 
		({(side _x == WEST) && (alive _x)} count _a) > 0;	
	};
	diag_log "TWO SIERRA: Objective GOLF activated";
	tGolfFuel enableSimulation true;
	waitUntil {
		private ["_a","_o","_b"];
		sleep 5 + (random 1);	
		_a = nearestObjects [getMarkerPos "mGolf", ["Man"], 55]; 
		_o = {side _x == EAST} count _a;
		diag_log format ["TWO SIERRA: Objective GOLF condition - Opfor: %1",_o];
		_o == 0;
	};
	remoteExec ["ADF_msg_golfBlue",0,true];
};

[] spawn {
	// Hotel
	waitUntil {
		private ["_a"];
		sleep 8 + (random 1);			
		_a = nearestObjects [getMarkerPos "mHotel", ["Man"], 75]; 
		({(side _x == WEST) && (alive _x)} count _a) > 0;	
	};
	diag_log "TWO SIERRA: Objective HOTEL activated";
	tHotelSupply enableSimulation true;
	waitUntil {
		private ["_a","_o","_b"];
		sleep 5 + (random 1);			
		_a = nearestObjects [getMarkerPos "mHotel", ["Man"], 75]; 
		_o = {side _x == EAST} count _a;
		diag_log format ["TWO SIERRA: Objective HOTEL condition - Opfor: %1",_o];
		_o == 0;
	};
	remoteExec ["ADF_msg_hotelBlue",0,true];
};

[] spawn {
	// Delta
	waitUntil {
		private ["_a"];
		sleep 5 + (random 1);				
		_a = nearestObjects [getMarkerPos "mDelta", ["Man"], 75]; 
		({(side _x == WEST) && (alive _x)} count _a) > 0;	
	};
	diag_log "TWO SIERRA: Objective DELTA activated";
	waitUntil {
		private ["_a","_o","_b"];
		sleep 5;		
		_a = nearestObjects [getMarkerPos "mDelta", ["Man","CAR","TANK"], 75]; 
		_o = {side _x == EAST} count _a;
		diag_log format ["TWO SIERRA: Objective DELTA condition - Opfor: %1",_o];
		_o == 0;
	};
	remoteExec ["ADF_msg_DeltaBlue",0,true];
};

[] spawn {
	// Echo
	waitUntil {
		private ["_a"];
		sleep 5 + (random 1);		;		
		_a = nearestObjects [getMarkerPos "mEcho", ["Man"], 75]; 
		({(side _x == WEST) && (alive _x)} count _a) > 0;	
	};
	diag_log "TWO SIERRA: Objective ECHO activated";
	waitUntil {
		private ["_a","_o","_b"];
		sleep 5 + (random 1);			
		_a = nearestObjects [getMarkerPos "mEcho", ["Man"], 50]; 
		_o = {side _x == EAST} count _a;
		diag_log format ["TWO SIERRA: Objective ECHO condition - Opfor: %1",_o];
		_o == 0;
	};
	remoteExec ["ADF_msg_EchoBlue",0,true];
};

[] spawn {
	// Romeo
	waitUntil {
		private ["_a"];
		sleep 5;		
		_a = nearestObjects [getMarkerPos "mRomeo", ["Man"], 75]; 
		({side _x == WEST} count _a) > 0;	
	};
	diag_log "TWO SIERRA: Objective ECHO activated";
	waitUntil {
		private ["_a","_o","_b"];
		sleep 5 + (random 1);		
		_a = nearestObjects [getMarkerPos "mRomeo", ["Man"], 50]; 
		_o = {(side _x == EAST) && (alive _x)} count _a;
		diag_log format ["TWO SIERRA: Objective ECHO condition - Opfor: %1",_o];
		_o < 3;
	};
	remoteExec ["ADF_msg_RomeoBlue",0,true];
};

// Track city scenario win
[] spawn {
	waitUntil {
		private ["_a","_o","_b"];
		sleep 60;		
		_a = nearestObjects [getMarkerPos "mRad", ["Man"], 550]; 
		_o = {(side _x == EAST) && (alive _x)} count _a;
		_b = {alive _x} count allPlayers;
		diag_log format ["TWO SIERRA: Mission win condition  (O < B) CORAZOL - Opfor: %1 | BluFor: %2 ",_o,_b];
		((_o < _b) || (time > 10800)); // 3 hours		
	};
	remoteExec ["ADF_msg_corazolBlue",0,true];
};

// Track base scenario win
[] spawn {
	waitUntil {
		private ["_a","_o","_b"];
		sleep 60 + (random 2);		
		_a = nearestObjects [getMarkerPos "mCalvin", ["Man"], 150]; 
		_o = {(side _x == EAST) && (alive _x)} count _a;
		diag_log format ["TWO SIERRA: Mission win condition (O = 4) CALVIN - Opfor: %1",_o];
		(triggerActivated tCalvin && ((_o < 5) || (time > 12600))); // 3,5 hours		
	};
	remoteExec ["ADF_msg_calvinBlue",0,true];
};