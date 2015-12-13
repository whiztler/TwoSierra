// Mission Objective Test Script
// DAY 2

diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) started";

if !(isNil "MotsActive") exitWith {hint "MOTS has already been executed"};
MotsActive 		= true;
ADF_mots_uArray	= allPlayers;

"Mission Objective Test Script started." remoteExec ["systemChat", -2]; sleep 2;

if !(ADF_missionInit) then {"Waiting for mission init to finish..." remoteExec ["systemChat", -2];};
waitUntil {ADF_missionInit};

{_x setCaptive false; _x allowDamage false} forEach ADF_mots_uArray;

if (isNil "ADF_mots_assaultTimer") then {
	waitUntil {
		"Waiting for server scripts to finish..." remoteExec ["systemChat", -2]; uiSleep 3;
		!isNil "ADF_mots_assaultTimer"
	};
};

ADF_AO_initTime	= ADF_mots_assaultTimer;
ADF_setCurTime	= ADF_AO_initTime - time;
ADF_timeMin		= round (ADF_setCurTime / 60); publicVariable "ADF_timeMin";
ADF_timeSec		= round (ADF_setCurTime - 4); uiSleep 2;  publicVariable "ADF_timeSec";
ADF_timerSleep	= 20;

[{systemChat format ["Waiting for AO to init (approx %1 minutes!).",ADF_timeMin]},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 2;
"Init will take a long time (random timed assault). Feel free to roam about. Teleporting to KENNEDY in 5 seconds" remoteExec ["systemChat", -2]; uiSleep 5;
{_x setPos (getMarkerPos "mAegisText_1");} forEach ADF_mots_uArray; 
while {time < ADF_AO_initTime} do {	
	[{systemChat format ["AO init time remaining %1 seconds",ADF_timeSec]},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;	
	if (ADF_timeSec <= ADF_timerSleep) then {uiSleep ADF_timeSec + 1;} else {uiSleep ADF_timerSleep; ADF_timeSec = ADF_timeSec - 20; publicVariable "ADF_timeSec"};	
};

"Starting MOTS process. Make sure you are NOT in a vehicle!" remoteExec ["systemChat", -2]; uiSleep 5;
"Clearing the AO of enemies" remoteExec ["systemChat", -2];
execVM "Core\ADF_simpleStats.sqf"; uiSleep 3;
_cntQ = nearestObjects [getMarkerPos "mAegisText_1", ["MAN"], 2000];
{if ((side _x == INDEPENDENT) && (alive _x) && (_X in _cntQ)) then {deleteVehicle _x}} forEach allUnits;
_cntQ = nil;
"Pashtun forces KENNEDY neutralized" remoteExec ["systemChat", -2]; uiSleep 3;
"Init first AO mission process (60 seconds" remoteExec ["systemChat", -2]; uiSleep 60;
"Teleporting to next objective in 5 seconds: Second AO" remoteExec ["systemChat", -2]; uiSleep 5;

{
	_x setCaptive false;
	_x setPos (getPos tShapur2);
	sleep 1;
	_x setCaptive true;
} forEach ADF_mots_uArray;

"Waiting for second AO to spawn (80 seconds)" remoteExec ["systemChat", -2]; uiSleep 80;
"Clearing the second AO of enemies" remoteExec ["systemChat", -2]; uiSleep 80;
execVM "Core\ADF_simpleStats.sqf"; uiSleep 3;
{if ((side _x == INDEPENDENT) && (alive _x)) then {deleteVehicle _x}} forEach allUnits;

"Init second AO mission process" remoteExec ["systemChat", -2]; uiSleep 40;
"Mission Objective Test Script completed" remoteExec ["systemChat", -2]; 

diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) finished";