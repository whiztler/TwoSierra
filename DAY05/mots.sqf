// Mission Objective Test Script
// DAY 5

diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) started";

if !(isNil "MotsActive") exitWith {hint "MOTS has already been executed"};
MotsActive = true;
[{systemChat "Mission Objective Test Script started."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 2;
if (isMultiplayer) then {ADF_mots_uArray = playableUnits;} else {ADF_mots_uArray = allPlayers};
if !(ADF_missionInit) then {[{systemChat "Waiting for mission init to finish..."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;};
waitUntil {ADF_missionInit};

{_x allowDamage false} forEach ADF_mots_uArray;

ADF_AO_initTime	= 60;
ADF_setCurTime	= ADF_AO_initTime - time;
ADF_timeMin		= round (ADF_setCurTime / 60); publicVariable "ADF_timeMin";
ADF_timeSec		= round (ADF_setCurTime - 4); uiSleep 2;  publicVariable "ADF_timeSec";
ADF_timerSleep	= 20;

[{systemChat format ["Waiting for AO to init (approx %1 minutes!).",ADF_timeMin]},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 2;
while {time < ADF_AO_initTime} do {	
	[{systemChat format ["AO init time remaining %1 seconds",ADF_timeSec]},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;	
	if (ADF_timeSec <= ADF_timerSleep) then {uiSleep ADF_timeSec + 1;} else {uiSleep ADF_timerSleep; ADF_timeSec = ADF_timeSec - 20; publicVariable "ADF_timeSec"};	
};

[{systemChat "Starting MOTS process. Make sure you are NOT in a vehicle!"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 5;

[{systemChat "Teleporting to the objective in 5 seconds: MARY"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 5;
private "_rd";
vObj1 allowDamage false;
_rd = [getPos oMary, 200] call ADF_fnc_roadPos;	
vObj1 setPos _rd;
{_x setCaptive false; _x setPos _rd} forEach ADF_mots_uArray; uiSleep 2;
(ADF_mots_uArray select 0) moveInDriver vObj1;
[{systemChat "Drive the Medical Truck to Mary and wait for mission trigger to start"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;
waitUntil {triggerActivated tObj};
[{systemChat "Driver, please disembark the medical truck."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 2;
[{systemChat "AO mission process"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 2;
{_x setCaptive true;} forEach ADF_mots_uArray; uiSleep 88;

[{systemChat "Teleporting back to BOGOTA AB in 5 seconds"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 5;
{_x setCaptive false} forEach ADF_mots_uArray;
{_x setPos (getMarkerPos "mFargo")} forEach ADF_mots_uArray; uiSleep 2;

[{systemChat "Mission Objective Test Script completed"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;

diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) finished";