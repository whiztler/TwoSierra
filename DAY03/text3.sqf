removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;
this setVariable ["BIS_enableRandomization", false];
this forceAddUniform "U_B_CombatUniform_mcam";
uniformContainer this setObjectTextureGlobal [0, "\a3\characters_f\BLUFOR\Data\clothing_sage_co.paa"];
this linkItem "ItemMap";


this forceAddUniform "U_B_CombatUniform_mcam";
this setObjectTextureGlobal [0, "\a3\characters_f\BLUFOR\Data\clothing_sage_co.paa"];
this linkItem "ItemMap";


player addEventHandler ["Take", {
	(getObjectTextures player + [uniformContainer player getVariable "texture"])
	params ["_texUniform", "_texInsignia", "_texCustom"];
	if (isNil "_texCustom") exitWith {};
	if (_texUniform == _texCustom) exitWith {};
	player setObjectTextureGlobal [0, _texCustom];
	false
}];


//Example: make current uniform persistently blue

_texture =  "#(rgb,8,8,3)color(0,0,1,1)"; //blue texture
player setObjectTextureGlobal [0, _texture]; //set it on player
uniformContainer player setVariable ["texture", _texture, true]; //store it on uniform