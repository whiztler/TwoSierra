objBearclaw setName ["Jeff Kroger","Jeff","Kroger"];
bearClawAction = objBearclaw addAction ["<t color='#9DA698'>Rescue Bearclaw</t>",{[_this select 0, _this select 1] remoteExec ["ADF_TS_bearclawRescued",0,true]},[],-95,true,true,"",""];

ADF_TS_bearclawRescued = {
	params ["_o","_c"];
	objBearclaw removeAction bearClawAction;
	[objBearclaw] joinSilent (group _c);
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
	if (!hasInterface) exitWith {};
	["ACO","ACO","FIRESTONE: TWO SIERRA, we just received intel that BEARCLAW is K.I.A. Mission aborted. RTB asap!"] call ADF_fnc_MessageParser;
	sleep 20;
	["END2",false,5] call BIS_fnc_endMission;
};

