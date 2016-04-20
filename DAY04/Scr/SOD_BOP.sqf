// BOP compositions
#include "SOD_BOP_comp.sqf"

// Init
private ["_a", "_test"];
_a 		= ["mOpForBOO_1", "mOpForBOO_2", "mOpForBOO_3", "mOpForBOO_4", "mOpForBOO_5", "mOpForBOO_6", "mOpForBOO_7"];
_test	= false;

// Test all compositions
if (_test) exitWith {
	private ["_p", "_d", "_c", "_n", "_m", "_i", "_r"];
	for "_i" from 1 to 7 do {
		_p = format ["mOpForBOO_%1", _i];
		_d = markerDir _p;
		_p = getMarkerPos _p;
		_c = format ["_ADF_comp_BOP%1", _i];	
		_r = call compile format ["%1", _c];		
		diag_log format ["Marker: %1 --- Composition: %2", _p, _c];
		[_p, _d, _r] call BIS_fnc_ObjectsMapper;
		_n = format ["BopDebug_%1", _i];
		_m = createMarker [_n, getMarkerPos _p];
		_m setMarkerShape "ICON";
		_m setMarkerType "mil_objective";
		_m setMarkerColor "ColorGreen";
		sleep 1;	
		sOpfor_01 allowDamage true;
		sOpfor_05 allowDamage true;
	};	
	hint "BOP's spawned...";
};

_ADF_bopCreate = {
	// init
	params ["_c"];
	private ["_p", "_d"];
	_p = getMarkerPos ADF_bopLoc;
	_d = markerDir ADF_bopLoc;
	
	// Spawn the base of operations
	[_p, _d, _c] call BIS_fnc_ObjectsMapper;
	
	// re-apply damage model
	sOpfor_01 allowDamage true;
	sOpfor_05 allowDamage true;
	
	// Clear the comp array vars from memory
	{_x = nil} forEach [_ADF_comp_BOP1, _ADF_comp_BOP2, _ADF_comp_BOP3, _ADF_comp_BOP4, _ADF_comp_BOP5, _ADF_comp_BOP6, _ADF_comp_BOP7]
	
	
	// Move the spawn trigger
	tBOPspawn setPos _p;
	
	// Create the detect trigger
	tBOPdetect = createTrigger ["EmptyDetector", _p, false];
	tBOPdetect setTriggerActivation ["WEST", "GUER D",false];
	tBOPdetect setTriggerArea [500,500,0,false];
	tBOPdetect setTriggerTimeout [0,0,0,false];
	tBOPdetect setTriggerStatements [
		"this",
		"tBOPlive = true;
		 publicVariable 'tBOPlive';
		 0 = [tBOPdetect,independent,500] execVM 'Core\ADF_DetectSensor.sqf';
		 0 = execVM 'Scr\SOD_BOPlive.sqf';
		",
		""
	];
	
	if (ADF_debug) then {
		_m = createMarker ["tBOPdetectMarker", getPos tBOPdetect];
		_m setMarkerShape "ICON";
		_m setMarkerType "mil_dot";
		_m setMarkerColor "ColorBlack";
		_m setMarkerText "tBOPdetect Trigger 500 x 500";
		
		_m = createMarker ["tBOPdetectMarkerBorder", getPos tBOPdetect];
		_m setMarkerShape "ELLIPSE";
		_m setMarkerType "EMPTY";
		_m setMarkerSize [500,500];
		_m setMarkerColor "ColorBlack";
		_m setMarkerBrush "Border";
	};
	
	// (re)Apply Texture to trucks
	private ["_a", "_q"];
	_a = ["I_Truck_02_transport_F", "I_Truck_02_ammo_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_Repair_F"];
	_q = (getPos tBOPspawn) nearEntities ["Car", 200];

	{
		if ((_x in _q) && ((typeOf _x) in _a)) then {
			_x setObjectTextureGlobal [0, "Img\cusTex_zamak.jpg"]; _X setObjectTextureGlobal [1, "Img\cusTex_pashtun.jpg"]
		};
	} forEach vehicles;
	
	diag_log	"-----------------------------------------------------";
	diag_log format ["TWO SIERRA: Pashtun Base Of Operations created. Position: %1,%2",round(_p select 0),round(_p select 1)];
	diag_log	"-----------------------------------------------------";
	true
};

ADF_bopLoc = _a call BIS_fnc_selectRandom;
publicVariable "ADF_bopLoc";

//debug
if (ADF_debug) then {
	_m = createMarker ["BopDebug", getMarkerPos ADF_bopLoc];
	_m setMarkerShape "ICON";
	_m setMarkerType "mil_objective";
	_m setMarkerColor "ColorGreen";
	
	_m = createMarker ["BopDebugArea", getMarkerPos ADF_bopLoc];
	_m setMarkerShape "ELLIPSE";
	_m setMarkerType "EMPTY";
	_m setMarkerSize [1500,1500];
	_m setMarkerColor "ColorGreen";
	_m setMarkerBrush "DiagGrid";
	_m setMarkerAlpha 0.5;
};

switch ADF_bopLoc do {
	case "mOpForBOO_1" : {[_ADF_comp_BOP1] call _ADF_bopCreate};
	case "mOpForBOO_2" : {[_ADF_comp_BOP2] call _ADF_bopCreate};
	case "mOpForBOO_3" : {[_ADF_comp_BOP3] call _ADF_bopCreate};
	case "mOpForBOO_4" : {[_ADF_comp_BOP4] call _ADF_bopCreate};
	case "mOpForBOO_5" : {[_ADF_comp_BOP5] call _ADF_bopCreate};
	case "mOpForBOO_6" : {[_ADF_comp_BOP6] call _ADF_bopCreate};
	case "mOpForBOO_7" : {[_ADF_comp_BOP7] call _ADF_bopCreate};
};

// Wait till Blufor is close (1500m) to the BOP
waitUntil {
	sleep 10;
	if (time > 10800) exitWith {ADF_Fairlight = true; publicVariable "ADF_Fairlight"}; // set fairlight to TRUE if time > 3 hours
	if (ADF_endMission) exitWith {}; // End mission already started
	tBOPlive
};

// Fairlight protocol. Time is up.
if (ADF_Fairlight) exitWith {};

// Count and track alive OpFor
waitUntil {
	private "_c";
	sleep 25 + (random 5);
	_c = [tBOPspawnPos, independent, 200, "MAN"] call ADF_fnc_countRadius;
	if (ADF_debug) then {systemChat format ["TWO SIERRA debug: BOP opfor remaining: %1", _c];};
	if (time > 12800) exitWith {ADF_Fairlight = true; publicVariable "ADF_Fairlight"};  // set fairlight to TRUE
	_c < 10
};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: End Mission process started";
diag_log	"-----------------------------------------------------";

ADF_endMission = true; publicVariable "ADF_endMission";