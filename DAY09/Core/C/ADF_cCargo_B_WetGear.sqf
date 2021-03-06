/****************************************************************
ARMA Mission Development Framework
ADF version: 1.43 / JANUARY 2016

Script: Crate Cargo Script (BLUEFOR) - SpecOps items/weapons (Wolf)
Author: Whiztler
Script version: 1.7

Game type: n/a
File: ADF_cCargo_B_WetGear.sqf
****************************************************************
Instructions:

Paste below line in the INITIALIZATION box of the crate:
null = [this] execVM "Core\C\ADF_cCargo_B_WetGear.sqf";

You can comment out (//) lines of ammo you do not want to include
in the vehicle cargo. 
****************************************************************/

if (!isServer) exitWith {};

waitUntil {time > 0};

// Init
params ["_crate"];
private ["_wpn", "_mag", "_uni"];
_crate allowDamage false;
_wpn = 10; 	// Regular Weapons
_mag = 40;	// Magazines
_uni = 10;	// Uniform/Vest/Backpack/etc

// Settings 
_crate call ADF_fnc_stripVehicle;

// Primary weapon
_crate addWeaponCargoGlobal ["arifle_SDAR_F", _wpn]; // Divers

// Magazines primary weapon
_crate addMagazineCargoGlobal ["30Rnd_556x45_Stanag", _mag]; // SDAR

// Diving Gear
_crate addBackpackCargoGlobal ["B_Carryall_mcamo", _uni];

_crate addItemCargoGlobal ["U_B_Wetsuit", _uni];
_crate addItemCargoGlobal ["G_Diving", _uni];
_crate addItemCargoGlobal ["V_RebreatherIR", _uni];	


