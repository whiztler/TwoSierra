objBearclaw setName ["Jeff Kroger","Jeff","Kroger"];
bearClawAction = objBearclaw addAction ["<t align='left' color='#9DA698'>Rescue Bearclaw</t>",{[[],"ADF_TS_bearclawRescued"] call BIS_fnc_MP;},[],-95,true,true,"",""];
objBearclaw addEventHandler ["killed", {[[],"ADF_TS_bearclawKilled",true,false,false] spawn BIS_fnc_MP;}];

ADF_TS_bearclawRescued = {
	//objBearclaw enableAI "MOVE";
	objBearclaw removeAction bearClawAction;
	[objBearclaw] joinSilent player;
	BearclawRescued = true; publicVariable "BearclawRescued";
	if (!hasInterface) exitWith {};
	["NONE","Jeff Kroger","Jeff Kroger (BEARCLAW), thanks fellas, it is really good to see you guys."] call ADF_fnc_MessageParser; sleep 8;
	["2S","TWO SIERRA","TWO SIERRA: FIRESTONE this is TWO SIERRA, we have BEARCLAW, I repeat we have BEARCLAW. How copy?"] call ADF_fnc_MessageParser; sleep 15;

	if (xRayDestroyed) then {
		["ACO","ACO","FIRESTONE: Good job TWO SIERRA. Escort BEARCLAW back to RV ZEBRA."] call ADF_fnc_MessageParser;
	} else {
		["ACO","ACO","FIRESTONE: Good job TWO SIERRA. Provide security for BEARCLAW.<br/><br/>Your next objective is to neutralize XRAY. Out."] call ADF_fnc_MessageParser;
	};
};

ADF_TS_bearclawKilled = {
	["ACO","ACO","FIRESTONE: TWO SIERRA, we just received intel that BEARCLAW is K.I.A. Mission aborted. RTB asap!"] call ADF_fnc_MessageParser;
	sleep 12;
	["END2",false,5] call BIS_fnc_endMission;
};

