ADF_fnc_checkPosition = {
	params ["_p"];
	private ["_return"];
	_return = switch (typeName _p) do {
		case "STRING" : {getMarkerPos _p}; // Marker	
		case "OBJECT" : {getPosATL _p}; // object / vehicle / etc/
		case "GROUP" : {	getPosATL (leader _p)}; // group - returns the position of the current group leader
		default {position _p}; // None of the above
	};
	_return
};

ADF_fnc_checkDistance = {
	params ["_a","_b"];
	private ["_return","_pos_a","_pos_b"];
	_pos_a	= _a call ADF_fnc_checkPosition; // get the position of the first param
	_pos_b	= _b call ADF_fnc_checkPosition; // get the position of the second param
	_return	= _pos_a distance2D _pos_b; // return the distance between the first and the second param
	_return
};

ADF_fnc_checkClosest = {
	params ["_a","_b",["_r",10^5,[0]]];	
	private ["_return"];
	_return = _r + 1;
	{
		_return = [_x, _b] call ADF_fnc_checkDistance;
		systemChat format ["ADF_fnc_checkClosest: distance to CP_1d: %1 meters",_return];
		if (_return < _r) then {_r = _return};
	} forEach _a;
	_return	
};

ADF_fnc_sensor = {
	params ["_a","_b","_r","_s","_P"];
	private [""];
	
	//if (typeName _code == "CODE") then {_code = format ["%1", _code]};
	
	waitUntil {
		_check = [_a, _b, _r] call ADF_fnc_checkClosest;
		_exit = false;
		if (_check < _r) then {
		
			hint "< 800";

			if (_p = false) then {_exit = true; _s = 0;};
		};
		sleep _s;
		_exit
	};
	hint "ADF_fnc_sensor exit";
};

[
	player, // (player) array to check against
	object, // object/vehicle/marker to check distance to players
	800, // radius
	5, // sleep
	true // true = persistent sensor, false = non-persistent
] call ADF_fnc_sensor;


//_uArray 	= if (!isMultiplayer) then {switchableUnits} else {playableUnits}; // define array of players
_uArray 	= allPlayers;

while {true} do {
	_check = [
		_uArray,	// all players
		CP_1d,	// onject/marker to check distance to players
		800		// radius to check
	] call ADF_fnc_checkClosest;
	systemChat format ["LOOP: distance to CP_1d: %1 meters",_check];
	if (_check < 800) then {
		hint "< 800";
	};
	sleep 15;
};