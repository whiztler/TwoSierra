// BOP compositions
#include "SOD_BOP_comp.sqf"

// Init
_ADF_bopLocArr 		= ["mOpForBOO_1","mOpForBOO_2","mOpForBOO_3","mOpForBOO_4","mOpForBOO_5","mOpForBOO_6","mOpForBOO_7"];
_ADF_debug_testALL	= false;

// Test all compositions
if (_ADF_debug_testALL) exitWith {
	private ["_p","_pos","_d","_c","_n","_m","_i","_r"];
	for "_i" from 1 to 7 do {
		_p = format ["mOpForBOO_%1",_i];
		_pos = getMarkerPos _p;
		_d = markerDir _p;
		_c = format ["_ADF_comp_BOP%1",_i];	
		_r = call compile format ["%1",_c];		
		diag_log format ["Marker: %1 --- Composition: %2",_p,_c];
		[_pos,_d,_r] call BIS_fnc_ObjectsMapper;
		_n = format ["BopDebug_%1",_i];
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
	params ["_ADF_bopComp"];
	private ["_ADF_bopLocPos","_ADF_bopLocDir"];
	_ADF_bopLocPos = getMarkerPos ADF_bopLoc;
	_ADF_bopLocDir = markerDir ADF_bopLoc;
	
	// Spawn the base of operations
	[_ADF_bopLocPos,_ADF_bopLocDir,_ADF_bopComp] call BIS_fnc_ObjectsMapper;
	
	// re-apply damage model
	sOpfor_01 allowDamage true;
	sOpfor_05 allowDamage true;
	
	// Clear the comp array vars from memory
	_ADF_comp_BOP1 = nil; _ADF_comp_BOP2 = nil; _ADF_comp_BOP3 = nil; _ADF_comp_BOP4 = nil; _ADF_comp_BOP5 = nil; _ADF_comp_BOP6 = nil; _ADF_comp_BOP7 = nil; 
	
	// Move the spawn trigger
	tBOPspawn setPos _ADF_bopLocPos;
	
	// Create the detect trigger
	tBOPdetect = createTrigger ["EmptyDetector", _ADF_bopLocPos, false];
	tBOPdetect setTriggerActivation ["WEST","GUER D",false];
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
	_vReTexArr = ["I_Truck_02_transport_F","I_Truck_02_ammo_F","I_Truck_02_box_F","I_Truck_02_fuel_F","I_Truck_02_Repair_F"];
	_vReTexQue = nearestObjects [tBOPspawn, ["Car"], 200];

	{
		if ((_x in _vReTexQue) && ((typeOf _x) in _vReTexArr)) then {
			_x setObjectTextureGlobal [0, "Img\cusTex_zamak.jpg"]; _X setObjectTextureGlobal [1, "Img\cusTex_pashtun.jpg"]
		};
	} forEach vehicles;
	
	diag_log	"-----------------------------------------------------";
	diag_log format ["TWO SIERRA: Pashtun Base Of Operations created. Position: %1,%2",round(_ADF_bopLocPos select 0),round(_ADF_bopLocPos select 1)];
	diag_log	"-----------------------------------------------------";
	true
};

ADF_bopLoc = _ADF_bopLocArr call BIS_fnc_selectRandom;
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

if (ADF_bopLoc == "mOpForBOO_1") then {[_ADF_comp_BOP1] call _ADF_bopCreate};
if (ADF_bopLoc == "mOpForBOO_2") then {[_ADF_comp_BOP2] call _ADF_bopCreate};
if (ADF_bopLoc == "mOpForBOO_3") then {[_ADF_comp_BOP3] call _ADF_bopCreate};
if (ADF_bopLoc == "mOpForBOO_4") then {[_ADF_comp_BOP4] call _ADF_bopCreate};
if (ADF_bopLoc == "mOpForBOO_5") then {[_ADF_comp_BOP5] call _ADF_bopCreate};
if (ADF_bopLoc == "mOpForBOO_6") then {[_ADF_comp_BOP6] call _ADF_bopCreate};
if (ADF_bopLoc == "mOpForBOO_7") then {[_ADF_comp_BOP7] call _ADF_bopCreate};

// Win mission criteria
_opforCntBOP = 50; // pax/crews spawned at BOP (incl reinforcement)
_opforCntWin = 10;

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
	sleep 30;
	_vBOPpaxQue = nearestObjects [tBOPspawnPos, ["MAN"], 200];
	_cnt = {(side _x == INDEPENDENT) && (alive _x) && (_x in _vBOPpaxQue)} count allUnits;
	if (ADF_debug) then {systemChat format ["TWO SIERRA debug: BOP opfor remaining: %1",_cnt];};
	if (time > 10800) exitWith {ADF_Fairlight = true; publicVariable "ADF_Fairlight"};  // set fairlight to TRUE
	_cnt < _opforCntWin
};

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: End Mission process started";
diag_log	"-----------------------------------------------------";

ADF_endMission = true; publicVariable "ADF_endMission";



