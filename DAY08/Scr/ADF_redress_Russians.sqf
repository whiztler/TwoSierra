diag_log "ADF RPT: Init - executing ADF_redress_Russians.sqf"; // Reporting. Do NOT edit/remove

ADF_fnc_redressRussian_skill = {
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

ADF_fnc_redressRussian_priWpn = {
	private ["_weapon"];
	_weapon = [	
		["arifle_Katiba_F","30Rnd_65x39_caseless_green_mag_Tracer",30],
		["arifle_Katiba_GL_F","30Rnd_65x39_caseless_green_mag_Tracer",30],
		["srifle_DMR_04_F","10Rnd_127x54_Mag",10],
		["srifle_DMR_05_tan_f","10Rnd_93x64_DMR_05_Mag",10],
		["MMG_01_tan_F","150Rnd_93x64_Mag",150],
		["SMG_02_F","30Rnd_9x21_Mag",30]
	] call BIS_fnc_selectRandom;
	_weapon
};

ADF_fnc_redressRussian = {
	// init
	params ["_unit"];
	private ["_uniform","_priWeaponArr","_priWeapon","_priWeaponMag","_priWeaponMagAm","_enable_AT","_clipCount"];
	_priWeaponArr		= call ADF_fnc_redressRussian_priWpn;
	_priWeapon		= _priWeaponArr select 0;	
	_priWeaponMag		= _priWeaponArr select 1;
	_priWeaponMagAm	= _priWeaponArr select 2;
	_enable_AT		= [true,false,true,true,true,false,false] call Bis_fnc_SelectRandom;
	_clipCount		= 3;

	// strip the unit
	removeAllWeapons _unit; removeAllItems _unit; removeAllAssignedItems _unit; removeUniform _unit; removeVest _unit; removeBackpack _unit; removeHeadgear _unit; removeGoggles _unit;

	// Add generic containers
	_unit forceAddUniform "U_O_CombatUniform_ocamo";
	_unit addVest "V_PlateCarrier1_rgr";
	_unit addHeadgear "H_HelmetIA";
	_unit addGoggles "G_Balaclava_oli";
	
	// Add Primary weapon & ammo
	_unit addMagazine [_priWeaponMag,_priWeaponMagAm];
	_unit addWeapon _priWeapon;
	_unit addPrimaryWeaponItem "acc_pointer_IR";
	
	switch (_priWeapon) do {
		case "arifle_Katiba_F"			: {_clipCount = 7; _unit addPrimaryWeaponItem "optic_MRCO"; _unit addPrimaryWeaponItem "muzzle_snds_H";};
		case "arifle_Katiba_GL_F"		: {_clipCount = 7; _unit addPrimaryWeaponItem "optic_MRCO"; _unit addPrimaryWeaponItem "muzzle_snds_H"; _unit addBackpack "B_AssaultPack_dgtl"; for "_i" from 1 to 8 do {_unit addMagazine "1Rnd_HE_Grenade_shell"}};
		case "srifle_DMR_04_F"			: {_clipCount = 4; _unit addPrimaryWeaponItem "optic_KHS_hex"; _unit addPrimaryWeaponItem "bipod_03_F_oli";};
		case "srifle_DMR_05_tan_f"		: {_clipCount = 3; _unit addPrimaryWeaponItem "optic_KHS_tan"; _unit addPrimaryWeaponItem "bipod_02_F_tan";};
		case "MMG_01_tan_F"				: {_clipCount = 4; _unit addPrimaryWeaponItem "optic_tws_mg"; _unit addPrimaryWeaponItem "bipod_02_F_hex"; _unit addBackpack "B_Kitbag_sgg";};
		case "SMG_02_F"					: {_clipCount = 9; _unit addPrimaryWeaponItem "muzzle_snds_L"; _unit addPrimaryWeaponItem "optic_Nightstalker";};
		default 							  {_clipCount = 7;};
	};	

	for "_i" from 1 to _clipCount do {_unit addMagazine _priWeaponMag};
	
	// Add AT to Kariba soldier?
	if (_enable_AT && _priWeapon == "arifle_Katiba_F") then {_unit addBackpack "B_Kitbag_sgg"; [_unit, "launch_I_Titan_short_F", 2, "Titan_AT"] call BIS_fnc_addWeapon;};
	
	// Add default items
	_unit linkItem "ItemMap"; _unit linkItem "ItemCompass"; _unit linkItem "ItemWatch"; _unit linkItem "ItemRadio";
	for "_i" from 1 to 2 do {_unit addMagazine "HandGrenade"; _unit addMagazine "SmokeShell"; _unit addMagazine "16Rnd_9x21_Mag"; _unit addMagazine "Chemlight_red"; _unit addItem "FirstAidKit";};
	_unit addWeapon "hgun_Rook40_F";
	
	// Identity
	_unit setFace "WhiteHead_04";

	// Misc
	_unit addPrimaryWeaponItem "acc_flashlight";
	_unit selectWeapon (primaryWeapon _unit);	
	
	[_unit] call ADF_fnc_redressRussian_skill;
	
	_unit setObjectTextureGlobal [0, "\a3\characters_f\OPFOR\Data\clothing_rus_co.paa"];
	[_unit,"RussianPatch"] call BIS_fnc_setUnitInsignia;
};