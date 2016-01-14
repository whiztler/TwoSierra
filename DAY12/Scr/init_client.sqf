diag_log "ADF RPT: Init - executing Scr\init_client.sqf"; // Reporting. Do NOT edit/remove

call compile preprocessFileLineNumbers "Core\F\ADF_fnc_typeWriter.sqf";
player createDiarySubject ["Two Sierra Log","Two Sierra Log"];
player createDiaryRecord ["Two Sierra Log",["Two Sierra Communications Log","<br/><br/><font color='#6c7169'>The Two Sierra Log is a logbook of all operational radio comms between Two Sierra and ACO<br/>The messages are logged once displayed on screen. All messages are time-stamped and saved in order of appearance.</font><br/><br/>"]];

ADF_fnc_MOTS = {player allowDamage false; MotsActive = true};
ADF_fnc_MOTS_captive = {params ["_c"]; player setCaptive _c};

waitUntil {ADF_gearLoaded}; // Wait till the unit has their gear before continuing

sleep 3; // Loadout finished > pri weapon loaded

if (!didJIP) then {
	// PC 		- MRAP_2PC
	if !(isNil "INF_RTO_1") then {if (player == INF_RTO_1) then {INF_RTO_1 assignAsDriver MRAP_2PC; INF_RTO_1 moveInDriver MRAP_2PC}};
	if !(isNil "INF_PC") then {if (player == INF_PC) then {INF_PC assignAsCargo MRAP_2PC; INF_PC moveInCargo MRAP_2PC}};

	// 2-1 SQUAD L	- MRAP_2_1_SQUAD
	if !(isNil "INF_SQL_1") then {if (player == INF_SQL_1) then {INF_SQL_1 assignAsDriver MRAP_2_1_SQUAD; INF_SQL_1 moveInDriver MRAP_2_1_SQUAD}};
	if !(isNil "INF_CLS_1") then {if (player == INF_CLS_1) then {INF_CLS_1 assignAsCargo MRAP_2_1_SQUAD; INF_CLS_1 moveInCargo MRAP_2_1_SQUAD}};
	// 2-1 ALPHA	- MRAP_2_1_ALPHA
	if !(isNil "INF_AR_1") then {if (player == INF_AR_1) then {INF_AR_1 assignAsDriver MRAP_2_1_ALPHA; INF_AR_1 moveInDriver MRAP_2_1_ALPHA}};
	if !(isNil "INF_AAR_1") then {if (player == INF_AAR_1) then {INF_AAR_1 assignAsGunner MRAP_2_1_ALPHA; INF_AAR_1 moveInGunner MRAP_2_1_ALPHA}};
	if !(isNil "INF_RAT_1") then {if (player == INF_RAT_1) then {INF_RAT_1 assignAsCargo MRAP_2_1_ALPHA; INF_RAT_1 moveInCargo MRAP_2_1_ALPHA}};
	if !(isNil "INF_FTL_1") then {if (player == INF_FTL_1) then {INF_FTL_1 assignAsCargo MRAP_2_1_ALPHA; INF_FTL_1 moveInCargo MRAP_2_1_ALPHA}};
	// 2-1 BRAVO	- MRAP_2_1_BRAVO
	if !(isNil "INF_AR_2") then {if (player == INF_AR_2) then {INF_AR_2 assignAsDriver MRAP_2_1_BRAVO; INF_AR_2 moveInDriver MRAP_2_1_BRAVO}};
	if !(isNil "INF_AAR_2") then {if (player == INF_AAR_2) then {INF_AAR_2 assignAsCargo MRAP_2_1_BRAVO; INF_AAR_2 moveInCargo MRAP_2_1_BRAVO}};
	if !(isNil "INF_RAT_2") then {if (player == INF_RAT_2) then {INF_RAT_2 assignAsCargo MRAP_2_1_BRAVO; INF_RAT_2 moveInCargo MRAP_2_1_BRAVO}};
	if !(isNil "INF_FTL_2") then {if (player == INF_FTL_2) then {INF_FTL_2 assignAsCargo MRAP_2_1_BRAVO; INF_FTL_2 moveInCargo MRAP_2_1_BRAVO}};

	// 2-2 SQUAD L	- MRAP_2_2_SQUAD
	if !(isNil "INF_SQL_2") then {if (player == INF_SQL_2) then {INF_SQL_2 assignAsDriver MRAP_2_2_SQUAD; INF_SQL_2 moveInDriver MRAP_2_2_SQUAD}};
	if !(isNil "INF_CLS_2") then {if (player == INF_CLS_2) then {INF_CLS_2 assignAsCargo MRAP_2_2_SQUAD; INF_CLS_2 moveInCargo MRAP_2_2_SQUAD}};
	// 2-2 ALPHA	- MRAP_2_2_ALPHA
	if !(isNil "INF_AR_3") then {if (player == INF_AR_3) then {INF_AR_3 assignAsDriver MRAP_2_2_ALPHA; INF_AR_3 moveInDriver MRAP_2_2_ALPHA}};
	if !(isNil "INF_AAR_3") then {if (player == INF_AAR_3) then {INF_AAR_3 assignAsGunner MRAP_2_2_ALPHA; INF_AAR_3 moveInGunner MRAP_2_2_ALPHA}};
	if !(isNil "INF_RAT_3") then {if (player == INF_RAT_3) then {INF_RAT_3 assignAsCargo MRAP_2_2_ALPHA; INF_RAT_3 moveInCargo MRAP_2_2_ALPHA}};
	if !(isNil "INF_FTL_3") then {if (player == INF_FTL_3) then {INF_FTL_3 assignAsCargo MRAP_2_2_ALPHA; INF_FTL_3 moveInCargo MRAP_2_2_ALPHA}};
	// 2-2 BRAVO	- MRAP_2_2_BRAVO
	if !(isNil "INF_AR_4") then {if (player == INF_AR_4) then {INF_AR_4 assignAsDriver MRAP_2_2_BRAVO; INF_AR_4 moveInDriver MRAP_2_2_BRAVO}};
	if !(isNil "INF_AAR_4") then {if (player == INF_AAR_4) then {INF_AAR_4 assignAsCargo MRAP_2_2_BRAVO; INF_AAR_4 moveInCargo MRAP_2_2_BRAVO}};
	if !(isNil "INF_RAT_4") then {if (player == INF_RAT_4) then {INF_RAT_4 assignAsCargo MRAP_2_2_BRAVO; INF_RAT_4 moveInCargo MRAP_2_2_BRAVO}};
	if !(isNil "INF_FTL_4") then {if (player == INF_FTL_4) then {INF_FTL_4 assignAsCargo MRAP_2_2_BRAVO; INF_FTL_4 moveInCargo MRAP_2_2_BRAVO}};

	// 2-3 ALPHA	- MRAP_2_3_WT1
	if !(isNil "INF_AMG_1") then {if (player == INF_AMG_1) then {INF_AMG_1 assignAsDriver MRAP_2_3_WT1; INF_AMG_1 moveInDriver MRAP_2_3_WT1}};
	if !(isNil "INF_MG_1") then {if (player == INF_MG_1) then {INF_MG_1 assignAsGunner MRAP_2_3_WT1; INF_MG_1 moveInGunner MRAP_2_3_WT1}};
	if !(isNil "INF_WTL_1") then {if (player == INF_WTL_1) then {INF_WTL_1 assignAsCargo MRAP_2_3_WT1; INF_WTL_1 moveInCargo MRAP_2_3_WT1}};
	if !(isNil "INF_CLS_3") then {if (player == INF_CLS_3) then {INF_CLS_3 assignAsCargo MRAP_2_3_WT1; INF_CLS_3 moveInCargo MRAP_2_3_WT1}};
	// 2-3 ALPHA	- MRAP_2_3_WT2
	if !(isNil "INF_AMS_1") then {if (player == INF_AMS_1) then {INF_AMS_1 assignAsDriver MRAP_2_3_WT2; INF_AMS_1 moveInDriver MRAP_2_3_WT2}};
	if !(isNil "INF_MS_1") then {if (player == INF_MS_1) then {INF_MS_1 assignAsGunner MRAP_2_3_WT2; INF_MS_1 moveInGunner MRAP_2_3_WT2}};
	if !(isNil "INF_HMG_1") then {if (player == INF_HMG_1) then {INF_HMG_1 assignAsCargo MRAP_2_3_WT2; INF_HMG_1 moveInCargo MRAP_2_3_WT2}};
	if !(isNil "INF_AHMG_1") then {if (player == INF_AHMG_1) then {INF_AHMG_1 assignAsCargo MRAP_2_3_WT2; INF_AHMG_1 moveInCargo MRAP_2_3_WT2}};
};

