ADF_Everest1 = {
	if (!hasInterface) exitWith {};
	if (!(alive vObj1) && !(alive vObj1)) exitWith {
		["2S","","FAIRCHILD this is TWO SIERRA. We lost both EVEREST1 and EVEREST2. How copy?"] call ADF_fnc_MessageParser; sleep 14;
		["ACO","ACO","FAIRCHILD: Unacceptable TWO SIERRA. MARY needs those supplies urgently. Abort mission and RTB asap. Out"] call ADF_fnc_MessageParser;
		sleep 12;
		["END2",false,5] call BIS_fnc_endMission;
	};
	sleep 3;
	["2S","","FAIRCHILD this is TWO SIERRA. We just lost EVEREST1. How copy?"] call ADF_fnc_MessageParser; sleep 12;
	["ACO","ACO","FAIRCHILD: Dammit TWO SIERRA. Those supplies would have saved lives. You better make sure that EVEREST2 makes it safely to MARY. out."] call ADF_fnc_MessageParser;	
};

ADF_Everest2 = {
	if (!hasInterface) exitWith {};
	if (!(alive vObj1) && !(alive vObj1)) exitWith {
		["2S","","FAIRCHILD this is TWO SIERRA. We lost both EVEREST1 and EVEREST2. How copy?"] call ADF_fnc_MessageParser; sleep 14;
		["ACO","ACO","FAIRCHILD: Unacceptable TWO SIERRA. MARY needs those supplies urgently. Abort mission and RTB asap. Out"] call ADF_fnc_MessageParser;
		sleep 12;
		["END2",false,5] call BIS_fnc_endMission;
	};
	sleep 3;
	["2S","","FAIRCHILD this is TWO SIERRA. We lost EVEREST2. How copy?"] call ADF_fnc_MessageParser; sleep 12;
	["ACO","ACO","FAIRCHILD: Dammit TWO SIERRA. Those supplies would have saved lives. You better make sure that EVEREST1 makes it safely to MARY. out."] call ADF_fnc_MessageParser;	
};