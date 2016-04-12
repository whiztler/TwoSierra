diag_log "ADF RPT: Init - executing ADF_redress_CSAT.sqf"; // Reporting. Do NOT edit/remove

ADF_fnc_redressCSAT_skill = {
	params ["_u"];
	_u setskill ['general',(0.15 + random 0.15)];
	_u setskill ['courage', (0.5 + random 0.4)];
	_u setskill ['commanding', (0.5 + random 0.4)];
	_u setskill ['aimingAccuracy', (0.2 + random 0.5)];
	_u setskill ['aimingShake', (0.4 + random 0.3)];
	_u setskill ['aimingSpeed', (0.15 + random 0.15)];
	_u setskill ['endurance', (0.4 + random 0.3)];
	_u setskill ['spotDistance', (0.3 + random 0.3)];
	_u setskill ['spotTime', (0.3 + random 0.2)];
	true
};

ADF_fnc_redressCSAT3 = {
	// init
	params ["_u"];
	private ["_su","_sv","_sb","_ut","_ub"];
	_ut = typeOf _u;
	_ub = false;
	_uv = false;
	_ug = false; // is gren
	
	_xb	= ["O_medic_F","O_Soldier_AAT_F","O_Soldier_A_F","O_Soldier_AAA_F","O_Soldier_AA_F","O_HeavyGunner_F"];
	_so = ["O_Soldier_F","O_Soldier_lite_F","O_Soldier_GL_F","O_Soldier_SL_F","O_Soldier_TL_F","O_Soldier_LAT_F","O_medic_F","O_soldier_repair_F","O_soldier_exp_F","O_Soldier_A_F","O_Soldier_AT_F","O_Soldier_AA_F","O_engineer_F","O_Soldier_AAR_F","O_Soldier_AAT_F","O_Soldier_AAA_F","O_support_MG_F"];
	_mb	= ["O_Soldier_AR_F","O_Soldier_AT_F","O_Soldier_LAT_F","O_Soldier_AAR_F"];
	_gv	= ["O_Soldier_GL_F","O_Soldier_TL_F"];
	_mg	= ["O_HeavyGunner_F","O_Soldier_AR_F"];

	// Store items for transfer into new containers
	_su = uniformItems _u;	
	if ((vest _u) != "") then {_sv = vestItems _u;	removeVest _u; _uv = true};
	if ((backpack _u) != "") then {_sb = backpackItems _u; removeBackpack _u; _ub = true};	
	
	// remove uniform and headgear
	removeUniform _u; removeHeadgear _u;	

	// Add Uniform container and restore uniform gear
	_u forceAddUniform "U_O_PilotCoveralls";	
	
	// Add vest
	_u addVest "V_I_G_resistanceLeader_F";
	
	// Add backpack
	if (_ub) then {
		if (_ut in _xb) then {_u addBackpack "B_Kitbag_cbr"};
		if (_ut in _mb) then {_u addBackpack "B_TacticalPack_ocamo"};
	} else {
		_u addBackpack "B_FieldPack_ocamo";
	};
	
	// Add head gear
	if ((random 1) < 0.90) then {_u addHeadgear (["H_ShemagOpen_khk","H_ShemagOpen_tan","H_Watchcap_khk","H_Watchcap_cbr","H_Bandanna_sand","H_Booniehat_dirty","H_Shemag_tan","H_Cap_tan","H_TurbanO_blk","H_Cap_brn_SPECOPS"] call BIS_fnc_selectRandom)};
	
	// Add goggles	
	if (_ut in _mg) then {
		_u addGoggles "G_Combat"
	} else {
		if ((random 1) > 0.25) then {
			_u addGoggles (["G_Bandanna_tan","G_Bandanna_khk","G_Shades_Black","G_Tactical_Black"] call BIS_fnc_selectRandom)
		};
	};
	
	if (_ut in _so) then {
		private "_pwi";
		_pwi = primaryWeaponItems _u;
		if ("optic_ACO_grn" in _pwi) then {_u removePrimaryWeaponItem "optic_ACO_grn"};
		if ("optic_Arco" in _pwi) then {_u removePrimaryWeaponItem "optic_ACO_grn"};
		if !("acc_pointer_IR" in _pwi) then {_u addPrimaryWeaponItem "acc_pointer_IR"};
		_u addPrimaryWeaponItem "optic_MRCO";
		_u addPrimaryWeaponItem "muzzle_snds_H";
	};
	if (_ut == "O_soldierU_AR_F") then {_u addPrimaryWeaponItem "optic_Arco"};
	if (_ut == "O_HeavyGunner_F") then {_u addPrimaryWeaponItem "muzzle_snds_93mmg_tan"; _u removePrimaryWeaponItem "optic_Arco"; _u addPrimaryWeaponItem "optic_tws_mg"};
	if (_ut == "O_soldier_M_F") then {_u addPrimaryWeaponItem "bipod_02_F_hex"; _u addPrimaryWeaponItem "muzzle_snds_B"};
	if (_ut == "O_Sharpshooter_F") then {_u addPrimaryWeaponItem "muzzle_snds_93mmg"; _u removePrimaryWeaponItem "optic_KHS_blk"; _u addPrimaryWeaponItem "optic_Nightstalker"};
	
	// Add stored items
	{_u addItem _x} forEach _su;
	if (_ub) then {{_u addItemToBackpack _x} forEach _sb};
	if (_uv) then {{_u addItemToVest _x} forEach _sv};

	_u selectWeapon (primaryWeapon _u);
	//_u unassignItem "NVGoggles_OPFOR";
	
	// Insignia
	[_u,"CSAT3Patch"] call BIS_fnc_setUnitInsignia;	
	
	[_u] call ADF_fnc_redressCSAT_skill;
};
