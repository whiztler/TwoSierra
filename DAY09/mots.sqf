// Mission Objective Test Script
// DAY 9

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

private "_t"
_t = time

tFoxtrotBase enableSimulation true;
tFoxtrotAmmo enableSimulation true;
tHotelSupply enableSimulation true;
tGolfFuel enableSimulation true;

"Starting MOTS process. Make sure you are NOT in a vehicle!" remoteExec ["systemChat", -2]; uiSleep 5;

"Teleporting to the AO in 5 seconds..." remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_1")} forEach _a; sleep 3;

waitUntil {sleep 10; "Waiting for AI's to settle in..." remoteExec ["systemChat", -2]; time = _t + 60};

// FOXTROT
"Teleporting to FOXTROT in 5 seconds" remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_2")} forEach _a;
"Stay inside the hangar..." remoteExec ["systemChat", -2]; uiSleep 20;
"Clearing FOXTROT" remoteExec ["systemChat", -2]; uiSleep 2;
{_x setDamage 1} forEach [vAA_1,vAA_2];
{if (side _x == EAST) then {_x setDamage 1}} forEach nearestObjects [getMarkerPos "mFoxtrot", ["MAN","CAR","APC","TANK","StaticWeapon"], 100]; uiSleep 5;
"FOXTROT cleared" remoteExec ["systemChat", -2]; uiSleep 5;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
waitUntil {uiSleep 5; "Exit the hangar and appraoch the CSAT vehicles at center of the FOXTROT base" remoteExec ["systemChat", -2]; triggerActivated tFoxtrotBase};
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
private "_m";
_m = createMarker ["mMotsAmmo", getPos tFoxtrotAmmo]; _m setMarkerText "AMMO CACHE"; _m setMarkerShape "ICON"; _m setMarkerType "mil_dot"; _m setMarkerSize [.75, .75]; _m setMarkerColor "ColorWEST"; 	
waitUntil {uiSleep 5; "Enter the hangar marked 'AMMO CACHE'." remoteExec ["systemChat", -2]; triggerActivated tFoxtrotAmmo};
deleteMarker "mMotsAmmo";
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;

// ROMEO
"Teleporting to ROMEO in 5 seconds" remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mRomeo")} forEach _a;
"Waiting for ROMEO conditions to trigger" remoteExec ["systemChat", -2]; uiSleep 10;
"Clearing ROMEO" remoteExec ["systemChat", -2]; uiSleep 2;
{if (side _x == EAST) then {_x setDamage 1}} forEach nearestObjects [getMarkerPos "mRomeo", ["MAN","CAR","APC","TANK","StaticWeapon"], 50]; uiSleep 5;
"ROMEO cleared" remoteExec ["systemChat", -2]; uiSleep 5;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;

// ECHO
"Teleporting to ECHO in 5 seconds" remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_3")} forEach _a;
"Waiting for ECHO conditions to trigger" remoteExec ["systemChat", -2]; uiSleep 10;
"Clearing ECHO" remoteExec ["systemChat", -2]; uiSleep 2;
{if (side _x == EAST) then {_x setDamage 1}} forEach nearestObjects [getMarkerPos "mEcho", ["MAN","CAR","APC","TANK","StaticWeapon"], 50]; uiSleep 5;
"ECHO cleared" remoteExec ["systemChat", -2]; uiSleep 10;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;

// GOLF
"Teleporting to GOLF in 5 seconds" remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_4")} forEach _a;
"Stay inside the barn..." remoteExec ["systemChat", -2]; uiSleep 10;
"Clearing GOLF" remoteExec ["systemChat", -2]; uiSleep 2;
{if (side _x == EAST) then {_x setDamage 1}} forEach nearestObjects [getMarkerPos "mGOLF", ["MAN","CAR","APC","TANK","StaticWeapon"], 55]; uiSleep 5;
"GOLF cleared" remoteExec ["systemChat", -2]; uiSleep 5;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
private "_m"; _m = createMarker ["mMotsFuel", getPos tGolfFuel]; _m setMarkerText "FUEL DUMP"; _m setMarkerShape "ICON"; _m setMarkerType "mil_dot"; _m setMarkerSize [.75, .75]; _m setMarkerColor "ColorWEST"; 	
waitUntil {"Exit the barn and approach the fuel dump at GOLF" remoteExec ["systemChat", -2]; uiSleep 5; triggerActivated tGolfFuel;};
deleteMarker "mMotsFuel";
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;

// DELTA
"Teleporting to DELTA in 5 seconds" remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_5")} forEach _a;
"Waiting for DELTA conditions to trigger" remoteExec ["systemChat", -2]; uiSleep 10;
"Clearing DELTA" remoteExec ["systemChat", -2]; uiSleep 2;
{if (side _x == EAST) then {_x setDamage 1}} forEach nearestObjects [getMarkerPos "mDELTA", ["MAN","CAR","APC","TANK","StaticWeapon"], 80]; uiSleep 5;
"DELTA cleared" remoteExec ["systemChat", -2]; uiSleep 10;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;

// HOTEL
"Teleporting to HOTEL in 5 seconds" remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_4")} forEach _a;
"Stay inside the barn..." remoteExec ["systemChat", -2]; uiSleep 10;
"Clearing HOTEL" remoteExec ["systemChat", -2]; uiSleep 2;
{if (side _x == EAST) then {_x setDamage 1}} forEach nearestObjects [getMarkerPos "mHOTEL", ["MAN","CAR","APC","TANK","StaticWeapon"], 75]; uiSleep 5;
"HOTEL cleared" remoteExec ["systemChat", -2]; uiSleep 5;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
private "_m"; _m = createMarker ["mMotsSupply", getPos tHotelSupply]; _m setMarkerText "SUPPLIES"; _m setMarkerShape "ICON"; _m setMarkerType "mil_dot"; _m setMarkerSize [.75, .75]; _m setMarkerColor "ColorWEST"; 	
waitUntil {"Exit the barn and enter the hangar marked 'SUPPLIES'" remoteExec ["systemChat", -2]; uiSleep 5; triggerActivated tHotelSupply;};
deleteMarker "mMotsSupply";
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;

// CARAZOL
"All side obectives cleared" remoteExec ["systemChat", -2]; uiSleep 5;
"Teleporting to the starting AO position in 5 seconds..." remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_1")} forEach _a; sleep 6;
"Clearing the Carazol AO" remoteExec ["systemChat", -2]; uiSleep 3;
{if (side _x == EAST) then {_x setDamage 1}} forEach nearestObjects [getMarkerPos "mPat_3", ["MAN","CAR","APC","TANK","StaticWeapon"], 750]; uiSleep 5;
"Carazol cleared." remoteExec ["systemChat", -2]; uiSleep 3;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;
"Waiting for mission messages to finish" remoteExec ["systemChat", -2]; uiSleep 20;

// CALVIN
"Teleporting to the CALVIN base in 5 seconds..." remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_7")} forEach _a; sleep 6;
"Clearing the CALVIN AO" remoteExec ["systemChat", -2]; uiSleep 3;
{if (side _x == EAST) then {_x setDamage 1}} forEach nearestObjects [getMarkerPos "mCalvin",  ["MAN","CAR","APC","TANK","StaticWeapon"], 1500]; uiSleep 5;
"CALVIN cleared." remoteExec ["systemChat", -2]; uiSleep 3;


"Mission Objective Test Script completed" remoteExec ["systemChat", -2]; uiSleep 5;
diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) finished";