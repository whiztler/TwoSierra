diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove

call compile preprocessFileLineNumbers "Scr\ADF_redress_Aegis.sqf";

foggyBottom = [.30,0,0];	
publicVariable "foggyBottom";
0 setFog foggyBottom;
forceWeatherChange;

// Load vehicle Supplies
[MRAP_2PC] execVM "Core\C\ADF_vCargo_B_Car.sqf";
{[_x] execVM "Core\C\ADF_vCargo_B_CarSQD.sqf"} forEach [MRAP_2_1_SQUAD,MRAP_2_2_SQUAD];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIFT.sqf"} forEach [MRAP_2_1_ALPHA,MRAP_2_1_BRAVO,MRAP_2_2_ALPHA,MRAP_2_2_BRAVO];
{[_x] execVM "Core\C\ADF_vCargo_B_CarIWT.sqf"} forEach [MRAP_2_3_WT1,MRAP_2_3_WT2];

///// AEGIS

// Redress Aegis units
{{[_x] call ADF_fnc_redressAegis} forEach units _x} forEach [gAegis_1,gAegis_2,gAegis_3,gAegis_4,gAegis_5,gAegis_6,gAegis_10];

// (Static) defences airport
uAegis_g1_1 moveInGunner sApt_1;
uAegis_g1_2 moveInGunner sApt_2;
uAegis_g1_3 moveInGunner sApt_3;
uAegis_g1_4 moveInGunner sApt_4;

[gAegis_2, getMarkerPos "mAegisText_1", 50, 1, true] call CBA_fnc_taskDefend;

// Oil Storage Facility defence
[gAegis_4, getMarkerPos "mAegisText_2", 50, 1, true] call CBA_fnc_taskDefend;

// Checkpoint defence
uAegis_g5_1 moveInGunner sCP_1;
uAegis_g5_2 moveInGunner sCP_2;

// Airport patrols
[gAegis_3, getMarkerPos "mAegisText_1", 150, 4, "MOVE", "SAFE", "RED", "LIMITED", "", "", [0,0,0]] call CBA_fnc_taskPatrol;
[gAegis_6, getMarkerPos "mAegisText_1", 150, 4, "MOVE", "SAFE", "RED", "LIMITED", "", "", [0,0,0]] call CBA_fnc_taskPatrol;