waitUntil {sleep 2; ADF_missionInit}; sleep 5;

if (!didJIP) then {
	[
		["07 SEP 2019","<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"],
		["UNITED SAHRANI","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"],
		["FOB BRONSON, CORAZOL","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"]
	] spawn ADF_fnc_typeWriter;
	
	waitUntil {sleep 1; !isNil "ADF_assaultTimer"};
	
	["2S","","VADER this is TWO SIERRA at BRONSON. Ready for tasking. Over"] call ADF_fnc_MessageParser; sleep 10;
	["ACO","ACO","TWO SIERRA this is VADER. Stand-by. Over."] call ADF_fnc_MessageParser;
	sleep 70;
	["ACO","ACO","TWO SIERRA this is VADER. Message. Over."] call ADF_fnc_MessageParser; sleep 10;
	["2S","","VADER this is TWO SIERRA. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is VADER. Stand-by for FRAGO. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","VADER this is TWO SIERRA. Ready to copy. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is VADER. FRAGO. Break. RV with THIRD PLATOON at grid 1-0-9-1.0-9-8-0. Break.<br/><br/>Report in when at RV. How copy?"] call ADF_fnc_MessageParser; sleep 20;
	["2S","","VADER this is TWO SIERRA. Solid Copy. RV at grid 1-0-9-1.0-9-8-0. Out."] call ADF_fnc_MessageParser;
	sleep 40;
	["ACO","ACO","TWO SIERRA this is VADER. Stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","VADER this is TWO SIERRA. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is VADER. Stand-by. Over."] call ADF_fnc_MessageParser; sleep 8;
	waitUntil {sleep 1; ADF_assaultStart}; // 208 sec
	["ACO","ACO","TWO SIERRA this is VADER. <t color='#FF5B5B'>Priority message</t>. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","VADER this is TWO SIERRA. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is VADER. RV compromised. Break. Standby for further intel. How copy?"] call ADF_fnc_MessageParser; sleep 10;
	["2S","","VADER this is TWO SIERRA. Solid copy. Standing by. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is VADER. We lost all comms with THIRD and FOURTH platoon. Stand by. Over."] call ADF_fnc_MessageParser; sleep 10; // 44 sec
	["2S","","VADER this is TWO SIERRA. Roger. Over."] call ADF_fnc_MessageParser; sleep 60;
	["2S","","VADER this is TWO SIERRA. Priority Traffic. Over."] call ADF_fnc_MessageParser; sleep 8; 
	["ACO","ACO","TWO SIERRA this is VADER. Send. Over."] call ADF_fnc_MessageParser; sleep 8; 
	["2S","","VADER this is TWO SIERRA. Multiple VIPER helicopters at BRONSON. Break. Paratroopers dropped at Corazol. Break. Interrogative tasking. How copy?"] call ADF_fnc_MessageParser; sleep 10;
	["ACO","ACO","TWO SIERRA this is VADER. Solid copy. Wait Out."] call ADF_fnc_MessageParser; sleep 20;
	["ACO","ACO","TWO SIERRA this is VADER. Message. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","VADER this is TWO SIERRA. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is VADER. Tasking: defend and secure BRONSON. Break. Clear and secure Corazol. How copy?."] call ADF_fnc_MessageParser; sleep 20;
	["2S","","VADER this is TWO SIERRA. Solid copy on all. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is VADER. The FLASH FORWARD assault force has ecountered heavy losses. Break.<br/><br/>Unable to assist with the defense of BRONSON. Break. Will advice when reinforcements are available for assist. Good luck. Out."] call ADF_fnc_MessageParser;
};

