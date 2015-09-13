diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove
call compile preprocessFileLineNumbers "Scr\ADF_fnc_createIED.sqf";

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD,MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA,MRAP_2_1_BRAVO,MRAP_2_2_ALPHA,MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1,MRAP_2_3_WT2];
	
// Create random IED's
_iedMarkerArr = ["mIED_1","mIED_2","mIED_3","mIED_4","mIED_5","mIED_6","mIED_7","mIED_8","mIED_9","mIED_10","mIED_11","mIED_12"];
for "_i" from 1 to 6 do {
	private ["_iedMarkerPos","_v","_mN","_m","_idx"];
	_iedMarkerPos = _iedMarkerArr call BIS_fnc_selectRandom;
	_idx =  _iedMarkerArr find _iedMarkerPos;
	_iedMarkerArr deleteAt _idx;
	[_iedMarkerPos,100,250] call ADF_fnc_createRandomIEDs;
};
