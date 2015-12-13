// Mission Objective Test Script
// DAY 8

diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) started";

if (MotsActive) exitWith {hint "MOTS has already been executed"};
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

"Eliminating oposing forces..." remoteExec ["systemChat", -2];
execVM "Core\ADF_simpleStats.sqf" uiSleep 5;
{if ((side _x == EAST) && (alive _x)) then {_x setDamage 1}} forEach allUnits;

"Mission Objective Test Script completed" remoteExec ["systemChat", -2];

diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) finished";