ADF_msg_sitrep = {
	params ["_o", "_b", "_s"];
	private ["_msg", "_p"];
	_p = getPosASL (leader (group player));
	["ACO","ACO","TWO SIERRA this is VADER. Interrogative sitrep. Over."] call ADF_fnc_MessageParser; sleep 9;
	_msg = format ["TWO SIERRA: VADER this is TWO SIERRA. Position grid Whiskey Victor %1 . %2. Break. Pappa: %3. Break. Tango: %4. How copy?", round (_p select 0), round (_p select 1), _b, _o];
	["2S","",_msg] call ADF_fnc_MessageParser; 
	sleep _s;
	["ACO","ACO","TWO SIERRA this is VADER. Good copy. Out."] call ADF_fnc_MessageParser;
	sleep 8; hintSilent "";
};

[] spawn {
	waitUntil {sleep 30; time > 7200}; // 30 mins left
	["ACO","ACO","TWO SIERRA this is VADER. Message. Over."] call ADF_fnc_MessageParser; sleep 7;
	["2S","","VADER this is TWO SIERRA. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is VADER. You have 30 mikes left before MOTHER pulls you out. Break. After that it is RTB and mission aborted. Over."] call ADF_fnc_MessageParser; sleep 16;
	["2S","","VADER this is TWO SIERRA. Roger. Out."] call ADF_fnc_MessageParser; 
};

