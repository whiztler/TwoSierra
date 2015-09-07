diag_log "ADF RPT: Init - executing ADF_redress_Cherno.sqf"; // Reporting. Do NOT edit/remove

ADF_fnc_redressCherno_face = {
	private ["_face"];
	_face = ["WhiteHead_02","WhiteHead_03","WhiteHead_04","WhiteHead_05","WhiteHead_06","WhiteHead_07","WhiteHead_08","WhiteHead_09","WhiteHead_10","WhiteHead_11","WhiteHead_12","WhiteHead_13","WhiteHead_14","WhiteHead_15"	] call BIS_fnc_selectRandom;
	_face
};

ADF_fnc_redressCherno_skill = {
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

ADF_fnc_redressCherno = {
	params ["_unit"];
	private ["_uniformStore","_uBackpack","_backpackStore","_vestStore","_face"];
	_face = call ADF_fnc_redressCherno_face;
	
	_uniformStore = uniformItems _unit;
	removeUniform _unit;
	_unit forceAddUniform "U_B_CTRG_1";
	{_unit addItemToUniform _x;} forEach _uniformStore;
	_unit setObjectTextureGlobal [0, "\a3\characters_f\BLUFOR\Data\clothing_wdl_co.paa"];
	
	_uBackpack = unitBackpack _unit;
	if	(format	["%1", _uBackpack] != "") then {
		_backpackStore = backpackItems _unit;
		removeBackpack _unit;
		_unit addBackpack "B_AssaultPack_blk";
		{_unit addItemToBackpack _x;} forEach _backpackStore;	
	};
	
	_vestStore = vestItems _unit;
	removeVest _unit;
	_unit addVest "V_PlateCarrier1_blk";
	{_unit addItemToVest _x;} forEach _vestStore;
	
	removeHeadgear _unit;
	_unit addHeadgear "H_Beret_blk";
	
	// Identity
	_unit setFace _face;
	
	// Insignia
	[_unit,"CAFpatch"] call BIS_fnc_setUnitInsignia;
	
	[_unit] call ADF_fnc_redressCherno_skill;
};