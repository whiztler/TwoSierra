if (!isDedicated && (isNull player)) then {waitUntil {!(isNull player)}; waitUntil {player == player}};

diag_log "ADF RPT: Init - executing ADF_redress_CSAT.sqf"; // Reporting. Do NOT edit/remove

ADF_fnc_redressCSAT_skill = {
	params ["_u"];
	_u setskill ['general',(0.5 + random 0.5)];
	_u setskill ['courage',1];
	_u setskill ['commanding', (0.5 + random 0.5)];
	_u setskill ['aimingAccuracy', (0.2 + random 0.5)];
	_u setskill ['aimingShake', (0.3 + random 0.5)];
	_u setskill ['aimingSpeed', (0.2 + random 0.5)];
	_u setskill ['spotDistance', (0.5 + random 0.3)];
	_u setskill ['spotTime', (0.5 + random 0.3)];
	true
};

ADF_fnc_redressCSAT3 = {
	// init
	params ["_u"];
	private ["_su","_sv","_sb","_ut","_ub"];
	_ut = typeOf _u;
	_ub = false; // has backpack
	_uv = false; // has vest
	_ug = false; // is gren
	
	_xb	= ["O_medic_F","O_Soldier_AAT_F","O_Soldier_A_F","O_Soldier_AAA_F","O_Soldier_AA_F","O_HeavyGunner_F"];
	_mb	= ["O_Soldier_AR_F","O_Soldier_AT_F","O_Soldier_LAT_F","O_Soldier_AAR_F"];
	_gv	= ["O_Soldier_GL_F","O_Soldier_TL_F"];
	_mg	= ["O_HeavyGunner_F","O_Soldier_AR_F"];

	// Store items for transfer into new containers
	_su = uniformItems _u;	
	if ((vest _u) != "") then {_sv = vestItems _u;	_uv = true};
	if ((backpack _u) != "") then {_sb = backpackItems  _u;	_ub = true};	
	
	// remove uniform and headgear
	removeUniform _u; removeHeadgear _u;	

	// Add Uniform container and restore uniform gear
	_u forceAddUniform "U_O_PilotCoveralls";	
	
	// Add vest and restore vest items
	if (_uv) then {
		if (_ut in _xb || _ut in _mb || _ut in _gv) then {removeVest _u; _u addVest "V_PlateCarrier2_rgr"};	
	} else {
		_u addVest "V_PlateCarrierIA2_dgtl";
	};
	
	// Add backpack and restore backpack items
	if (_ub) then {
		if (_ut in _xb) then {removeBackpack _u; _u addBackpack "B_Kitbag_cbr"};
		if (_ut in _mb) then {removeBackpack _u; _u addBackpack "B_TacticalPack_ocamo"};
	} else {
		_u addBackpack "B_FieldPack_ocamo";
	};
	
	// Add head gear
	if ((random 1) < 0.75) then {_u addHeadgear (["H_ShemagOpen_khk","H_ShemagOpen_tan","H_Watchcap_khk","H_Shemag_olive_hs","H_Booniehat_khk_hs","H_MilCap_ocamo"] call BIS_fnc_selectRandom)};
	
	// Add goggles	
	if (_ut in _mg) then {
		_u addGoggles "G_Combat"
	} else {
		if ((random 1) > 0.75) then {
			_u addGoggles (["G_Tactical_Clear","G_Aviator","G_Shades_Black","G_Tactical_Black"] call BIS_fnc_selectRandom)
		}
	};
	
	// Add stored items
	{_u addItem _x} forEach _su;
	if (_ub) then {{_u addItemToBackpack _x} forEach _sb};
	if (_uv) then {{_u addItemToVest _x} forEach _sv};

	_u selectWeapon (primaryWeapon _u);
	_u unassignItem "NVGoggles_OPFOR";
	
	// Insignia
	[_u,"CSAT3Patch"] call BIS_fnc_setUnitInsignia;	
	
	[_u] call ADF_fnc_redressCSAT_skill;
};

{_x call ADF_fnc_redressCSAT3} forEach allUnits;
//{_x call ADF_fnc_redressCSAT3} forEach Allplayers;