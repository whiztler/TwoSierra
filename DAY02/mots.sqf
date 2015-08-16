// Mission Objective Test Script
// DAY 2

if !(isNil "MotsActive") exitWith {hint "MOTS has already been executed"};
MotsActive = true;
[{systemChat "Mission Objective Test Script started."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 2;
if (isMultiplayer) then {ADF_mots_uArray = playableUnits;} else {ADF_mots_uArray = allPlayers};
if !(ADF_missionInit) then {[{systemChat "Waiting for mission init to finish..."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;};
waitUntil {ADF_missionInit};

{_x setCaptive false; _x allowDamage false} forEach ADF_mots_uArray;

if (isNil "ADF_mots_assaultTimer") then {
	waitUntil {
		[{systemChat "Waiting for server scripts to start..."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 3;
		!isNil "ADF_mots_assaultTimer"
	};
};

ADF_AO_initTime	= ADF_mots_assaultTimer;
ADF_setCurTime	= ADF_AO_initTime - time;
ADF_timeMin		= round (ADF_setCurTime / 60);
ADF_timeSec		= round (ADF_setCurTime - 4); uiSleep 2;
ADF_timerSleep	= 20;

[{systemChat format ["Waiting for AO to init (approx %1 minutes!).",ADF_timeMin]},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 2;
[{systemChat "Init will take a long time (random timed assault). Feel free to roam about."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 2;
while {time < ADF_AO_initTime} do {	
	[{systemChat format ["AO init time remaining %1 seconds",ADF_timeSec]},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;	
	if (ADF_timeSec <= ADF_timerSleep) then {uiSleep ADF_timeSec + 1;} else {uiSleep ADF_timerSleep; ADF_timeSec = ADF_timeSec - 20;};	
};

[{systemChat "Starting MOTS process. Make sure you are NOT in a vehicle!"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 5;

[{systemChat "Teleporting to KENNEDY"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;
{_x setPos (getMarkerPos "mAegisText_1");} forEach ADF_mots_uArray; 

[{systemChat "Clearing the AO of enemies"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 3;
_cntQ = nearestObjects [getMarkerPos "mAegisText_1", ["MAN"], 2000];
{if ((side _x == INDEPENDENT) && (alive _x) && (_X in _cntQ)) then {deleteVehicle _x}} forEach allUnits;
_cntQ = nil;
[{systemChat "Pashtun forces KENNEDY neutralized"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 3;
[{systemChat "Init first AO mission process (60 seconds)"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 60;

[{systemChat "Teleporting to next objective in 5 seconds: Second AO"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 5;

{
	_x setCaptive false;
	_x setPos (getPos tShapur2);
	sleep 1;
	_x setCaptive true;
} forEach ADF_mots_uArray;

[{systemChat "Waiting for second AO to spawn (80 seconds)"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 80;;
[{systemChat "Clearing the second AO of enemies"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 3;
{if ((side _x == INDEPENDENT) && (alive _x)) then {deleteVehicle _x}} forEach allUnits;

[{systemChat "Init second AO mission process"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; uiSleep 40;

[{systemChat "Mission Objective Test Script completed"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;  