ADF_msg_endMission	= {
	["2S","","VADER this is TWO SIERRA. Stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA this is VADER. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","VADER this is TWO SIERRA. BRONSON secured. Corazol cleared. How copy?"] call ADF_fnc_MessageParser; sleep 12;
	["ACO","ACO","Solid copy. Splendid achievemnt TWO SIERRA. Another crown on your track record. Out."] call ADF_fnc_MessageParser;
	
	player allowDamage false;
	waitUntil {sleep 0.5; ADF_endLoc};
	["BIS_blackStart", true] call BIS_fnc_blackOut;
	sleep 2;
	["<t size='5' color='#FFFFFF'>Finally... Time for some R&R</t>",0,0,3,12] spawn BIS_fnc_dynamicText;    
	player setPos (getMarkerPos "mEndPos");
	
	// Change into beach gear
	removeAllWeapons player; removeAllItems player; removeAllAssignedItems player; removeVest player; removeBackpack player; removeHeadgear player; removeGoggles player; removeUniform player;
	player forceAddUniform (["U_C_Poloshirt_blue", "U_C_Poloshirt_burgundy", "U_C_Poloshirt_stripped", "U_C_Poloshirt_tricolour", "U_C_Poloshirt_salmon", "U_C_Poloshirt_redwhite"] call BIS_fnc_selectRandom);
	if ((random 1) > .75) then {player addHeadgear (["H_Cap_red", "H_Cap_blu", "H_Cap_grn", "H_Cap_surfer"] call BIS_fnc_selectRandom)};
	if ((random 1) > .60) then {player addGoggles (["G_Aviator", "G_Shades_Blue", "G_Shades_Green", "G_Shades_Red", "G_Sport_Red", "G_Sport_Blackyellow", "G_Sport_BlackWhite", "G_Sport_Checkered", "G_Sport_Blackred", "G_Sport_Greenblack"] call BIS_fnc_selectRandom)};
	{player linkItem _x} forEach ["ItemWatch","ItemCompass","ItemMap"];
	
	["BIS_blackStart", true] call BIS_fnc_blackIn;
	ADF_endLocPlayer = true; publicVariableServer "ADF_endLocPlayer";
	sleep 20;

	enableRadio false;
	clearRadio; 

	playMusic "LeadTrack01c_F";

	sleep 10;

	["<img size= '15' shadow='false' image='Img\intro_TwoSierra.paa'/><br/><br/>",0,-.3,103,1,0,1001] spawn BIS_fnc_dynamicText; sleep 3;
	["<t size='1' color='#FFFFFF' shadow='false'>Campaign Completed</t>",0.02,0.8,7,-1,0,1002] spawn BIS_fnc_dynamicText; sleep 7;
	["<t size='1' color='#FFFFFF' shadow='false'>Day 01 | Operation Bearclaw</t>",0.02,0.8,7,-1,0,1003] spawn BIS_fnc_dynamicText; sleep 7;
	["<t size='1' color='#FFFFFF' shadow='false'>Day 02 | Operation Satan's Fire</t>",0.02,0.8,7,-1,0,1004] spawn BIS_fnc_dynamicText; sleep 7;
	["<t size='1' color='#FFFFFF' shadow='false'>Day 03 | Operation Dolphin</t>",0.02,0.8,7,-1,0,1005] spawn BIS_fnc_dynamicText; sleep 7;
	["<t size='1' color='#FFFFFF' shadow='false'>Day 04 | Operation Hannibal</t>",0.02,0.8,7,-1,0,1006] spawn BIS_fnc_dynamicText; sleep 7;
	["<t size='1' color='#FFFFFF' shadow='false'>Day 05 | Operation St. Mary</t>",0.02,0.8,7,-1,0,1007] spawn BIS_fnc_dynamicText; sleep 7;
	["<t size='1' color='#FFFFFF' shadow='false'>Day 06 | Operation Bulldogs</t>",0.02,0.8,7,-1,0,1008] spawn BIS_fnc_dynamicText; sleep 7;
	["<t size='1' color='#FFFFFF' shadow='false'>Day 07 | Operation Nola</t>",0.02,0.8,7,-1,0,1009] spawn BIS_fnc_dynamicText; sleep 7;
	["<t size='1' color='#FFFFFF' shadow='false'>Day 08 | Operation Novy Disha</t>",0.02,0.8,7,-1,0,1010] spawn BIS_fnc_dynamicText; sleep 7;
	["<t size='1' color='#FFFFFF' shadow='false'>Day 09 | Operation Keyhole</t>",0.02,0.8,7,-1,0,1011] spawn BIS_fnc_dynamicText; sleep 7;
	["<t size='1' color='#FFFFFF' shadow='false'>Day 10 | Operation Hell's Bells</t>",0.02,0.8,7,-1,0,1012] spawn BIS_fnc_dynamicText; sleep 7;
	["<t size='1' color='#FFFFFF' shadow='false'>Day 10 | Operation Warlord</t>",0.02,0.8,7,-1,0,1012] spawn BIS_fnc_dynamicText; sleep 7;
	["<t size='1' color='#FFFFFF' shadow='false'>Day 10 | Operation Fash Forward</t>",0.02,0.8,7,-1,0,1012] spawn BIS_fnc_dynamicText; sleep 10;
	["<t size='1' color='#FFFFFF' shadow='false'>Concept &amp; Development</t><br/><br/><t size='.9' color='#FFFFFF' shadow='false'>whiztler</t>",0.02,0.8,15,-10,0,1013] spawn BIS_fnc_dynamicText; sleep 8;

	sleep 1;
	15 fadeMusic 0;
	enableRadio true;

	sleep 20;

	["END1",true,12] call BIS_fnc_endMission;
};

