// Mission Objective Test Script
// DAY 3

diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) started";

if !(isNil "MotsActive") exitWith {hint "MOTS has already been executed"};
MotsActive 		= true;
ADF_mots_uArray	= allPlayers;

"Mission Objective Test Script started." remoteExec ["systemChat", -2]; sleep 2;

if !(ADF_missionInit) then {"Waiting for mission init to finish..." remoteExec ["systemChat", -2];};
waitUntil {ADF_missionInit};

{_x allowDamage false} forEach ADF_mots_uArray;

if (!ADF_init_AO) then {
	waitUntil {
		"Waiting for the AO to finish initializing..." remoteExec ["systemChat", -2]; uiSleep 5;
		ADF_init_AO
	};	
	"Done initializing the AO." remoteExec ["systemChat", -2]; uiSleep 2;
};

"Starting MOTS process. Make sure you are NOT in a vehicle!" remoteExec ["systemChat", -2]; uiSleep 5;
"Teleporting to DOLPHIN in 5 seconds..." remoteExec ["systemChat", -2]; uiSleep 5;

{_x setCaptive false; _x setPos (getMarkerPos "mDolphin")} forEach ADF_mots_uArray; uiSleep 2;
"Init DOLPHIN mission process" remoteExec ["systemChat", -2]; uiSleep 25;

"Neutralizing Pashtun forces" remoteExec ["systemChat", -2]; 
execVM "Core\ADF_simpleStats.sqf"; uiSleep 3;
_cntQ2 = nearestObjects [getMarkerPos "mDolphin", ["MAN"], 5000];
{if ((side _x == INDEPENDENT) && (alive _x) && (_X in _cntQ2)) then {deleteVehicle _x}} forEach allUnits;
"Pashtun neutralized" remoteExec ["systemChat", -2];  uiSleep 3;
"Init End Mission mission process" remoteExec ["systemChat", -2];  uiSleep 25;
"Teleporting back to LMAB in 5 seconds" remoteExec ["systemChat", -2];  uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_end")} forEach ADF_mots_uArray; uiSleep 2;

"Mission Objective Test Script completed" remoteExec ["systemChat", -2];

diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) finished";