// Mission Objective Test Script
// DAY 1

diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) started";

if !(isNil "MotsActive") exitWith {hint "MOTS has already been executed"};
MotsActive = true;
[{systemChat "Mission Objective Test Script started."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 2;
if (isMultiplayer) then {ADF_mots_uArray = playableUnits;} else {ADF_mots_uArray = allPlayers};
if !(ADF_missionInit) then {[{systemChat "Waiting for mission init to finish..."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;};
waitUntil {ADF_missionInit};

{_x setCaptive true; _x allowDamage false} forEach ADF_mots_uArray;

ADF_AO_initTime	= 190;
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

[{systemChat "Teleporting to first objective in 5 seconds: XRAY"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 5;

{_x setCaptive false; _x setPos (vXray modelToWorldVisual [12, -12, 0])} forEach ADF_mots_uArray; uiSleep 2;
[{systemChat "Init XRAY mission process"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 20;
[{systemChat "Destroying XRAY"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 2;

vXray setDamage 1; uiSleep 3;

[{systemChat "XRAY destroyed!"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 3;

[{systemChat "Teleporting to next objective in 20 seconds: BEARCLAW AO"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 20;
{_x setPos (getMarkerPos "mMOTS_alpha")} forEach ADF_mots_uArray; uiSleep 2;
[{systemChat "Waiting to for the AO to finish init"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 15;

[{systemChat "Teleporting to next objective in 5 seconds: BEARCLAW"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;
_cntQ = nearestObjects [getPos objBearclaw, ["MAN"], 500];
{if ((side _x == INDEPENDENT) && (alive _x) && (_X in _cntQ)) then {deleteVehicle _x}} forEach allUnits;
uiSleep 6;

{_x setPos (getPos objBearclaw)} forEach ADF_mots_uArray; uiSleep 2;
[{systemChat "Init BEARCLAW mission process"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;
waitUntil {[{systemChat "Use action menu to 'rescue BEARCLAW'"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 15; BearclawRescued;};
objBearclaw allowDamage false;

[{systemChat "BEARCLAW rescued."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 3;
[{systemChat "Teleporting to exfil location (RV ZEBRA) in 5 seconds"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 5;
[{systemChat "Teleporting..."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 1;

{_x setPos (getPos tZebra)} forEach ADF_mots_uArray;
objBearclaw setPos (getPos tZebra);

uiSleep 2;
[{systemChat "Mission Objective Test Script completed"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; 

diag_log "ADF RPT: Debug - Mission Objective Test Script (MOTS) finished";