GRAD_Fireworks = { // Edited by whiztler
    params [
		"_firing_position", "_type1", "_initial_velocity", "_explosion_power", "_glitter_count", "_color", 
		"_explosion_fragments_array", "_explosion_subfragments_array", "_randomSleep", "_randomSleepLong",
		"_randomLaunch", "_launchSound", "_whistlingSound", "_bangSound", "_singleFizz", "_groupFizz", "_randomSleepShort"
	];

	_nul1 = "CMflare_Chaff_Ammo" createVehicleLocal [_firing_position select 0,_firing_position select 1, 0]; 
	_nul1 setVelocity _initial_velocity; 
	
	_light1 = "#lightpoint" createVehicleLocal [0,0,0];
	_light1 setLightBrightness 0.1;
	_light1 setLightColor [1,0.3,0];
	_light1 setLightUseFlare true;
	_light1 setLightFlareMaxDistance 1000;
	_light1 setLightFlareSize 5;

	_light2 = "#lightpoint" createVehicleLocal [0,0,0];
	_light2 setLightBrightness 0.08;
	_light2 setLightColor [1,0.8,0];
	_light2 setLightUseFlare true;
	_light2 setLightFlareMaxDistance 1000;
	_light2 setLightFlareSize 4;
	sleep 0.01;
	_light1 lightAttachObject  [_nul1,[0,0,0]];
	_light2 lightAttachObject  [_nul1,[0,0,0]];	

	_nul1 say3D _launchsound;
	sleep 1;

	if (_type1 == "fizzer") then {_nul1 say3D _whistlingSound};

	sleep (2 + _randomSleepShort);
	deleteVehicle _light1;
	deleteVehicle _light2;

	_nul2 ="FxExploArmor3" createVehicleLocal (getPos _nul1);
	sleep 0.10;
	_nul2 say3D _bangSound;

	for [{_i=0}, {_i < count _explosion_fragments_array}, {_i=_i+1}] do {
		[_nul1,_type1,_explosion_fragments_array,_explosion_subfragments_array,_color,_glitter_count,_i,_randomSleep,_randomSleepLong,_singleFizz,_groupFizz,_bangSound] spawn {
			params ["_rocket", "_type2", "_fragments", "_subfragments", "_color2", "_glitter_count2", "_selector", "_randomSleep2", "_randomSleepLong2", "_singleFizz1", "_groupFizz1", "_bangSound1"];

			_nul2 ="CMflare_Chaff_Ammo" createVehicleLocal (getPos _rocket); 
			_smoke ="SmokeLauncherAmmo" createVehicleLocal (getPos _rocket);			
			_nul2 setVelocity (_fragments select _selector);

			_light2 = "#lightpoint" createVehicleLocal [0,0,0];
			_light2 setLightBrightness 1.0;		
			if (_type2 == "normal" || _type2 == "fizzer") then {
				_light2 setLightAmbient [1,0.9,0.6];
			} else {
				_light2 setLightAmbient _color2;
			};		
			_light2 setLightColor _color2;
			_light2 lightAttachObject  [_nul2,[0,0,0]];
			_light2 setLightUseFlare true;
			_light2 setLightFlareMaxDistance 1000;
			_light2 setLightFlareSize 3;

			if (_type2 == "normal") then {
				sleep (3 + (random 1));
				deleteVehicle _light2;
			};
				
			if (_type2 == "fizzer")  then {
				sleep 1.0;
				deleteVehicle _light2;
				
				_nul2 say3D _bangSound1;
			
				for [{_j=0}, {_j < (count _subfragments)}, {_j=_j+1}] do {
				
					[_nul2,_type2,_subfragments,_color2,_j,_randomSleep2,_randomSleepLong2,_singleFizz1,_groupFizz1,_bangSound1] spawn {
						params ["_rocket2", "_type3", "_subfragments2", "_color3", "_selector2", "_randomSleep3", "_randomSleepLong3", "_singleFizz2", "_groupFizz2", "_bangSound2"];
							
						_posx = (getPos _rocket2) select 0;
						_posy = (getPos _rocket2) select 1;
						_posz = (getPos _rocket2) select 2;					
						deleteVehicle _rocket2;
						
						_nul3 ="F_20mm_White" createVehicleLocal [_posx + ((random 20)-10),_posy+ ((random 20)-10),_posz+ ((random 20)-10)];
						_nul3 setVelocity (_subfragments2 select _selector2);

						_light3 = "#lightpoint" createVehicleLocal [0,0,0];
						_light3 setLightBrightness 2;					
						if (_type3 == "normal" || _type3 == "fizzer") then {
							_light3 setLightAmbient [1,0.9,0.6];
						} else {
							_light3 setLightAmbient _color3;
						};					
						_light3 setLightColor _color3;
						_light3 lightAttachObject  [_nul3,[0,0,0]];
						_light3 setLightUseFlare true;
						_light3 setLightFlareMaxDistance 1000;
						_light3 setLightFlareSize 1;

						sleep (random 1);
						_nul3 say3D (_singleFizz2 call BIS_fnc_selectRandom);

						sleep (2 - (random 1.5));	
						deleteVehicle _light3;
						deleteVehicle _nul3;				
					};
				};
			};

			if (_type2 == "rain")  then {
				sleep 1.0;				
				_nul2 say3D _bangSound1;
			
				[_nul2,_type2,_fragments,_color2,_selector,_randomSleep2,_randomSleepLong2,_singleFizz1,_groupFizz1,_bangSound1] spawn {
					params ["_rocket2", "_type2", "_subfragments2", "_color3", "_selector2", "_randomSleep3", "_randomSleepLong3", "_singleFizz2", "_groupFizz2", "_bangSound2"];
						
					_posx = (getPos _rocket2) select 0;
					_posy = (getPos _rocket2) select 1;
					_posz = (getPos _rocket2) select 2;
					deleteVehicle _rocket2;

					_nul3 ="FxWindPollen1" createVehicleLocal [getPos _rocket2 select 0,getPos _rocket2 select 1,getPos _rocket2 select 2];				
					_nul3 setVelocity (_subfragments2 select _selector2);

					_light3 = "#lightpoint" createVehicleLocal [0,0,0];
					_light3 setLightBrightness 2;
					if (_type2 == "normal" || _type2 == "fizzer") then {
						_light3 setLightAmbient [1,0.9,0.6];
						} else {
						_light3 setLightAmbient _color3;
					};
					_light3 setLightColor _color3;
					_light3 lightAttachObject  [_nul3,[0,0,0]];
					_light3 setLightUseFlare true;
					_light3 setLightFlareMaxDistance 1000;
					_light3 setLightFlareSize 1;

					sleep (random 1);
					_nul3 say3D (_singleFizz2 call BIS_fnc_selectRandom);

					sleep (2 - (random 1.5));
					deleteVehicle _light3;
					deleteVehicle _nul3;		
				};
				sleep 1;
				deleteVehicle _light2;				
			};
		};
	};

	sleep 1;
	_nul2 say3D (_groupFizz call BIS_fnc_selectRandom);
	sleep 2;
	deleteVehicle _nul2;
};