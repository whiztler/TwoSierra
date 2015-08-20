diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove
if (isServer) then {
	
	///// NRF LMAB
	
	// Static Defences
	NRF_grp_4 = CreateGroup WEST; 
	_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "SERGEANT"]; _p moveInGunner oStat_01;
	_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "CORPORAL"]; _p moveInGunner oStat_02;
	_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "CORPORAL"]; _p moveInGunner oStat_03;
	_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "PRIVATE"]; _p moveInGunner oStat_04;
	_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "PRIVATE"]; _p moveInGunner oStat_05;
	_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "PRIVATE"]; _p moveInGunner oStat_06;
	_p = NRF_grp_4 createUnit ["B_Soldier_F", getPos oLand_1, [], 0, "PRIVATE"]; _p moveInGunner oStat_07;
	{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_4;
	NRF_grp_4 setGroupIdGlobal ["5-3 CHARLIE"];
	
	// Foot patrols	
	NRF_grp_1 = [getPos oLand_1, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_1;
	NRF_grp_1 setGroupIdGlobal ["5-1 ALPHA"];
	[NRF_grp_1, position leader NRF_grp_1, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "", "", [1,2,3]] call CBA_fnc_taskPatrol;

	NRF_grp_2 = [getPos oLand_2, WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_2;
	NRF_grp_2 setGroupIdGlobal ["5-1 BRAVO"];
	[NRF_grp_2, position leader NRF_grp_2, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "", "", [1,2,3]] call CBA_fnc_taskPatrol;
	
	NRF_grp_3 = [getPos (b_net), WEST, (configFile >> "CfgGroups" >> "WEST" >> "BLU_F" >> "Infantry" >> "BUS_InfSentry")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressNRF;} forEach units NRF_grp_3;
	NRF_grp_3 setGroupIdGlobal ["5-2 ALPHA"];
	[NRF_grp_3, position leader NRF_grp_3, 150, 3, "MOVE", "SAFE", "RED", "LIMITED", "", "", [1,2,3]] call CBA_fnc_taskPatrol;	
	
	sleep .5;
	{{_x setObjectTextureGlobal [0, "\a3\characters_f\BLUFOR\Data\clothing_sage_co.paa"];} forEach units _x} forEach [NRF_grp_1,NRF_grp_2,NRF_grp_3,NRF_grp_4];
	
};