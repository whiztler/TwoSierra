/* DEBUG *************************
0 = execVM "Scr\pashtun.sqf"; [player] call ADF_fnc_redress;
*********************************/

_diagTestStart = diag_tickTime;
diag_log "ADF RPT: Init - executing pashtun.sqf"; // Reporting. Do NOT edit/remove

ADF_fnc_redress_uniforms = {
	private ["_uniform"];
	_uniform = ["U_BG_Guerilla1_1","U_C_Poor_1","U_BG_Guerilla2_3","U_BG_Guerilla3_1","U_I_G_resistanceLeader_F","U_BG_leader","U_C_HunterBody_grn","U_BG_Guerilla2_1","U_BG_Guerilla2_2"] call BIS_fnc_selectRandom;
	_uniform
};

ADF_fnc_redress_priWpn = {
	private ["_weapon"];
	_weapon = [	
		["arifle_Katiba_GL_F","30Rnd_65x39_caseless_green_mag_Tracer",30],
		["arifle_Mk20_plain_F","30Rnd_556x45_Stanag_Tracer_Green",30],
		["LMG_Zafir_F","150Rnd_762x54_Box_Tracer",150],
		["srifle_DMR_01_F","10Rnd_762x54_Mag",10]	
	] call BIS_fnc_selectRandom;
	_weapon
};

ADF_fnc_redress_backpack = {
	private ["_backpack"];
	_backpack = ["B_HuntingBackpack","B_OutdoorPack_blk","B_FieldPack_cbr","B_OutdoorPack_tan"] call BIS_fnc_selectRandom;
	_backpack
};

ADF_fnc_redress_face = {
	private ["_face"];
	_face = ['AfricanHead_01','AfricanHead_02','AfricanHead_03'] call BIS_fnc_selectRandom;
	_face
};

ADF_fnc_redress_voice = {
	private ["_voice"];
	_voice = ["Male01PER","Male02PER","Male03PER"] call Bis_fnc_SelectRandom;
	_voice
};

ADF_fnc_redress_skill = {
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


ADF_fnc_redress = {
	// init
	params ["_unit"];
	private ["_uniform","_priWeaponArr","_priWeapon","_backpack","_face","_voice","_priWeaponMag","_priWeaponMagAm","_enable_AT"];
	_uniform 		= call ADF_fnc_redress_uniforms;
	_priWeaponArr		= call ADF_fnc_redress_priWpn;
	_priWeapon		= _priWeaponArr select 0;	
	_priWeaponMag		= _priWeaponArr select 1;
	_priWeaponMagAm	= _priWeaponArr select 2;
	_face			= call ADF_fnc_redress_face;
	_voice			= call ADF_fnc_redress_voice;
	_enable_AT		= [true,false,true,true,true,false,false] call Bis_fnc_SelectRandom;

	// strip the unit
	removeAllWeapons _unit; removeAllItems _unit; removeAllAssignedItems _unit; removeUniform _unit; removeVest _unit; removeBackpack _unit; removeHeadgear _unit; removeGoggles _unit;

	// Add Uniform container
	_unit forceAddUniform _uniform;
	
	// Add pairing containers
	switch (_uniform) do {
		case "U_BG_Guerilla1_1": {_unit addVest "V_BandollierB_khk"; _unit addHeadgear "H_Bandanna_sand"; _unit addGoggles "G_Bandanna_khk";};
		case "U_C_Poor_1": {_unit addVest "V_BandollierB_oli"; _unit addHeadgear "H_Cap_grn"; _unit addGoggles "G_Bandanna_shades";};
		case "U_BG_Guerilla3_1": {_unit addHeadgear "H_ShemagOpen_tan"; _unit addGoggles "G_Aviator";};
		case "U_I_G_resistanceLeader_F": {_unit addVest "V_HarnessOGL_brn"; _unit addHeadgear "H_ShemagOpen_khk"; _unit addGoggles "G_Shades_Green";};
		case "U_BG_Guerilla2_3": {_unit addVest "V_TacVest_oli"; _unit addHeadgear "H_Shemag_olive"; _unit addGoggles "G_Aviator";};
		case "U_BG_leader": {_unit addVest "V_BandollierB_khk"; _unit addGoggles "G_Bandanna_khk";};
		case "U_C_HunterBody_grn": {_unit addHeadgear "H_ShemagOpen_khk"; _unit addGoggles "G_Sport_BlackWhite";};
		case "U_BG_Guerilla2_1": {_unit addVest "V_HarnessO_gry"; _unit addHeadgear "H_Bandanna_gry"; _unit addGoggles "G_Bandanna_shades";};
		case "U_BG_Guerilla2_2": {_unit addVest "V_Chestrig_oli"; _unit addHeadgear "H_Bandanna_khk"; _unit addGoggles "G_Balaclava_oli";};
		default {_unit addVest "V_BandollierB_khk"; _unit addHeadgear "H_Bandanna_sand"; _unit addGoggles "G_Bandanna_khk";};
	};
	
	// Add Primary weapon & ammo
	_unit addMagazine [_priWeaponMag,_priWeaponMagAm];	
	_unit addWeapon _priWeapon;
	
	// Add backpack
	_backpack = call ADF_fnc_redress_backpack;
	_unit addBackpack _backpack;
			
	// Add Primary Weapon MAgazines & Secondary Weapon (launcher)
	if (_priWeapon == "LMG_Zafir_F") then {
		for "_i" from 1 to 2 do {_unit addMagazine _priWeaponMag};
	} else {
		for "_i" from 1 to 6 do {_unit addMagazine _priWeaponMag};
		if (_enable_AT && _priWeapon == "arifle_Mk20_plain_F") then {[_unit, "launch_RPG32_F", 2, "RPG32_F"] call BIS_fnc_addWeapon;};
	};
	if (_priWeapon == "arifle_Katiba_GL_F") then {for "_i" from 1 to 6 do {_unit addMagazine "1Rnd_HE_Grenade_shell"};};
	
	// Add default items
	_unit linkItem "ItemMap"; _unit linkItem "ItemCompass"; _unit linkItem "ItemWatch"; _unit linkItem "ItemRadio";
	for "_i" from 1 to 2 do {_unit addMagazine "HandGrenade"; _unit addMagazine "SmokeShell"; _unit addMagazine "16Rnd_9x21_Mag"; _unit addMagazine "Chemlight_red"; _unit addItem "FirstAidKit";};
	_unit addWeapon "hgun_Rook40_F";
	
	// Identity
	_unit setFace _face;
	_unit setSpeaker _Voice;

	// Misc
	_unit addPrimaryWeaponItem "acc_flashlight";
	_unit selectWeapon (primaryWeapon _unit);
	
	[_unit] call ADF_fnc_redress_skill;
};
