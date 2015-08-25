diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove
if (isServer) then {
	call compile preprocessFileLineNumbers "scr\ADF_redress_NRF.sqf";
	call compile preprocessFileLineNumbers "Core\F\ADF_fnc_createIED.sqf";
	
	///// NRF JOHNSON
	
	// Foot patrols	
	NRF_grp_1 = [getPos oGunshipPad_1, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
	NRF_grp_1 setGroupIdGlobal ["5-1 ALPHA"];

	NRF_grp_2 = [getPos oAirbusPad_1, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
	NRF_grp_2 setGroupIdGlobal ["5-1 BRAVO"];
	
	// Static Defences & Ambient Vehicles
	NRF_grp_3 = CreateGroup WEST; 
	_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "SERGEANT"]; _p moveInGunner oStat_01;
	_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "CORPORAL"]; _p moveInGunner oStat_02;
	_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_03;
	_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_04;
	_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_05;
	_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "CORPORAL"]; _p moveInGunner oStat_06;
	_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_07;
	_p = NRF_grp_3 createUnit ["B_Soldier_F", getPos b_net, [], 0, "PRIVATE"]; _p moveInGunner oStat_08;
	NRF_grp_3 setGroupIdGlobal ["5-1 CHARLIE"];
	
	{{[_x] call ADF_fnc_redressNRF;} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3];
	
	{[_x, position leader _x, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "", "", [1,2,3]] call CBA_fnc_taskPatrol;} forEach [NRF_grp_1,NRF_grp_2];
	
	sleep .5;
	{{_x setObjectTextureGlobal [0, "\a3\characters_f\BLUFOR\Data\clothing_sage_co.paa"];} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3];
	
	// Create random IED's
	_iedMarkerArr = ["mIED_1","mIED_2","mIED_3","mIED_4","mIED_5","mIED_6","mIED_7","mIED_8","mIED_9","mIED_10","mIED_11","mIED_12","mIED_13","mIED_14","mIED_15","mIED_16","mIED_17","mIED_18","mIED_19"];
	for "_i" from 1 to 10 do {
		private ["_iedMarkerPos","_v","_mN","_m","_idx"];
		_iedMarkerPos = _iedMarkerArr call BIS_fnc_selectRandom;
		_idx =  _iedMarkerArr find _iedMarkerPos;
		_iedMarkerArr deleteAt _idx;
		[_iedMarkerPos,100,250,4.5] call ADF_fnc_createRandomIEDs;
	};
	
	// Create Mary
	execVM "Scr\SOD_mary.sqf";
};