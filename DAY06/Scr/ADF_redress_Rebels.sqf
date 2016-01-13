diag_log "ADF RPT: Init - executing ADF_redress_Rebels.sqf"; // Reporting. Do NOT edit/remove

ADF_fnc_redressRebel_uniforms = {
	private ["_uniform"];
	_uniform = ["U_C_WorkerCoveralls","U_I_pilotCoveralls","U_BG_Guerilla1_1","U_IG_leader","U_IG_Guerilla3_2","U_IG_Guerilla3_1","U_BG_leader","U_C_HunterBody_grn","U_I_G_resistanceLeader_F","U_BG_Guerilla2_2","U_IG_Guerilla2_3"] call BIS_fnc_selectRandom;
	_uniform
};

ADF_fnc_redressRebel_priWpn = {
	private ["_weapon"];
	_weapon = [	
		["arifle_Katiba_GL_F","30Rnd_65x39_caseless_green_mag_Tracer",30],
		["arifle_Mk20_plain_F","30Rnd_556x45_Stanag_Tracer_Green",30],
		["LMG_Zafir_F","150Rnd_762x54_Box_Tracer",150],
		["srifle_DMR_01_F","10Rnd_762x54_Mag",10]	
	] call BIS_fnc_selectRandom;
	_weapon
};

ADF_fnc_redressRebel_backpack = {
	private ["_backpack"];
	_backpack = ["B_HuntingBackpack","B_OutdoorPack_blk","B_FieldPack_cbr","B_OutdoorPack_tan"] call BIS_fnc_selectRandom;
	_backpack
};

ADF_fnc_redressRebel_vest = {
	private ["_vest"];
	_vest = ["V_HarnessOGL_brn","V_BandollierB_oli","V_TacVest_oli","V_BandollierB_khk","V_HarnessO_gry","V_Chestrig_oli"] call BIS_fnc_selectRandom;
	_vest
};

ADF_fnc_redressRebel_headGear = {
	private ["_headGear"];
	_headGear = ["H_Bandanna_khk","H_Bandanna_camo","H_Cap_grn","H_Hat_camo"] call BIS_fnc_selectRandom;
	_headGear
};

ADF_fnc_redressRebel_Goggles = {
	private ["_headGear"];
	_headGear = ["G_Balaclava_blk","G_Bandanna_beast","G_Bandanna_oli"] call BIS_fnc_selectRandom;
	_headGear
};

ADF_fnc_redressRebel_face = {
	private ["_face"];
	_face = ["WhiteHead_02","WhiteHead_03","WhiteHead_04","WhiteHead_05","WhiteHead_06","WhiteHead_07","WhiteHead_08","WhiteHead_09","WhiteHead_10","WhiteHead_11","WhiteHead_12","WhiteHead_13","WhiteHead_14","WhiteHead_15"	] call BIS_fnc_selectRandom;
	_face
};

ADF_fnc_redressRebel_skill = {
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

ADF_fnc_redressRebel = {
	// init
	params ["_unit"];
	private ["_uniform","_priWeaponArr","_priWeapon","_backpack","_face","_vest","_priWeaponMag","_priWeaponMagAm","_enable_AT","_headGear","_fiftyFifty","_goggles"];
	_uniform 		= call ADF_fnc_redressRebel_uniforms;
	_priWeaponArr		= call ADF_fnc_redressRebel_priWpn;
	_priWeapon		= _priWeaponArr select 0;	
	_priWeaponMag		= _priWeaponArr select 1;
	_priWeaponMagAm	= _priWeaponArr select 2;
	_vest			= call ADF_fnc_redressRebel_vest;
	_backpack 		= call ADF_fnc_redressRebel_backpack;
	_headGear		= call ADF_fnc_redressRebel_headGear;
	_goggles			= call ADF_fnc_redressRebel_Goggles;
	_face			= call ADF_fnc_redressRebel_face;
	_enable_AT		= [true,false,true,true,true,false,false] call Bis_fnc_SelectRandom;
	_fiftyFifty		= [0,1,1,0] call BIS_fnc_selectRandom;

	// strip the unit
	removeAllWeapons _unit; removeAllItems _unit; removeAllAssignedItems _unit; removeUniform _unit; removeVest _unit; removeBackpack _unit; removeHeadgear _unit; removeGoggles _unit;

	// Add Uniform container
	_unit forceAddUniform _uniform;
	
	if (_uniform == "U_C_WorkerCoveralls") then {	if (_fiftyFifty == 0) then {	_unit setObjectTextureGlobal [0, "\A3\characters_f\common\data\coveralls_bandit_co.paa"]} else {_unit setObjectTextureGlobal [0, "\A3\characters_f\common\data\coveralls_urbancamo_co.paa"];}};

	// Add vest & backpack
	_unit addBackpack _backpack;
	_unit addVest _vest;
	
	// Add Primary weapon & ammo
	_unit addMagazine [_priWeaponMag,_priWeaponMagAm];	
	_unit addWeapon _priWeapon;
	
	// Add headgear
	if ((random 1) > 0.5) then {_unit addHeadgear _headGear};
	
	// Add headgear
	if ((random 1) > 0.5) then {_unit addGoggles _goggles};
			
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
	if ((random 1) > 0.5) then {_unit linkItem "NVGoggles_OPFOR"};
	for "_i" from 1 to 2 do {_unit addMagazine "HandGrenade"; _unit addMagazine "SmokeShell"; _unit addMagazine "16Rnd_9x21_Mag"; _unit addMagazine "Chemlight_red"; _unit addItem "FirstAidKit";};
	_unit addWeapon "hgun_Rook40_F";
	
	// Identity
	_unit setFace _face;

	// Misc
	_unit addPrimaryWeaponItem "acc_flashlight";
	_unit selectWeapon (primaryWeapon _unit);
	
	[_unit] call ADF_fnc_redressRebel_skill;
};