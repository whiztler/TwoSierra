ADF_fnc_randomPos_IED = {
	// Init
	params ["_p","_r","_rr"];
	private ["_pX","_pY","_d"];
	_d = random 360;
	
	// Create random position from centre & radius
	_pX = (_p select 0) + (_r * sin _d);
	_pY = (_p select 1) + (_r * cos _d);
	
	// new position
	_p = [_pX, _pY, 0];
	if (ADF_debug) then {_mName = format ["obj_%1",round (random 9999)]; _m = createMarker [_mName,_p]; _m setMarkerSize [.7, .7]; _m setMarkerShape "ICON"; _m setMarkerType "mil_dot"; _m setMarkerColor "ColorBLACK"; _m setMarkerText "search pos";};
	
	// Check nearby raods from new position
	_rd		= _p nearRoads _rr;
	_rdPos	= [];
	_rdDir	= 0; // road dir
	
	// if road position found, use it else use original position
	if (count _rd > 0) then {
		_rdSel	= _rd select 0;
		_rdPos	= getPos _rdSel;
		_rdCx	= roadsConnectedTo _rdSel;
		_rdX		= _rdCx select 0;
		_rdDir	= [_rdSel, _rdX] call BIS_fnc_DirTo;		
	} else {_rdPos = _p; _rdDir = 0;};
	if (ADF_debug) then {_mName = format ["obj_%1",round (random 9999)];_m = createMarker [_mName,_rdPos]; _m setMarkerSize [.7, .7]; _m setMarkerShape "ICON"; _m setMarkerType "mil_dot"; _m setMarkerColor "ColorGREEN"; 	_m setMarkerText format ["road pos - %1",round _rdDir];};

	// return the position + dir
	[_rdPos,_rdDir]
};

ADF_fnc_createRandomIEDs = {
	// init
	params ["_passedPos","_radius","_roadDist"];
	private ["_p","_v"];
	_mPos 			= getMarkerPos _passedPos;
	_IED_itemArr		= ["Land_CanisterFuel_F","Land_Tyre_F","Land_CanisterPlastic_F","Land_Sack_F","Land_BucketNavy_F","Land_WaterBarrel_F","Land_GasCanister_F"] call BIS_fnc_selectRandom;
	//_IED_itemArr		= ["IEDLandBig_F","IEDUrbanBig_F","IEDLandSmall_F","IEDUrbanSmall_F"] call BIS_fnc_selectRandom;
	_IED_arr			= [];
	_IED_arrPos		= [];
	_IED_arrDir		= 0;
	_IED_offSet		= 0;	

	// Search for IED locations within the search radius. Try 3 times
	for "_i" from 1 to 3 do { 
		_IED_arr = [_mPos,_radius,_roadDist] call ADF_fnc_randomPos_IED;
		_IED_arrPos = _IED_arr select 0;
		_IED_arrDir = _IED_arr select 1;
		if (isOnRoad _IED_arrPos) exitWith {};
	};
	
	// Debug position found
	if (ADF_debug) then {_v = createVehicle ["Sign_Arrow_Direction_Green_F", _IED_arrPos, [], 0, "NONE"]; _v setDir _IED_arrDir;};
	
	// create offset position
	_IED_offSet = _IED_arrDir + 90;
	_IED_posX = (_IED_arrPos select 0) + (6 * sin _IED_offSet);
	_IED_posY = (_IED_arrPos select 1) + (6 * cos _IED_offSet);	
		
	// create the IED (random object)
	if (ADF_debug) then {_v = createVehicle ["Sign_Arrow_Cyan_F", [_IED_posX,_IED_posY,1], [], 0, "CAN_COLLIDE"]; _v enableSimulationGlobal false;};	
	_v = createVehicle [_IED_itemArr, [_IED_posX,_IED_posY,0], [], 0, "NONE"];	
	
	// Disguise the IED
	_v enableSimulationGlobal false;
	_v setVectorUp [0,0.1,0.01];
	if (_IED_itemArr == "Land_Tyre_F" || _IED_itemArr == "Land_Sack_F" || _IED_itemArr == "Land_WaterBarrel_F") then {
		_v setPosATL [getPosATL _v select 0, getPosATL _v select 1, -.20];
	} else {
		_v setPosATL [getPosATL _v select 0, getPosATL _v select 1, -.05];
	};
	
	// Create the trigger
	_t = createTrigger ["EmptyDetector", _IED_arrPos, false];
	_t setTriggerActivation ["WEST","PRESENT",false];
	_t setTriggerArea [4,3,_IED_offSet,true];
	_t setTriggerTimeout [0,0,0,false];
	_t setTriggerStatements [
		"{vehicle _x in thisList && isPlayer _x && ((getPosATL _x) select 2) < 5} count allUnits > 0;",
		"_bomb_tPos = getPosATL thisTrigger;
		_q = nearestObjects [_bomb_tPos, ['Land_CanisterFuel_F','Land_Tyre_F','Land_CanisterPlastic_F','Land_Sack_F','Land_BucketNavy_F','Land_GasCanister_F'], 8];
		_p = getPos (_q select 0);
		{deleteVehicle _x} forEach _q;
		_b = createVehicle ['HelicopterExploSmall', _p, [], 0, 'NONE'];
		deleteVehicle thisTrigger;
		",
		""
	];
	
	if (ADF_debug) then {_mName = format ["obj_t%1",round (random 9999)];_m = createMarker [_mName,_IED_arrPos]; _m setMarkerSize [4, 3]; _m setMarkerShape "RECTANGLE"; _m setMarkerColor "ColorRED"; _m setMarkerDir _IED_offSet; _m setMarkerType "empty";};
};