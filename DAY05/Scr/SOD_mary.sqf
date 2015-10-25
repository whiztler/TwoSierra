// Init
_ADF_debug_testALL	= false;

ADF_maryLoc = ["mObj1","mObj2","mObj3","mObj4"] call BIS_fnc_selectRandom;
publicVariable "ADF_maryLoc";

// Test all compositions
if (_ADF_debug_testALL) exitWith {
	private ["_p","_pos","_d","_c","_n","_m","_i","_r"];
	for "_i" from 1 to 4 do {
		_p = format ["mObj%1",_i];
		_pos = getMarkerPos _p;
		_d = markerDir _p;
		_c = _stMaryComp;	
		diag_log format ["Marker: %1 --- Composition: %2",_p,_c];
		[_pos,_d,_c] call BIS_fnc_ObjectsMapper;
		_n = format ["MaryDebug_%1",_i];
		_m = createMarker [_n, getMarkerPos _p];
		_m setMarkerShape "ICON";
		_m setMarkerType "mil_objective";
		_m setMarkerColor "ColorGreen";
		sleep 1;	
	};	
	hint "Mary comps's spawned...";
};

_ADF_maryCreate = {
	// init
	params ["_ADF_maryComp"];
	private ["_ADF_maryLocPos","_ADF_maryLocDir"];
	_ADF_maryLocPos = getMarkerPos ADF_maryLoc;
	_ADF_maryLocDir = markerDir ADF_maryLoc;
	
	// Spawn the base of operations
	[_ADF_maryLocPos,_ADF_maryLocDir,_ADF_maryComp] call BIS_fnc_ObjectsMapper;
	
	// Clear the comp array vars from memory
	_stMaryComp = nil;
	
	// Move and position the spawn trigger
	tObj setPos _ADF_maryLocPos;
	tObj setDir _ADF_maryLocDir;
	
	// Create the St Mary's location marker
	_m = createMarker ["mObjPos", getPos oMary];
	_m setMarkerSize [.7, .7];
	_m setMarkerShape "ICON";
	_m setMarkerType "n_med";
	_m setMarkerColor "ColorWhite";
	_m setMarkerDir 0;
	_m setMarkerText " ST. MARY";
	
	diag_log	"-----------------------------------------------------";
	diag_log format ["TWO SIERRA: St. Mary's created. Position: %1,%2",round(_ADF_maryLocPos select 0),round(_ADF_maryLocPos select 1)];
	diag_log	"-----------------------------------------------------";
	true
};

//debug
if (ADF_debug) then {
	_m = createMarker ["MarybugArea", getMarkerPos ADF_maryLoc];
	_m setMarkerShape "rectangle";
	_m setMarkerDir (markerDir ADF_maryLoc);
	_m setMarkerType "EMPTY";
	_m setMarkerSize [25,20];
	_m setMarkerColor "ColorGreen";
	_m setMarkerBrush "DiagGrid";
	_m setMarkerAlpha 0.5;
};

[_stMaryComp] call _ADF_maryCreate;

// Foot patrols around Mary
for "_i" from 1 to 3 do {
	private ["_g","_spawnPos"];
	_spawnPos = getMarkerPos ADF_maryLoc;
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;

	[_g, _spawnPos, 500, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
};