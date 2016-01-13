objBearclaw setName ["Jeff Kroger","Jeff","Kroger"];
bearClawAction = objBearclaw addAction ["<t color='#9DA698'>Rescue Bearclaw</t>",{[_this select 0, _this select 1] remoteExec ["ADF_TS_bearclawRescued",0,true]},[],-95,true,true,"",""];

ADF_TS_bearclawRescued = {
	params ["_o", "_c"];
	objBearclaw removeAction bearClawAction;
	[objBearclaw] joinSilent (group _c);
	BearclawRescued = true; publicVariable "BearclawRescued";
	diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: Bearclaw rescued";diag_log	"-----------------------------------------------------";
	if (!hasInterface) exitWith {};
	["NONE","Jeff Kroger","Jeff Kroger (BEARCLAW), thanks fellas, it is really good to see you guys."] call ADF_fnc_MessageParser; sleep 8;
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 9;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Send traffic. Over"] call ADF_fnc_MessageParser; sleep 8;
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. BEARCLAW secured. How copy?"] call ADF_fnc_MessageParser; sleep 15;

	if (xRayDestroyed) then {
		["ACO","ACO","TWO SIERRA this is FIRESTONE Good copy. Break. Escort BEARCLAW to ZEBRA. Over."] call ADF_fnc_MessageParser; sleep 14;
		["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Roger. Escort BEARCLAW to RV ZEBRA. Out."] call ADF_fnc_MessageParser;
	} else {
		["ACO","ACO","TWO SIERRA this is FIRESTONE. Good copy. Provide security for BEARCLAW. Break.<br/><br/>Find and neutralize XRAY. How copy?"] call ADF_fnc_MessageParser; sleep 16;
		["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Solid copy. secure BEARCLAW. Find and destroy XRAY. Out."] call ADF_fnc_MessageParser;
	};
};

ADF_TS_bearclawKilled = {	
	if (!hasInterface) exitWith {};
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 9;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Send. Over"] call ADF_fnc_MessageParser; sleep 7;
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. We lost the package. BEARCLAW is k.i.a. Over."] call ADF_fnc_MessageParser; sleep 12;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Solid copy. Mission aborted. RTB. Over."] call ADF_fnc_MessageParser; sleep 14;
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Roger. Out."] call ADF_fnc_MessageParser;
	sleep 20;
	["END2",false,5] call BIS_fnc_endMission;
};

