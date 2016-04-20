// Mission Objective Test Script
// DAY 11

diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) started";

private "_a";
if (!isMultiplayer) exitWith {hint parseText "<t color='#FE2E2E' align='left' size='1.5'>ERROR</t><br/><br/><t color='#FFFFFF' align='left' size='.9'>The Mission Objectibe Test Script (mots.sqf) only works on a dedicated server environment!</t><br/><br/>"};
if (!isServer) exitWith {hint parseText "<t color='#FE2E2E' align='left' size='1.5'>ERROR</t><br/><br/><t color='#FFFFFF' align='left' size='.9'>The Mission Objectibe Test Script (mots.sqf) needs to be executed by the server!</t><br/><br/><t color='#FFFFFF' align='left' size='.9'>Click the </t><t color='#43c3ff' align='left' size='1'>SERVER EXEC </t><t color='#FFFFFF' align='left' size='.9'>button in the debug window. Do NOT use LOCAL EXEC or GLOBAL EXEC!</t><br/><br/>"};
if (MotsActive) exitWith {"MOTS has already been executed!" remoteExec ["hint", -2];};
MotsActive = true;
_a = allPlayers - entities "HeadlessClient_F";
remoteExec ["ADF_fnc_MOTS", _a, true];

"Mission Objective Test Script started. JIP is not supported!" remoteExec ["systemChat", -2]; sleep 2;

if !(ADF_missionInit) then {"Waiting for mission init to finish..." remoteExec ["systemChat", -2];};
waitUntil {ADF_missionInit};

if (!ADF_init_AO) then {
	waitUntil {
		"Waiting for the AO to finish initializing..." remoteExec ["systemChat", -2]; uiSleep 5;
		ADF_init_AO
	};	
	"Done initializing the AO." remoteExec ["systemChat", -2]; uiSleep 2;
};

"Starting MOTS process. Make sure you are NOT in a vehicle!" remoteExec ["systemChat", -2]; uiSleep 5;

"Teleporting to the AO for scenery in 5 seconds..." remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_1")} forEach _a; sleep 3;
waitUntil {sleep 10; "Waiting for 3RD Platoon to get ready for the distraction..." remoteExec ["systemChat", -2]; time > 120};
"3RD Platoon distraction started." remoteExec ["systemChat", -2]; uiSleep 5;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"3RD Platoon distraction active." remoteExec ["systemChat", -2]; uiSleep 15;

// PASTEUR
"Teleporting to Pasteur AO in 5 seconds" remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_2")} forEach _a; sleep 5;
"Changing setCaptive to true for all players." remoteExec ["systemChat", -2];
[true] remoteExec ["ADF_fnc_MOTS_captive", -2, false];
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;

"Changing setCaptive to false for all players." remoteExec ["systemChat", -2];
[false] remoteExec ["ADF_fnc_MOTS_captive", -2, false]; sleep 5;
"Teleporting to Pasteur main research facility in 5 seconds" remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_3")} forEach _a; sleep 5;
"Changing setCaptive to true for all players." remoteExec ["systemChat", -2];
[true] remoteExec ["ADF_fnc_MOTS_captive", -2, false];
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;

"Clearing the AO" remoteExec ["systemChat", -2]; 
{_x setDamage 1} forEach [vAA_1,vAA_2];
{if (side _x == EAST) then {_x setDamage 1}} forEach ((getMarkerPos "mBpat_6") nearEntities [["MAN","CAR","APC","TANK","StaticWeapon"], 400]); uiSleep 5;
"PASTEUR cleared" remoteExec ["systemChat", -2]; uiSleep 5;
"Changing setCaptive to false for all players." remoteExec ["systemChat", -2];
[false] remoteExec ["ADF_fnc_MOTS_captive", -2, false]; sleep 5;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;

// LIMA
"Teleporting to LIMA in 5 seconds" remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_4")} forEach _a; sleep 5;

"Mission Objective Test Script completed" remoteExec ["systemChat", -2]; uiSleep 5;
diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) finished";