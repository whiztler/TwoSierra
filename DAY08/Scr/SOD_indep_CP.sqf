if (!isServer) exitWith {};

params ["_cp"];

// CP1 spawn
if (_cp == "CP1_in") exitWith {
	private ["_p", "_u"];
	_p = getPosASL CP_1d;
	
	{_x enableSimulationGlobal true; _x hideObjectGlobal false;} forEach indep_cp1;
		
	CP_1_g1 = createGroup independent; 
	_u = CP_1_g1 createUnit ["I_Soldier_F", _p, [], 0, "SERGEANT"]; _u moveInCommander CP_1a;
	_u = CP_1_g1 createUnit ["I_Soldier_F", _p, [], 0, "CORPORAL"]; _u moveInGunner CP_1a;
	_u = CP_1_g1 createUnit ["I_Soldier_F", _p, [], 0, "SERGEANT"]; _u moveInCommander CP_1b;
	_u = CP_1_g1 createUnit ["I_Soldier_F", _p, [], 0, "CORPORAL"]; _u moveInGunner CP_1b;
	
	CP_1_g2 = [_p, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	CP_1_g3 = [_p, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	[CP_1_g3, _p, 125, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
	
	{{[_x] call ADF_fnc_redressCherno;} forEach units _x;
	_x setVariable ["ADF_noHC_transfer", true];} forEach [CP_1_g1,CP_1_g2,CP_1_g3];
};

// CP1 cache
if (_cp == "CP1_out") exitWith {	
	if !(isNil "CP_1_g1") then {{deleteVehicle _x} forEach units CP_1_g1; deleteGroup CP_1_g1; CP_1_g1 = nil};
	if !(isNil "CP_1_g2") then {{deleteVehicle _x} forEach units CP_1_g2; deleteGroup CP_1_g2; CP_1_g2 = nil};
	if !(isNil "CP_1_g3") then {{deleteVehicle _x} forEach units CP_1_g3; deleteGroup CP_1_g3; CP_1_g3 = nil};
	{_x enableSimulationGlobal false; _x hideObjectGlobal true;} forEach indep_cp1;
};


// CP2 spawn
if (_cp == "CP2_in") exitWith {
	private ["_p"];
	_p = getPosASL CP_2d;
	
	{_x enableSimulationGlobal true; _x hideObjectGlobal false;} forEach indep_CP2;
		
	CP_2_g1 = createGroup independent; 
	_u = CP_2_g1 createUnit ["I_Soldier_F", _p, [], 0, "SERGEANT"]; _u moveInCommander CP_2a;
	_u = CP_2_g1 createUnit ["I_Soldier_F", _p, [], 0, "CORPORAL"]; _u moveInGunner CP_2a;
	_u = CP_2_g1 createUnit ["I_Soldier_F", _p, [], 0, "SERGEANT"]; _u moveInCommander CP_2b;
	_u = CP_2_g1 createUnit ["I_Soldier_F", _p, [], 0, "CORPORAL"]; _u moveInGunner CP_2b;
	
	CP_2_g2 = [_p, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	CP_2_g3 = [_p, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	[CP_2_g3, _p, 125, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
	
	{{[_x] call ADF_fnc_redressCherno;} forEach units _x;
	_x setVariable ["ADF_noHC_transfer", true];} forEach [CP_2_g1,CP_2_g2,CP_2_g3];
};

// CP2 cache
if (_cp == "CP2_out") exitWith {	
	if !(isNil "CP_2_g1") then {{deleteVehicle _x} forEach units CP_2_g1; deleteGroup CP_2_g1; CP_2_g1 = nil};
	if !(isNil "CP_2_g2") then {{deleteVehicle _x} forEach units CP_2_g2; deleteGroup CP_2_g2; CP_2_g2 = nil};
	if !(isNil "CP_2_g3") then {{deleteVehicle _x} forEach units CP_2_g3; deleteGroup CP_2_g3; CP_2_g3 = nil};
	{_x enableSimulationGlobal false; _x hideObjectGlobal true;} forEach indep_CP2;
};


// CP3 spawn
if (_cp == "CP3_in") exitWith {
	private ["_p"];
	_p = getPosASL CP_3d;
	
	{_x enableSimulationGlobal true; _x hideObjectGlobal false;} forEach indep_CP3;
		
	CP_3_g1 = createGroup independent; 
	_u = CP_3_g1 createUnit ["I_Soldier_F", _p, [], 0, "SERGEANT"]; _u moveInCommander CP_2a;
	_u = CP_3_g1 createUnit ["I_Soldier_F", _p, [], 0, "CORPORAL"]; _u moveInGunner CP_2a;
	_u = CP_3_g1 createUnit ["I_Soldier_F", _p, [], 0, "SERGEANT"]; _u moveInCommander CP_2b;
	_u = CP_3_g1 createUnit ["I_Soldier_F", _p, [], 0, "CORPORAL"]; _u moveInGunner CP_2b;
	
	CP_3_g2 = [_p, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	CP_3_g3 = [_p, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	[CP_3_g3, _p, 125, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
	
	{{[_x] call ADF_fnc_redressCherno;} forEach units _x;
	_x setVariable ["ADF_noHC_transfer", true];} forEach [CP_3_g1,CP_3_g2,CP_3_g3];
};

// CP3 cache
if (_cp == "CP3_out") exitWith {	
	if !(isNil "CP_3_g1") then {{deleteVehicle _x} forEach units CP_3_g1; deleteGroup CP_3_g1; CP_3_g1 = nil};
	if !(isNil "CP_3_g2") then {{deleteVehicle _x} forEach units CP_3_g2; deleteGroup CP_3_g2; CP_3_g2 = nil};
	if !(isNil "CP_3_g3") then {{deleteVehicle _x} forEach units CP_3_g3; deleteGroup CP_3_g3; CP_3_g3 = nil};
	{_x enableSimulationGlobal false; _x hideObjectGlobal true;} forEach indep_CP3;
};


// CP4 spawn
if (_cp == "CP4_in") exitWith {
	private ["_p"];
	_p = getPosASL CP_4d;
	
	{_x enableSimulationGlobal true; _x hideObjectGlobal false;} forEach indep_CP4;
		
	CP_4_g1 = createGroup independent; 
	_u = CP_4_g1 createUnit ["I_Soldier_F", _p, [], 0, "SERGEANT"]; _u moveInCommander CP_2a;
	_u = CP_4_g1 createUnit ["I_Soldier_F", _p, [], 0, "CORPORAL"]; _u moveInGunner CP_2a;
	_u = CP_4_g1 createUnit ["I_Soldier_F", _p, [], 0, "SERGEANT"]; _u moveInCommander CP_2b;
	_u = CP_4_g1 createUnit ["I_Soldier_F", _p, [], 0, "CORPORAL"]; _u moveInGunner CP_2b;
	
	CP_4_g2 = [_p, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	CP_4_g3 = [_p, INDEPENDENT, (configFile >> "CfgGroups" >> "INDEP" >> "IND_F" >> "Infantry" >> "HAF_InfSentry")] call BIS_fnc_spawnGroup;
	[CP_4_g3, _p, 125, 4, "MOVE", "SAFE", "RED", "LIMITED", "FILE", 5] call ADF_fnc_footPatrol;
	
	{{[_x] call ADF_fnc_redressCherno;} forEach units _x;
	_x setVariable ["ADF_noHC_transfer", true];} forEach [CP_4_g1,CP_4_g2,CP_4_g3];
};

// CP4 cache
if (_cp == "CP4_out") exitWith {	
	if !(isNil "CP_4_g1") then {{deleteVehicle _x} forEach units CP_4_g1; deleteGroup CP_4_g1; CP_4_g1 = nil};
	if !(isNil "CP_4_g2") then {{deleteVehicle _x} forEach units CP_4_g2; deleteGroup CP_4_g2; CP_4_g2 = nil};
	if !(isNil "CP_4_g3") then {{deleteVehicle _x} forEach units CP_4_g3; deleteGroup CP_4_g3; CP_4_g3 = nil};
	{_x enableSimulationGlobal false; _x hideObjectGlobal true;} forEach indep_CP4;
};