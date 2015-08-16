/* DEBUG *************************
0 = execVM "Scr\NRF.sqf"; [player] call ADF_fnc_redressAegis;
*********************************/

diag_log "ADF RPT: Init - executing NRF.sqf"; // Reporting. Do NOT edit/remove

ADF_fnc_redressNRF_skill = {
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

ADF_fnc_redressNRF = {
	// init
	params ["_unit"];
	private ["_headGear"];
	
	// Add NV
	_unit addWeapon "NVGoggles";
	
	// Add vest
	_unit addVest "V_TacVest_khk";
	
	// Add headgear
	_headGear = ["H_HelmetSpecB_paint2","H_HelmetB_sand","H_HelmetB_desert"] call BIS_fnc_selectRandom;
	_unit addHeadgear _headGear;	
	
	// Add Primary weapon & ammo
	_unit addMagazine ["30Rnd_65x39_caseless_mag",30];	
	_unit addWeapon "arifle_MX_Black_Hamr_pointer_F";
	for "_i" from 1 to 6 do {_unit addMagazine "30Rnd_65x39_caseless_mag"};
	_unit addGoggles "G_Combat";
	
	// Add default items
	_unit linkItem "ItemMap"; _unit linkItem "ItemCompass"; _unit linkItem "ItemWatch"; _unit linkItem "ItemRadio";
	for "_i" from 1 to 2 do {_unit addMagazine "HandGrenade"; _unit addMagazine "SmokeShell"; _unit addMagazine "11Rnd_45ACP_Mag"; _unit addItem "FirstAidKit";};
	_unit addWeapon "hgun_Pistol_heavy_01_snds_F";
	
	// Misc
	[_unit,"CLANPATCH"] call BIS_fnc_setUnitInsignia;
	_unit selectWeapon (primaryWeapon _unit);
	
	[_unit] call ADF_fnc_redressNRF_skill;
};
