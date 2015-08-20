// Mission Objective Test Script
// DAY 3

diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) started";

if !(isNil "MotsActive") exitWith {hint "MOTS has already been executed"};
MotsActive = true;
[{systemChat "Mission Objective Test Script started."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 2;
if (isMultiplayer) then {ADF_mots_uArray = playableUnits;} else {ADF_mots_uArray = allPlayers};
if !(ADF_missionInit) then {[{systemChat "Waiting for mission init to finish..."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;};
waitUntil {ADF_missionInit};

{_x allowDamage false} forEach ADF_mots_uArray;

[{systemChat "Starting MOTS process. Make sure you are NOT in a vehicle!"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 5;
[{systemChat "Teleporting AO spawn trigger location in 5 seconds."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 5;
{_x setPos (getPos tStart)} forEach ADF_mots_uArray; uiSleep 2;

ADF_AO_initTime	= 40  + time;
if (ADF_AO_initTime < 120) then {ADF_setCurTime = 120} else {ADF_setCurTime = ADF_AO_initTime};
ADF_timeMin		= round (ADF_setCurTime / 60); publicVariable "ADF_timeMin";
ADF_timeSec		= round (ADF_setCurTime - 4); uiSleep 2;  publicVariable "ADF_timeSec";
ADF_timerSleep	= 20;

[{systemChat format ["Waiting for AO to init (approx %1 minutes!).",ADF_timeMin]},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 2;
while {time < ADF_AO_initTime} do {	
	[{systemChat format ["AO init time remaining %1 seconds",ADF_timeSec]},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;	
	if (ADF_timeSec <= ADF_timerSleep) then {uiSleep ADF_timeSec + 1;} else {uiSleep ADF_timerSleep; ADF_timeSec = ADF_timeSec - 20; publicVariable "ADF_timeSec"};	
};

{_x setCaptive false; _x setPos (getMarkerPos "mDolphin")} forEach ADF_mots_uArray; uiSleep 2;
[{systemChat "Init DOLPHIN mission process"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 20;
[{systemChat "Neutralizing Pashtun forces"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 3;
_cntQ2 = nearestObjects [getMarkerPos "mDolphin", ["MAN"], 5000];
{if ((side _x == INDEPENDENT) && (alive _x) && (_X in _cntQ2)) then {deleteVehicle _x}} forEach allUnits;
[{systemChat "Pashtun neutralized"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 3;
[{systemChat "Init End Mission mission process"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 20;
[{systemChat "Teleporting back to LMAB in 5 seconds"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 5;
{_x setPos (getMarkerPos "mMOTS_end")} forEach ADF_mots_uArray; uiSleep 2;

[{systemChat "Mission Objective Test Script completed"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;

diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) finished";