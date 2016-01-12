if (!isServer) exitWith {};
diag_log "ADF RPT: Init - executing xray_server.sqf"; // Reporting. Do NOT edit/remove

// Init
private ["_xRayLoc","_xRayDir","_v","_m"];
_xRayLoc = ["mXrayCrashSite_1","mXrayCrashSite_2","mXrayCrashSite_3","mXrayCrashSite_4"] call BIS_fnc_selectRandom;
_xRayDir = markerDir _xRayLoc;

// Move heli to predefined ramdom location and apply damage, open cargo doors and add satchels to cargo
vXray allowDamage false;
vXray setPos (getMarkerPos _xRayLoc);
vXray setDir _xRayDir;
vXray allowDamage true; 
vXray setDamage .7;
vXray setHitPointDamage ["HitHRotor", 1];
vXray setHitPointDamage ["HitVRotor", 1];
{vXray animateDoor [_x, 1];} forEach ["door_L","door_R"];
vXray addMagazineCargoGlobal ["SatchelCharge_Remote_Mag", 3];

// Generate crash site crater
_v = createVehicle ["CraterLong", position xRaySmoke, [], 0, "CAN_COLLIDE"];
_v setDir _xRayDir;
_v disableCollisionWith vXray;
_v setPos [getPos vXray select 0, getPos vXray select 1, -.2];

// Generate crash site smoke
smokeIt = "test_EmptyObjectForSmoke" createVehicle position xRaySmoke;
smokeIt disableCollisionWith vXray;
smokeIt attachTo [vXray, [0,0,-1]];
smokeIt hideObject true;
smokeIt = nil;
deleteVehicle xRaySmoke;

// Move crew into helicopter and set damage to 1 (KIA)
xRayCrew_1 moveinDriver vXray; xRayCrew_1 setDamage 1;
xRayCrew_2 moveInTurret [vXray, [0]]; xRayCrew_2 setDamage 1;
xRayCrew_3 moveInCargo vXray; xRayCrew_3 setDamage 1;
xRayCrew_4 moveInTurret [vXray, [2]]; xRayCrew_4 setDamage 1;
xRayCrew_5 moveInTurret [vXray, [1]]; xRayCrew_5 setDamage 1;
{_x = nil} forEach [xRayCrew_1,xRayCrew_2,xRayCrew_3,xRayCrew_4,xRayCrew_5]; // destroy the variables

// Create the crash site marker
_m = createMarker ["mXray", getPos vXray];
_m setMarkerSize [.7, .7];
_m setMarkerShape "ICON";
_m setMarkerType "b_air";
_m setMarkerColor "ColorWEST";
_m setMarkerDir 0;
_m setMarkerText " XRAY";

// Move the trigger to Xray's location
tXray setPosATL (getPosATL vXray);

vXray addEventHandler ["killed", {remoteExec ["ADF_fnc_xRayDestroyed",0,true];}];

ADF_fnc_xRayDestroyed = {
	xRayDestroyed = true; publicVariable "xRayDestroyed";
	diag_log	"-----------------------------------------------------";diag_log "TWO SIERRA: Xray destroyed";diag_log	"-----------------------------------------------------";
	deleteMarker "mXray";
};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: XRAY spawned and set";
diag_log	"-----------------------------------------------------";