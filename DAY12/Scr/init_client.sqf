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
	["ACO","ACO","TWO SIERRA this is VADER. Good copy. Wait. Out."] call ADF_fnc_MessageParser;
	sleep 70;
	["ACO","ACO","TWO SIERRA this is VADER. Message. Over."] call ADF_fnc_MessageParser; sleep 10;
	["2S","","VADER this is TWO SIERRA. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is VADER. Stand-by for FRAGO. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","VADER this is TWO SIERRA. Ready to copy. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is VADER. FRAGO. Break. RV with THIRD PLATOON at grid 1091.0980. Break.<br/><br/>Report in when at RV. How copy?"] call ADF_fnc_MessageParser; sleep 20;
	["2S","","VADER this is TWO SIERRA. Solid Copy. RV at grid 1091.0980. Out."] call ADF_fnc_MessageParser;
	sleep 40;
	["ACO","ACO","TWO SIERRA this is VADER. Stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","VADER this is TWO SIERRA. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is VADER. Wait. Out."] call ADF_fnc_MessageParser; sleep 8;
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


ADF_msg_endMission	= {
	["2S","","VADER this is TWO SIERRA. Stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA this is VADER. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","VADER this is TWO SIERRA. BRONSON secured. Corazol cleared. How copy?"] call ADF_fnc_MessageParser; sleep 12;
	["ACO","ACO","Solid copy. Splendid achievemnt TWO SIERRA. Another crown on your track record. Out."] call ADF_fnc_MessageParser;

	enableRadio false;
	enableEnvironment false;
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
	15 fadeSound 0;
	sleep 1;
	15 fadeMusic 0;
	enableRadio true;
	enableEnvironment true;  

	sleep 10;

	["END1",true,12] call BIS_fnc_endMission;
};
