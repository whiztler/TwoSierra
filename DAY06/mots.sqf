// Mission Objective Test Script
// DAY 6

diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) started";

if !(isNil "MotsActive") exitWith {hint "MOTS has already been executed"};
MotsActive = true;
[{systemChat "Mission Objective Test Script started."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 2;
if (isMultiplayer) then {ADF_mots_uArray = playableUnits;} else {ADF_mots_uArray = allPlayers};
if !(ADF_missionInit) then {[{systemChat "Waiting for mission init to finish..."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;};
waitUntil {ADF_missionInit};

{_x allowDamage false} forEach ADF_mots_uArray;

ADF_AO_initTime	= 180;
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

[{systemChat "Teleporting to the AO, just for scenery"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 5;

{_x setPos (getMarkerPos "mGuerPaxPatrol_2")} forEach ADF_mots_uArray; uiSleep 2;

[{systemChat "Detonating first random cache"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 2;
cacheObj1 setDamage 1;
[{systemChat "Waiting for 'Cache destroyed' messages'"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 40;
[{systemChat "Detonating second random cache"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 2;
cacheObj2 setDamage 1;
[{systemChat "Waiting for 'Cache destroyed' messages'"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 40;
[{systemChat "Detonating third random cache"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 2;
cacheObj3 setDamage 1;
[{systemChat "Waiting for 'Cache destroyed' messages'"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 40;
[{systemChat "Detonating fourth random cache"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 2;
cacheObj4 setDamage 1;
[{systemChat "Waiting for 'Cache destroyed' messages'"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 40;
[{systemChat "Detonating filth random cache"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 2;
cacheObj5 setDamage 1;
[{systemChat "Waiting for 'Cache destroyed' messages'"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 40;

[{systemChat "Teleporting back to BGOGOTA AB in 5 seconds"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 5;
{_x setCaptive false} forEach ADF_mots_uArray;
{_x setPos (getMarkerPos "mFargo")} forEach ADF_mots_uArray; uiSleep 2;

[{systemChat "Mission Objective Test Script completed"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;

diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) finished";