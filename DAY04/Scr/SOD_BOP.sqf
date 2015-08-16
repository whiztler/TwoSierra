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

ADF_fnc_BOPactive = {
	// Spawn defence squads
	for "_i" from 1 to 3 do {
		private ["_g","_gX","_spawnPos"];
		_spawnPos = getPos tBOPspawn;
		_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSquad")] call BIS_fnc_spawnGroup;
		_gX = units _g; {[_x] call ADF_fnc_redressPashtun} forEach _gX;
		[_g, _spawnPos, 200, 1, true] call CBA_fnc_taskDefend;	
	};
	
	// Spawn patrol teams
	for "_i" from 1 to 5 do {
		private ["_g","_gX","_spawnPos"];
		_spawnPos = getPos tBOPspawn;
		_g = [_spawnPos, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
		_gX = units _g; {[_x] call ADF_fnc_redressPashtun} forEach _gX;
		[_g, _spawnPos, 300, 3, "MOVE", "SAFE", "RED", "LIMITED", "", "", [0,0,0]] call CBA_fnc_taskPatrol;
	};
	
	// Static Vehicles/MG/AT/etc
	private ["_g","__p","_gX"];
	_g = CreateGroup INDEPENDENT; 
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_01; // Mortar
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_02; // HMG small bunker 1 
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_03; // HMG small bunker 2
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_04; // GMG tower
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_05; // HMG tower
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_06; // Madrid
	_p = _g createUnit ["I_Soldier_F", getPos tBOPspawn, [], 0, "PRIVATE"]; _p moveInGunner sOpfor_07; // Strider
	_gX = units _g; {[_x] call ADF_fnc_redressPashtun} forEach _gX;
	
	// Delete the spawn trigger
	tBOPspawnPos = getPos tBOPspawn;
	deleteVehicle tBOPspawn;
	true
};

ADF_fnc_BOPreenforce = {
	// Init
	private ["_c","_cX","_wp","_v","_t"];
	
	// enable the vehicles
	{_x hideObject false; _x enableSimulationGlobal false;} forEach [vOpforAPC_1,vOpforAPC_2,vOpforAPC_3];
	
	// Crew the vehicles and give them orders
	for "_i" from 1 to 3 do {
		_t = format ["vOpforAPC_%1",_i];
		_v = call compile format ["%1",_t];	
		_wpPos = getPos tBOPdetect;
		_c = CreateGroup INDEPENDENT; 
		_p = _c createUnit ["I_Crew_F", getMarkerPos "reEnfor", [], 0, "LIEUTENANT"]; _p moveInCommander _v;
		_p = _c createUnit ["I_Crew_F", getMarkerPos "reEnfor", [], 0, "SERGEANT"]; _p moveInGunner _v;
		_p = _c createUnit ["I_Crew_F", getMarkerPos "reEnfor", [], 0, "CORPORAL"]; _p moveInDriver _v;
		_cX = units _c; {[_x] call ADF_fnc_redressPashtun} forEach _cX;
		_wp = _c addWaypoint [_wpPos, 0]; _wp setWaypointType "SAD"; _wp setWaypointBehaviour "COMBAT"; _wp setWaypointSpeed "FULL"; _wp setWaypointCombatMode "RED";
	};
	true
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
		"0 = [tBOPdetect,independent,500] execVM 'Core\ADF_DetectSensor.sqf'; if (ADF_HC_execute) then {[] call ADF_fnc_BOPreenforce}; tBOPlive = true; publicVariable 'tBOPlive';",
		""
	];
	
	// (re)Apply Texture to trucks
	_vReTexArr = ["I_Truck_02_transport_F","I_Truck_02_ammo_F","I_Truck_02_box_F","I_Truck_02_fuel_F","I_Truck_02_Repair_F"];
	_vReTexQue = nearestObjects [tBOPspawn, ["Car"], 200];

	{
		if ((_x in _vReTexQue) && ((typeOf _x) in _vReTexArr)) then {
			_x setObjectTextureGlobal [0, "Img\NRF_cusTex_zamak.jpg"]; _X setObjectTextureGlobal [1, "Img\NRF_cusTex_pashtun.jpg"]
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
_opforCntWin = 5;

// Wait till Blufor is close (1500m) to the BOP
waitUntil {
	sleep 10;
	if (time > 10800) exitWith {ADF_Fairlight = true; publicVariable "ADF_Fairlight"}; // set fairlight to TRUE
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
	_cnt <= _opforCntWin
};

// Create the trigger at FOB Johnson for succes or failed mission
tEndMission = createTrigger ["EmptyDetector", getMarkerPos "mJohnson", true];
tEndMission setTriggerActivation ["WEST","PRESENT",false];
tEndMission setTriggerArea [75,50,143,true];
tEndMission setTriggerTimeout [0,0,0,false];
tEndMission setTriggerStatements ["{vehicle _x in thisList && isPlayer _x && ((getPosATL _x) select 2) < 5} count allUnits > 0;","",""];

// Fairlight protocol. Time is up.

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: End Mission process started";
diag_log	"-----------------------------------------------------";

ADF_endMission = true; publicVariable "ADF_endMission";



