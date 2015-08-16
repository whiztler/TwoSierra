// Mission Objective Test Script
// DAY 1

if !(isNil "MotsActive") exitWith {hint "MOTS has already been executed"};
MotsActive = true;
[{systemChat "Mission Objective Test Script started."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 2;
if (isMultiplayer) then {ADF_mots_uArray = playableUnits;} else {ADF_mots_uArray = allPlayers};
if !(ADF_missionInit) then {[{systemChat "Waiting for mission init to finish..."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;};
waitUntil {ADF_missionInit};

{_x setCaptive true; _x allowDamage false} forEach ADF_mots_uArray;

ADF_AO_initTime	= 190;
ADF_setCurTime	= ADF_AO_initTime - time;
ADF_timeMin		= round (ADF_setCurTime / 60);
ADF_timeSec		= round (ADF_setCurTime - 4); uiSleep 2;
ADF_timerSleep	= 20;

[{systemChat format ["Waiting for AO to init (approx %1 minutes!).",ADF_timeMin]},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 2;
while {time < ADF_AO_initTime} do {	
	[{systemChat format ["AO init time remaining %1 seconds",ADF_timeSec]},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;	
	if (ADF_timeSec <= ADF_timerSleep) then {uiSleep ADF_timeSec + 1;} else {uiSleep ADF_timerSleep; ADF_timeSec = ADF_timeSec - 20;};	
};

[{systemChat "Starting MOTS process. Make sure you are NOT in a vehicle!"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 5;

[{systemChat "Teleporting to first objective in 5 seconds: XRAY"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 5;

{_x setCaptive false; _x setPos (vXray modelToWorldVisual [12, -12, 0])} forEach ADF_mots_uArray; uiSleep 2;
[{systemChat "Init XRAY mission process"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 20;
[{systemChat "Destroying XRAY"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 2;

vXray setDamage 1; uiSleep 3;

[{systemChat "XRAY destroyed!"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 3;
[{systemChat "Teleporting to next objective in 20 seconds: BEARCLAW"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 20;

objBearclaw allowDamage false;
{_x setPos (getPos objBearclaw)} forEach ADF_mots_uArray; uiSleep 2;
[{systemChat "Init BEARCLAW mission process"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 20;
_cntQ = nearestObjects [getPos objBearclaw, ["MAN"], 250];
{if ((side _x == INDEPENDENT) && (alive _x) && (_X in _cntQ)) then {deleteVehicle _x}} forEach allUnits;

waitUntil {[{systemChat "Use action menu to 'rescue BEARCLAW'"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 10; BearclawRescued}; 

[{systemChat "BEARCLAW rescued."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 3;
[{systemChat "Teleporting to exfil location (RV ZEBRA) in 5 seconds"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 5;
[{systemChat "Teleporting..."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 1;

{_x setPos (getPos tZebra)} forEach ADF_mots_uArray;
objBearclaw setPos (getPos tZebra);

uiSleep 2;
[{systemChat "Mission Objective Test Script completed"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;  