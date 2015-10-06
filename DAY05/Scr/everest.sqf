diag_log "ADF RPT: Init - executing Scr\everest.sqf"; // Reporting. Do NOT edit/remove
ADF__msg_Everest1 = {
	if (isServer) then {
		diag_log	"-----------------------------------------------------";
		diag_log "TWO SIERRA: Everest1 destroyed";
		diag_log	"-----------------------------------------------------";	
	};
	if (hasInterface) then {
		if (!alive vObj2) exitWith {
			["2S","","FAIRCHILD this is TWO SIERRA. We lost both EVEREST1 and EVEREST2. How copy?"] call ADF_fnc_MessageParser; sleep 14;
			["ACO","ACO","FAIRCHILD: Unacceptable TWO SIERRA. MARY needs those supplies urgently. Abort mission and RTB asap. Out"] call ADF_fnc_MessageParser;
			sleep 20;
			["END2",false,5] call BIS_fnc_endMission;
		};
		sleep 3;
		["2S","","FAIRCHILD this is TWO SIERRA. We just lost EVEREST1. How copy?"] call ADF_fnc_MessageParser; sleep 12;
		["ACO","ACO","FAIRCHILD: Dammit TWO SIERRA. Those supplies would have saved lives. You better make sure that EVEREST2 makes it safely to MARY. out."] call ADF_fnc_MessageParser;
	};
};

ADF_msg_Everest2 = {
	if (isServer) then {
		diag_log	"-----------------------------------------------------";
		diag_log "TWO SIERRA: Everest2 destroyed";
		diag_log	"-----------------------------------------------------";	
	};	
	if (hasInterface) then {
		if (!alive vObj1) exitWith {
			["2S","","FAIRCHILD this is TWO SIERRA. We lost both EVEREST1 and EVEREST2. How copy?"] call ADF_fnc_MessageParser; sleep 14;
			["ACO","ACO","FAIRCHILD: Unacceptable TWO SIERRA. MARY needs those supplies urgently. Abort mission and RTB asap. Out"] call ADF_fnc_MessageParser;
			sleep 20;
			["END2",false,5] call BIS_fnc_endMission;
		};
		sleep 3;
		["2S","","FAIRCHILD this is TWO SIERRA. We lost EVEREST2. How copy?"] call ADF_fnc_MessageParser; sleep 12;
		["ACO","ACO","FAIRCHILD: Dammit TWO SIERRA. Those supplies would have saved lives. You better make sure that EVEREST1 makes it safely to MARY. out."] call ADF_fnc_MessageParser;
	};
};