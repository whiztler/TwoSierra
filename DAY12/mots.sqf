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
		"Waiting for the AO to finish initializing. Please be patient. Init can take up to 10 minutes..." remoteExec ["systemChat", -2]; uiSleep 20;
		ADF_init_AO
	};	
	"Done initializing the AO." remoteExec ["systemChat", -2]; uiSleep 2;
};

waitUntil {
	"Waiting for the second wave to spawn. Please be patient...." remoteExec ["systemChat", -2]; uiSleep 20;
	ADF_motsSpawned
};	

"All Para's spawned." remoteExec ["systemChat", -2]; uiSleep 2;
"Clearing the AO" remoteExec ["systemChat", -2];

{if (side _x == EAST) then {_x setDamage 1}} forEach ((getMarkerPos "mOpforScan") nearEntities [["MAN","CAR","APC","TANK","StaticWeapon"], 650]); uiSleep 5;
"Corazol cleared" remoteExec ["systemChat", -2]; uiSleep 5;

"Mission Objective Test Script completed" remoteExec ["systemChat", -2]; uiSleep 5;
diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) finished";