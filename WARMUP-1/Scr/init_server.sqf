diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove
if (isServer) then {
	call compile preprocessFileLineNumbers "Scr\ADF_fnc_createIED.sqf";
	
	// Create random IED's
	_iedMarkerArr = ["mIED_1","mIED_2","mIED_3","mIED_4","mIED_5","mIED_6","mIED_7","mIED_8","mIED_9","mIED_10","mIED_11","mIED_12"];
	for "_i" from 1 to 6 do {
		private ["_iedMarkerPos","_v","_mN","_m","_idx"];
		_iedMarkerPos = _iedMarkerArr call BIS_fnc_selectRandom;
		_idx =  _iedMarkerArr find _iedMarkerPos;
		_iedMarkerArr deleteAt _idx;
		[_iedMarkerPos,100,250] call ADF_fnc_createRandomIEDs;
	};
}; // close isServer