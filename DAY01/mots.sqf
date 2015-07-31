// Mission Objective Test Script
// DAY 1

if !(isNil "MotsActive") exitWith {hint "MOTS has already been executed"};
MotsActive = true;

[{systemChat "Mission Objective Test Script started..."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;  
while {time < 120} do {
	[{systemChat "Waiting for mission init to finish (2 minutes!)."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;
	uiSleep 20;
};
waitUntil {time > 120};
sleep 3;
[{systemChat "Teleporting to first objective: XRAY"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;  

{
	_x setcaptive true;
	_x allowDamage false;
	_x setPos (vXray modelToWorldVisual [12, -12, 0]);
} forEach playableUnits;
sleep 3;

[{systemChat "Destroying XRAY"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;  

vXray setDamage 1; sleep 3;


[{systemChat "XRAY destroyed!"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 3;
[{systemChat "Teleporting to next objective: BEARCLAW"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 2;

{_x setPos (getPos objBearclaw)} forEach playableUnits; sleep 3;

[{systemChat "Use action menu to 'rescue BEARCLAW'"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 2;
waitUntil {BearclawRescued}; sleep 3;

[{systemChat "Teleporting to exfil location (RV ZEBRA) in 5 seconds"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 5;
[{systemChat "Teleporting..."},"BIS_fnc_call",true,false] spawn BIS_fnc_MP; sleep 1;

{
	_x setCaptive false;
	_x setPos (getPos tZebra);	
} forEach playableUnits;
objBearclaw setPos (getPos tZebra);

sleep 2;
[{systemChat "Mission Objective Test Script completed"},"BIS_fnc_call",true,false] spawn BIS_fnc_MP;  