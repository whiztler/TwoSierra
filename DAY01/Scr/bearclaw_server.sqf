if (!isServer) exitWith {};
diag_log "ADF RPT: Init - executing bearclaw_server.sqf"; // Reporting. Do NOT edit/remove

// Init
private ["_bearclawLoc","_bearclawDir"];
_bearclawLoc = ["mBearclawLoc_1","mBearclawLoc_2","mBearclawLoc_3","mBearclawLoc_4","mBearclawLoc_5","mBearclawLoc_6","mBearclawLoc_7","mBearclawLoc_8","mBearclawLoc_9"] call BIS_fnc_selectRandom;
//_bearclawLoc = "mBearclawLoc_9"; // debug
_bearclawDir = markerDir _bearclawLoc;

// reDress
removeAllWeapons objBearclaw; removeAllItems objBearclaw; removeAllAssignedItems objBearclaw; removeVest objBearclaw; removeBackpack objBearclaw; removeHeadgear objBearclaw; removeGoggles objBearclaw;
objBearclaw forceAddUniform "U_I_G_Story_Protagonist_F";
objBearclaw addVest "V_BandollierB_blk";
objBearclaw addHeadgear "H_Watchcap_blk";
objBearclaw linkItem "ItemMap";
objBearclaw setFace "WhiteHead_22_a";
objBearclaw setSpeaker "Male10ENG";

// Behaviour etc
gBearclaw allowFleeing 0;
gBearclaw setCombatMode "BLUE";
gBearclaw setBehaviour "CARELESS";

// Relocate to captive position
objBearclaw allowDamage false;
objBearclaw setPos (getMarkerPos _bearclawLoc);
objBearclaw setDir _bearclawDir;
objBearclaw allowDamage true;
objBearclaw setDamage .1;
objBearclaw SetUnitPos "down";
//objBearclaw disableAI "MOVE";

// Move Obj trigger to captive position
tObjBearclaw setPos (getPos objBearclaw);

if (ADF_debug) then {
	_m = createMarker ["mBearClawPos", getPos objBearclaw];
	_m setMarkerSize [1, 1];
	_m setMarkerShape "ICON";
	_m setMarkerType "mil_dot";
	_m setMarkerColor "ColorWEST";
	_m setMarkerDir 0;
	_m setMarkerText " Bearclaw";
};

waitUntil {sleep 3; BearclawRescued};
objBearclaw enableAI "MOVE";

{deleteMarker _x} forEach ["mSector_Alpha","mSector_AlphaTxt","mSector_Bravo","mSector_bravoTxt"];

// Create Zebra reception party
{
	_x enableSimulationGlobal true;
	_x hideObjectGlobal false;
	_x allowDammage false;
} forEach [vZebra_1,vZebra_2,vZebra_3,vZebra_4,vZebra_5,vZebra_6,vZebra_7,vZebra_8,vZebra_9];

_g = CreateGroup WEST; 
_p = _g createUnit ["B_crew_F",getPos tZebra,[],0,"CAPTAIN"]; _p moveInCommander vZebra_1;
_p = _g createUnit ["B_crew_F",getPos tZebra,[],0,"CORPORAL"]; _p moveInGunner vZebra_1;
_p = _g createUnit ["B_crew_F",getPos tZebra,[],0,"LIEUTENANT"]; _p moveInCommander vZebra_2;
_p = _g createUnit ["B_crew_F",getPos tZebra,[],0,"CORPORAL"]; _p moveInGunner vZebra_2;
_p = _g createUnit ["B_Soldier_F",getPos tZebra,[],0,"PRIVATE"]; _p moveInGunner vZebra_3;

// Create retaliation
for "_i" from 1 to 2 do {
	private ["_spawnPos","_spawnDir","_v","_cX","_vX"];
	_spawnPos = "mGuerVeh_2";
	_spawnDir = markerDir _spawnPos;

	_c = createGroup INDEPENDENT;
	_v = [getMarkerPos _spawnPos, _spawnDir, "I_G_Offroad_01_armed_F", _c] call BIS_fnc_spawnVehicle;
	_cX = units _c; {[_x] call ADF_fnc_redress} forEach _cX;
	_vX = _v select 0;
	[_vX, "ADF_opforOffroad", nil] call bis_fnc_initVehicle;
	_wp = _c addWaypoint [getPos objBearclaw, 0];
	_wp setWaypointType "MOVE"; _wp setWaypointBehaviour "SAFE"; _wp setWaypointSpeed "FULL"; _wp setWaypointCompletionRadius 30;
	_wp = _c addWaypoint [getPos objBearclaw, 0];
	_wp setWaypointType "SAD"; _wp setWaypointSpeed "LIMITED";
	sleep 25;
};