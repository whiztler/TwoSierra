/****************************************************************
ARMA Mission Development Framework
ADF version: 1.43 / JANUARY 2016

Script: Cfg entries
Author: Whiztler
Script version: 1.3

Game type: n/a
File: missionConfig.hpp
****************************************************************
Config entry registration goes in here.
****************************************************************/



class CfgUnitInsignia {
	class CLANPATCH {
		displayName = "NRF"; // Name displayed in Arsenal
		author = "ADF / Whiztler";
		texture = "Img\patch_TwoSierra.paa";
		textureVehicle = ""; // Does nothing currently, reserved for future use
	};
	class CLANPATCH_Aegis {
		displayName = "Aegis"; // Name displayed in Arsenal
		author = "ADF / Whiztler";
		texture = "Img\patch_Aegis.paa";
		textureVehicle = ""; // Does nothing currently, reserved for future use
	};
};

class CfgRespawnTemplates { // F3 Spectator Script
	class f_Spectator {
		onPlayerRespawn = "f_fnc_CamInit";
	};
    class Seagull { //Overwrite Vanilla Seagull
        onPlayerRespawn = "";
    };
};

class CfgVehicleTemplates {
	class ADF_opforOffroad {
		displayName = "ADF_opforOffroad"; 
		author = "Whiztler";
		textures[] = {
			"Img\cusTex_offroad.jpg"
		};
		animationList[] = {
			"HideDoor1", 1,
			"HideDoor2", 1,
			"HideGlass2", 1,
			"HideDoor3", 1,
			"HideBackpacks", 0,
			"HideBumper2", 0,
			"HideConstruction", 0,
			"Proxy", 0,
			"Destruct", 0
		};
	};
	
	class ADF_aegisOffroad {
		displayName = "ADF_aegisOffroad"; 
		author = "Whiztler";
		textures[] = {
			"Img\cusTex_offroad_Aegis.jpg"
		};
		animationList[] = {
			"HideDoor1", 0,
			"HideDoor2", 0,
			"HideGlass2", 1,
			"HideDoor3", 0,
			"HideBackpacks", 0,
			"HideBumper2", 0,
			"HideConstruction", 0,
			"Proxy", 0,
			"Destruct", 0
		};
	};
	
	class ADF_opforTruck {
		displayName = "ADF_opforTruck"; 
		author = "Whiztler";
		texturesList[] = {
			"guerilla_06", 1
		};
	};
};

class cfgNotifications { // Preconfigured messages
	class ADF_noticeMsg
	{
		title = "NOTICE";
		description = "%1";
		iconPicture = "\A3\ui_f\data\map\markers\military\warning_ca.paa";
		iconText = "";
		color[] = {1,1,0,1};		
		duration = 4;
		priority = 7;
	};
};

class CfgEnvSounds {
	sounds[] = {};
	class sandstorm {
		name="sandstorm";
		sound[]={"Core\s\sandstorm.ogg",db-0,0,1};
	};
	class radioTransmit {
		name = "Radio_Transmit_Sound";
		sound[] = {"Core\S\in2c.ogg", 1, 1}; 		// filename, volume, pitch
		titles[] = {};
	};
};

// End Screen / Debriefing
class CfgDebriefing
{  
	class End1
	{
		title = "Mission Completed";
		subtitle = "Day 02 | Satan's Fire";
		description = "Splendid achievement Two Sierra! RTB.";
		//pictureBackground = "Img/loadScreen_TwoSierra.jpg"; // eg. "img\yourpicture.jpg" no picture? use "";
		picture = "Img\logo_TwoSierra.paa"; // Marker icon
		pictureColor[] = {0.0,0.3,0.6,1}; // Overlay color
	};
	class End2
	{
		title = "Mission Finished";
		subtitle = "Day 02 | Satan's Fire";
		description = "It's been three hours. Time to come home. RTB.";
		pictureBackground = "Img\loadScreen_TwoSierra.jpg"; // eg. "img\yourpicture.jpg" no picture? use "";
		pictureColor[] = {0.0,0.3,0.6,1}; // Overlay color
	};
	class Killed
	{
		title = "All players K.I.A.";
		subtitle = "Day 02 | Satan's Fire";
		description = "TWO SIERRA R.I.P.";
		pictureBackground = "Img\loadScreen_TwoSierra.jpg"; // eg. "img\yourpicture.jpg" no picture? use "";
		pictureColor[] = {0.0,0.3,0.6,1}; // Overlay color
	};
};

