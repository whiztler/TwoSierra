diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove
if (isServer) then {
	EAST setFriend [WEST, 0.7];
	WEST setFriend [EAST, 0.7];	
	execVM "Scr\bearclaw_server.sqf";
	execVM "Scr\xray_server.sqf";
	
	[] spawn { // CSAT switch side random timer
		private ["_time","_CSATswitch","_CSAThostileSet"];
		_time = [45,60,75,90,105,120] call BIS_fnc_selectRandom;
		_CSATswitch = 60 * _time;
		waitUntil {sleep 10; time > _CSATswitch};
		CSAThostile = true; publicVariable "CSAThostile";
		_CSAThostileSet = 5 * _time;
		sleep _CSAThostileSet;
		EAST setFriend [WEST, 0];
		WEST setFriend [EAST, 0];
	};	
};