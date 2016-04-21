/* DEBUG *************************
0 = execVM "aegis.sqf"; [player] call ADF_fnc_redressAegis;
*********************************/

diag_log "ADF RPT: Init - executing ADF_redress_Aegis.sqf"; // Reporting. Do NOT edit/remove

ADF_fnc_redressAegis_priWpn = {
	private ["_weapon"];
	_weapon = [	
		["arifle_MX_GL_Hamr_pointer_F","30Rnd_65x39_caseless_mag_Tracer",30],
		["arifle_MX_Hamr_pointer_F","30Rnd_65x39_caseless_mag_Tracer",30],
		["arifle_MXM_Hamr_pointer_F","30Rnd_65x39_caseless_mag_Tracer",30],
		["srifle_EBR_DMS_pointer_snds_F","20Rnd_762x51_Mag",20],
		["MMG_02_sand_RCO_LP_F","130Rnd_338_Mag",130],
		["srifle_DMR_02_sniper_AMS_LP_S_F","10Rnd_338_Mag",10]	
	] call BIS_fnc_selectRandom;
	_weapon
};

ADF_fnc_redressAegis_skill = {
	params ["_unit"];
	_unit setskill ['general',(0.5 + random 0.5)];
	_unit setskill ['courage',1];
	_unit setskill ['commanding', (0.6 + random 0.4)];
	_unit setskill ['aimingAccuracy', (0.4 + random 0.3)];
	_unit setskill ['aimingShake', (0.3 + random 0.5)];
	_unit setskill ['aimingSpeed', (0.3 + random 0.5)];
	_unit setskill ['spotDistance', (0.6 + random 0.2)];
	_unit setskill ['spotTime', (0.6 + random 0.2)];
	true
};


ADF_fnc_redressAegis = {
	// init
	params ["_unit"];
	private ["_priWeaponArr","_priWeapon","_vest","_goggles","_headGear","_face","_voice","_priWeaponMag","_priWeaponMagAm","_enable_AT"];
	_vest 			= ["V_PlateCarrier2_rgr","V_PlateCarrierSpec_rgr","V_PlateCarrierIA2_dgtl","V_I_G_resistanceLeader_F"] call BIS_fnc_selectRandom;
	_goggles			= ["G_Lowprofile","None","G_Shades_Red","G_Sport_Red","None","G_Sport_Blackred","G_Squares_Tinted","None","None"] call Bis_fnc_SelectRandom;
	_headGear 		= ["H_Cap_tan","None","H_Cap_khaki_specops_UK","H_MilCap_gry","None","H_Beret_blk","H_Watchcap_khk","None","None"] call Bis_fnc_SelectRandom;
	_priWeaponArr		= call ADF_fnc_redressAegis_priWpn;
	_priWeapon		= _priWeaponArr select 0;	
	_priWeaponMag		= _priWeaponArr select 1;
	_priWeaponMagAm	= _priWeaponArr select 2;
	_face			= ["WhiteHead_09","WhiteHead_11","WhiteHead_19","WhiteHead_17","WhiteHead_15","WhiteHead_20"] call BIS_fnc_selectRandom;
	_voice			= ["Male01ENGB","Male02ENGB","Male03ENGB","Male04ENGB","Male05ENGB"] call Bis_fnc_SelectRandom;
	_enable_AT		= [true,false,true,true,true,false,false] call Bis_fnc_SelectRandom;

	// Add NV
	_unit addWeapon "NVGoggles";
	
	// Add vest
	_unit addVest _vest;
	
	// Add headgear
	if !(_headGear == "None") then {_unit addHeadgear _headGear} else {removeHeadgear _unit;};	
	
	// Add Primary weapon & ammo
	_unit addMagazine [_priWeaponMag,_priWeaponMagAm];	
	_unit addWeapon _priWeapon;
	
	// Add Primary Weapon MAgazines & Secondary Weapon (launcher)
	if (_priWeapon == "MMG_02_sand_RCO_LP_F") then {
		for "_i" from 1 to 2 do {_unit addMagazine _priWeaponMag};
		_unit addGoggles "G_Combat";
	} else {
		for "_i" from 1 to 6 do {_unit addMagazine _priWeaponMag};
		if (_enable_AT && (_priWeapon == "arifle_MX_Hamr_pointer_F" || _priWeapon == "arifle_MXM_Hamr_pointer_F")) then {_unit addBackpack "B_Bergen_sgg"; [_unit, "launch_NLAW_F", 2, "NLAW_F"] call BIS_fnc_addWeapon;};
		if !(_goggles == "None") then {_unit addGoggles _goggles} else {removeGoggles _unit;};
	};
	if (_priWeapon == "arifle_MX_GL_Hamr_pointer_F") then {for "_i" from 1 to 6 do {_unit addMagazine "1Rnd_HE_Grenade_shell"};};
	
	// Add default items
	_unit linkItem "ItemMap"; _unit linkItem "ItemCompass"; _unit linkItem "ItemWatch"; _unit linkItem "ItemRadio";
	for "_i" from 1 to 2 do {_unit addMagazine "HandGrenade"; _unit addMagazine "SmokeShell"; _unit addMagazine "11Rnd_45ACP_Mag"; _unit addItem "FirstAidKit";};
	_unit addWeapon "hgun_Pistol_heavy_01_snds_F";
	
	// Identity
	_unit setFace _face;
	_unit setSpeaker _Voice;

	// Misc
	_unit addPrimaryWeaponItem "acc_flashlight";
	_unit selectWeapon (primaryWeapon _unit);
	
	[_unit] call ADF_fnc_redressAegis_skill;
	true
};
