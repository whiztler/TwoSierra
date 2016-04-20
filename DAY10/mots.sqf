// Mission Objective Test Script
// DAY 10

diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) started";

private "_a";
if (!isMultiplayer) exitWith {hint parseText "<t color='#FE2E2E' align='left' size='1.5'>ERROR</t><br/><br/><t color='#FFFFFF' align='left' size='.9'>The Mission Objectibe Test Script (mots.sqf) only works on a dedicated server environment!</t><br/><br/>"};
if (!isServer) exitWith {hint parseText "<t color='#FE2E2E' align='left' size='1.5'>ERROR</t><br/><br/><t color='#FFFFFF' align='left' size='.9'>The Mission Objectibe Test Script (mots.sqf) needs to be executed by the server!</t><br/><br/><t color='#FFFFFF' align='left' size='.9'>Click the </t><t color='#43c3ff' align='left' size='1'>SERVER EXEC </t><t color='#FFFFFF' align='left' size='.9'>button in the debug window. Do NOT use LOCAL EXEC or GLOBAL EXEC!</t><br/><br/>"};
if (MotsActive) exitWith {"MOTS has already been executed!" remoteExec ["hint", -2];};
MotsActive = true;
_a = allPlayers - entities "HeadlessClient_F";
remoteExec ["ADF_fnc_MOTS",_a,true];

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

"Teleporting to the Ortego AO in 5 seconds..." remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_1")} forEach _a; sleep 3;

waitUntil {sleep 10; "Waiting for AI's to settle in..." remoteExec ["systemChat", -2]; time > 120};

// ORTEGO
"Teleporting to Ortego (for scenery) in 5 seconds" remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_2")} forEach _a;
"Clearing Ortego" remoteExec ["systemChat", -2]; 
{_x setDamage 1} forEach [vAA_1,vAA_2];
{if (side _x == EAST) then {_x setDamage 1}} forEach ((getMarkerPos "mPat_11") nearEntities [["MAN","CAR","APC","TANK","StaticWeapon"], 800]); uiSleep 5;
"Ortego cleared" remoteExec ["systemChat", -2]; uiSleep 5;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;

// DOLORES
private "_t";
_t = time;
"Teleporting to the Dolores AO in 5 seconds..." remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_3")} forEach _a; sleep 3;
waitUntil {sleep 10; "Waiting for AI's to settle in..." remoteExec ["systemChat", -2]; time > (_t + 120)};

// FAHRENHEIT
"Teleporting to FAHRENHEIT in 5 seconds" remoteExec ["systemChat", -2]; uiSleep 4;
{if (side _x == EAST) then {_x setDamage 1}} forEach ((getPos tBase) nearEntities [["MAN","CAR","APC","TANK","StaticWeapon"], 100]); uiSleep 1;
{_x setPos (getMarkerPos "mMOTS_4")} forEach _a;
"FAHRENHEIT cleared" remoteExec ["systemChat", -2]; uiSleep 5;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;

// Dolores
"Teleporting to Dolores in 5 seconds" remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_5")} forEach _a;
"Clearing Dolores" remoteExec ["systemChat", -2]; uiSleep 2;
{if (side _x == EAST) then {_x setDamage 1}} forEach ((getMarkerPos "mPat_30") nearEntities [["MAN","CAR","APC","TANK","StaticWeapon"], 1200]); uiSleep 2;
"Dolores cleared" remoteExec ["systemChat", -2]; uiSleep 10;

"Mission Objective Test Script completed" remoteExec ["systemChat", -2]; uiSleep 5;
diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) finished";