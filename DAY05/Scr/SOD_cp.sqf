ADF_fnc_checkDetector = {
	params ["_caller","_rad","_time","_persis"];
	private ["cPos","_uArray","_dist"];
	
	_uArray 	= if (!isMultiplayer) then {switchableUnits} else {playableUnits};
	_cPos	= if (typeName _caller == "STRING") then {getMarkerPos _caller} else {getPosATL _caller}; 
	
	{
		_dist = vehicle _x distance _cPos;
		if (isPlayer _x and _dist < _rad) exitWith {true};
	} forEach _uArray; 
	
};
+
zbe_closestUnit = {
	private["_units", "_unit", "_dist", "_udist"];
	_units = _this select 0;
	_unit = _this select 1;
	_dist = 10^5;
	{_udist = _x distance _unit;
		if (_udist < _dist) then {
			_dist = _udist;};
		} forEach _units;
	_dist;
};