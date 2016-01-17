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
	class CSAT3Patch {
		displayName = "CSAT3"; // Name displayed in Arsenal
		author = "ADF / Whiztler";
		texture = "Img\patch_CSAT3.paa";
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

// End Screen / Debriefing
class CfgDebriefing {  
	class End1
	{
		title = "Mission Completed";
		subtitle = "Day 12 | Flash Forward";
		description = "Cold showers and warm beer all around!";
		//pictureBackground = "Img\loadScreen_TwoSierra.jpg"; // eg. "img\yourpicture.jpg" no picture? use "";
		picture = "Img\logo_TwoSierra.paa"; // Marker icon
		pictureColor[] = {0.0,0.3,0.6,1}; // Overlay color
	};
	class End2
	{
		title = "Mission Failed";
		subtitle = "Day 12 | Flash Forward";
		description = "Those para's were a little too good for TWO SIERRA";
		//pictureBackground = "Img\loadScreen_TwoSierra.jpg"; // eg. "img\yourpicture.jpg" no picture? use "";
		picture = "Img\logo_TwoSierra.paa"; // Marker icon
		pictureColor[] = {0.0,0.3,0.6,1}; // Overlay color
	};
	class Killed
	{
		title = "All players K.I.A.";
		subtitle = "Day 12 | Flash Forward";
		description = "TWO SIERRA R.I.P.";
		//pictureBackground = "Img\loadScreen_TwoSierra.jpg"; // eg. "img\yourpicture.jpg" no picture? use "";
		picture = "Img\logo_TwoSierra.paa"; // Marker icon
		pictureColor[] = {0.0,0.3,0.6,1}; // Overlay color
	};
};

class CfgSounds {
	sounds[] = {
		Radio_Transmit_Sound,
		launch1,
		launch2,
		launch3,
		launch4,
		launch5,
		launch6,
		launch7,
		whistling1,
		whistling2,
		whistling3,
		whistling4,
		bang01,
		bang02,
		bang03,
		bang04,
		bang05,
		bang06,
		bang07,
		bang08,
		bang09,
		bang10,
		bang11,
		fizz_single_type1_1,
		fizz_single_type1_2,
		fizz_single_type1_3,
		fizz_single_type1_4,
		fizz_single_type2_1,
		fizz_single_type2_2,
		fizz_single_type2_3,
		fizz_single_type2_4,
		fizz_group1,
		fizz_group2,
		fizz_group3,
		fizz_group4
	};

	class radioTransmit {
		name = "Radio_Transmit_Sound";
		sound[] = {"Core\S\in2c.ogg", 1, 1}; 		// filename, volume, pitch
		titles[] = {};
	};
	
	// LAUNCHES

	class launch1 {
		name="launch1";
		sound[]={"Scr\audio\launches\launch1.ogg", db+10, 1};
		titles[]={};
	};
	
	class launch2 {
		name="launch2";
		sound[]={"Scr\audio\launches\launch2.ogg", db+10, 1};
		titles[]={};
	};
	
	class launch3 {
		name="launch3";
		sound[]={"Scr\audio\launches\launch3.ogg", db+10, 1};
		titles[]={};
	};
	
	class launch4 {
		name="launch4";
		sound[]={"Scr\audio\launches\launch4.ogg", db+10, 1};
		titles[]={};
	};
	
	class launch5 {
		name="launch5";
		sound[]={"Scr\audio\launches\launch5.ogg", db+10, 1};
		titles[]={};
	};
	
	class launch6 {
		name="launch6";
		sound[]={"Scr\audio\launches\launch6.ogg", db+10, 1};
		titles[]={};
	};
	
	class launch7 {
		name="launch7";
		sound[]={"Scr\audio\launches\launch7.ogg", db+10, 1};
		titles[]={};
	};

	// WHISTLINGS

	class whistling1 {
		name="whistling1";
		sound[]={"Scr\audio\launches\whistling1.ogg", db+10, 1};
		titles[]={};
	};
	
	class whistling2 	{
		name="whistling2";
		sound[]={"Scr\audio\launches\whistling2.ogg", db+10, 1};
		titles[]={};
	};
	
	class whistling3 	{
		name="whistling3";
		sound[]={"Scr\audio\launches\whistling3.ogg", db+10, 1};
		titles[]={};
	};
	class whistling4 	{
		name="whistling4";
		sound[]={"Scr\audio\launches\whistling4.ogg", db+10, 1};
		titles[]={};
	};

	// BANGS

	class bang01 {
		name="bang01";
		sound[]={"Scr\audio\bangs\bang01.ogg", db+10, 1};
		titles[]={};
	};
	
	class bang02 {
		name="bang02";
		sound[]={"Scr\audio\bangs\bang02.ogg", db+10, 1};
		titles[]={};
	};
	
	class bang03 {
		name="bang03";
		sound[]={"Scr\audio\bangs\bang03.ogg", db+10, 1};
		titles[]={};
	};
	
	class bang04 {
		name="bang04";
		sound[]={"Scr\audio\bangs\bang04.ogg", db+10, 1};
		titles[]={};
	};
	
	class bang05 {
		name="bang05";
		sound[]={"Scr\audio\bangs\bang05.ogg", db+10, 1};
		titles[]={};
	};
	
	class bang06 {
		name="bang06";
		sound[]={"Scr\audio\bangs\bang06.ogg", db+10, 1};
		titles[]={};
	};
	
	class bang07 {
		name="bang07";
		sound[]={"Scr\audio\bangs\bang07.ogg", db+10, 1};
		titles[]={};
	};
	
	class bang08 {
		name="bang08";
		sound[]={"Scr\audio\bangs\bang08.ogg", db+10, 1};
		titles[]={};
	};
	
	class bang10 {
		name="bang10";
		sound[]={"Scr\audio\bangs\bang10.ogg", db+10, 1};
		titles[]={};
	};
	
	class bang11 {
		name="bang11";
		sound[]={"Scr\audio\bangs\bang11.ogg", db+10, 1};
		titles[]={};
	};

	// FIZZES

	class fizz_single_type1_1 {
		name="fizz_single_type1_1";
		sound[]={"Scr\audio\fizzes\fizz_single_type1_1.ogg", db+10, 1};
		titles[]={};
	};
	
	class fizz_single_type1_2 {
		name="fizz_single_type1_2";
		sound[]={"Scr\audio\fizzes\fizz_single_type1_2.ogg", db+10, 1};
		titles[]={};
	};
	
	class fizz_single_type1_3 {
		name="fizz_single_type1_3";
		sound[]={"Scr\audio\fizzes\fizz_single_type1_3.ogg", db+10, 1};
		titles[]={};
	};
	
	class fizz_single_type1_4 {
		name="fizz_single_type1_4";
		sound[]={"Scr\audio\fizzes\fizz_single_type1_4.ogg", db+10, 1};
		titles[]={};
	};
	
	class fizz_single_type2_1 {
		name="fizz_single_type2_1";
		sound[]={"Scr\audio\fizzes\fizz_single_type2_1.ogg", db+10, 1};
		titles[]={};
	};
	
	class fizz_single_type2_2 {
		name="fizz_single_type2_2";
		sound[]={"Scr\audio\fizzes\fizz_single_type2_2.ogg", db+10, 1};
		titles[]={};
	};
	class fizz_single_type2_3 {
		name="fizz_single_type2_3";
		sound[]={"Scr\audio\fizzes\fizz_single_type2_3.ogg", db+10, 1};
		titles[]={};
	};
	
	class fizz_single_type2_4 {
		name="fizz_single_type2_4";
		sound[]={"Scr\audio\fizzes\fizz_single_type2_4.ogg", db+10, 1};
		titles[]={};
	};
	
	class fizz_group1 {
		name="fizz_group1";
		sound[]={"Scr\audio\fizzes\fizz_group1.ogg", db+10, 1};
		titles[]={};
	};
	
	class fizz_group2 {
		name="fizz_group2";
		sound[]={"Scr\audio\fizzes\fizz_group2.ogg", db+10, 1};
		titles[]={};
	};
	
	class fizz_group3 {
		name="fizz_group3";
		sound[]={"Scr\audio\fizzes\fizz_group3.ogg", db+10, 1};
		titles[]={};
	};
	
	class fizz_group4 {
		name="fizz_group4";
		sound[]={"Scr\audio\fizzes\fizz_group4.ogg", db+10, 1};
		titles[]={};
	};
};

