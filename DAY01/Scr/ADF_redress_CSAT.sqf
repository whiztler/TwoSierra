diag_log "ADF RPT: Init - executing ADF_redress_CSAT.sqf"; // Reporting. Do NOT edit/remove

ADF_fnc_redressCSAT_skill = {
	params ["_unit"];
	_unit setskill ['general',(0.5 + random 0.5)];
	_unit setskill ['courage',1];
	_unit setskill ['commanding', (0.5 + random 0.5)];
	_unit setskill ['aimingAccuracy', (0.2 + random 0.5)];
	_unit setskill ['aimingShake', (0.3 + random 0.5)];
	_unit setskill ['aimingSpeed', (0.2 + random 0.5)];
	_unit setskill ['spotDistance', (0.5 + random 0.3)];
	_unit setskill ['spotTime', (0.5 + random 0.3)];
	true
};

ADF_fnc_redressCSAT = {
	// init
	params ["_unit"];

	// strip the unit
	removeAllWeapons _unit; removeAllItems _unit; removeAllAssignedItems _unit; removeUniform _unit; removeVest _unit; removeBackpack _unit; removeHeadgear _unit; removeGoggles _unit;

	// Add Uniform container
	_unit forceAddUniform "U_O_CombatUniform_ocamo";
	
	// Add Primary weapon & ammo
	_unit addMagazine ["30Rnd_65x39_caseless_green",30];	
	_unit addWeapon "arifle_Katiba_ACO_pointer_F";
	_unit addHeadgear "H_HelmetSpecO_ocamo";
	
	// Add backpack
	//_unit addBackpack "B_FieldPack_ocamo";
	_unit addVest "V_HarnessO_brn";
			
	// Add Primary Weapon MAgazines & Secondary Weapon (launcher)
	for "_i" from 1 to 6 do {_unit addMagazine "30Rnd_65x39_caseless_green"};
	
	// Add default items
	_unit linkItem "ItemMap"; _unit linkItem "ItemCompass"; _unit linkItem "ItemWatch"; _unit linkItem "ItemRadio";
	for "_i" from 1 to 2 do {_unit addMagazine "HandGrenade"; _unit addMagazine "SmokeShell"; _unit addMagazine "16Rnd_9x21_Mag"; _unit addMagazine "Chemlight_red"; _unit addItem "FirstAidKit";};
	_unit addWeapon "hgun_Rook40_F";
	
	// Identity
	_unit setFace "PersianHead_A3_01";

	// Misc
	_unit addPrimaryWeaponItem "acc_flashlight";
	_unit selectWeapon (primaryWeapon _unit);
	
	[_unit] call ADF_fnc_redressCSAT_skill;
};