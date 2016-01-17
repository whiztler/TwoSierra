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
		["02 SEP 2019","<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"],
		["UNITED SAHRANI","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"],
		["OP CRIMSHAW, EVERON","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"]
	] spawn ADF_fnc_typeWriter;

	["2S","","VADER this is TWO SIERRA at CRIMSHAW. Ready for tasking. How copy?"] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is VADER. Solid copy. Execute KEYHOLE. Over."] call ADF_fnc_MessageParser; sleep 11; 
	["2S","","VADER this is TWO SIERRA. Roger. Out."] call ADF_fnc_MessageParser; sleep 8;
};

ADF_msg_corazolBlue	= {
	ADF_obj_corazol = true;
	["2S","","VADER this is TWO SIERRA. stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA his is VADER. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","VADER this is TWO SIERRA. KEYHOLE secured. How copy?"] call ADF_fnc_MessageParser; sleep 12;
	if (ADF_obj_calvin) then {		
		["ACO","ACO","TWO SIERRA this is VADER: Solid copy. Wait. Over."] call ADF_fnc_MessageParser; sleep 20;
		[] spawn ADF_msg_endMission;
	} else {
		["ACO","ACO","TWO SIERRA this is VADER. Solid copy. Break. Clear and secure CALVIN. How copy?"] call ADF_fnc_MessageParser; sleep 12;
		["2S","","VADER this is TWO SIERRA. Wilco. Out."] call ADF_fnc_MessageParser; 
	};
};
ADF_msg_calvinBlue	= {
	ADF_obj_calvin = true;
	["2S","","VADER this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA this is VADER. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","VADER this is TWO SIERRA. CALVIN is blue. How copy?"] call ADF_fnc_MessageParser; sleep 12;
	if (ADF_obj_corazol) then {
		["ACO","ACO","TWO this is VADER. Solid copy. Wait. Out."] call ADF_fnc_MessageParser; sleep 20;
		[] spawn ADF_msg_endMission;
	} else {
		["ACO","ACO","TWO SIERRA this is VADER. Solid copy. Break. Clear and secure KEYHOLE. Over."] call ADF_fnc_MessageParser; sleep 12;
		["2S","","VADER this is TWO SIERRA. Wilco. Out."] call ADF_fnc_MessageParser; 
	};
};

ADF_msg_foxtrotBlue	= {
	ADF_obj_foxtrot = true;
	["2S","","VADER this is TWO SIERRA. stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA this is VADER. Send. Over."] call ADF_fnc_MessageParser; sleep 8;	
	["2S","","VADER this is TWO SIERRA. FOXTROT is blue. How copy?"] call ADF_fnc_MessageParser; sleep 9;
	["ACO","ACO","TWO SIERRA this is VADER. Solid copy. FOXTROT cleared. Proceed with tasking. Over."] call ADF_fnc_MessageParser; sleep 11;
	["2S","","VADER this is TWO SIERRA. Roger. Out."] call ADF_fnc_MessageParser;
};

ADF_msg_golfBlue		= {
	ADF_obj_golf = true;
	["2S","","VADER this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA this is VADER. Send. Over."] call ADF_fnc_MessageParser; sleep 8;	
	["2S","","VADER this is TWO SIERRA. We have secured GOLF. How copy?"] call ADF_fnc_MessageParser; sleep 13;
	["ACO","ACO","TWO SIERRA this is VADER. Roger. Proceed with tasking. Over."] call ADF_fnc_MessageParser; sleep 11;
	["2S","","VADER this is TWO SIERRA. Wilco. Out."] call ADF_fnc_MessageParser;
};

ADF_msg_hotelBlue		= {
	ADF_obj_hotel = true;
	["2S","","VADER this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA this is VADER. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 8;	
	["2S","","VADER this is TWO SIERRA. HOTEL is clear. How copy?"] call ADF_fnc_MessageParser; sleep 14;
	["ACO","ACO","TWO SIERRA this is VADER. Solid copy. Continue on mission. Over."] call ADF_fnc_MessageParser; sleep 12;
	["2S","","VADER this is TWO SIERRA. Roger. Out."] call ADF_fnc_MessageParser;
};

ADF_msg_DeltaBlue		= {
	ADF_obj_hotel = true;
	["2S","","VADER this is TWO SIERRA. Stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA this is VADER. Send. Over."] call ADF_fnc_MessageParser; sleep 8;	
	["2S","","VADER this is TWO SIERRA. DELTA is intact and secured. How copy?"] call ADF_fnc_MessageParser; sleep 10;
	["ACO","ACO","TWO SIERRA this is VADER. Solid copy. Proceed with tasking. Over."] call ADF_fnc_MessageParser; sleep 11;
	["2S","","VADER this is TWO SIERRA. Wilco. Out."] call ADF_fnc_MessageParser;
};

ADF_msg_EchoBlue		= {
	ADF_obj_hotel = true;
	["2S","","VADER this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA this is VADER. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","VADER this is TWO SIERRA. ECHO secured in one piece. How copy?"] call ADF_fnc_MessageParser; sleep 12;
	["ACO","ACO","TWO SIERRA this is VADER. Good copy. Proceed with mission. Over"] call ADF_fnc_MessageParser; sleep 10;
	["2S","","VADER this is TWO SIERRA. Roger. Out."] call ADF_fnc_MessageParser;
};

ADF_msg_RomeoBlue		= {
	ADF_obj_hotel = true;
	["2S","","VADER this is TWO SIERRA. Stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA this is VADER. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","VADER this is TWO SIERRA. ROMEO is blue. How copy?"] call ADF_fnc_MessageParser; sleep 9;
	["ACO","ACO","TWO SIERRA this is VADER. Roger. ROMEO secured. Proceed with tasking. Over."] call ADF_fnc_MessageParser; sleep 11;
	["2S","","VADER this is TWO SIERRA. Solid copy. Out."] call ADF_fnc_MessageParser;
};

ADF_msg_foxtrotAmmo	= {
	["2S","","VADER this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA this is VADER. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","VADER this is TWO SIERRA. The south hangar at FOXTROT houses a large ammo cache. Interrogative tasking. How copy?"] call ADF_fnc_MessageParser; sleep 11;
	["ACO","ACO","TWO SIERRA this is VADER. Solid copy. Stay on mission. EOU will deal with with the ammo cache later. Over."] call ADF_fnc_MessageParser; sleep 16;
	["2S","","VADER this is TWO SIERRA. Roger. Out."] call ADF_fnc_MessageParser;
};

ADF_msg_foxtrotBase	= {
	["2S","","VADER this is TWO SIERRA. Stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA this is VADER. Send. Over."] call ADF_fnc_MessageParser; sleep 8;	
	["2S","","VADER this is TWO SIERRA. We are at FOXTROT. There are ten plus CSAT vehicles here, including two APC's How copy?"] call ADF_fnc_MessageParser; sleep 11;
	["ACO","ACO","TWO SIERRA this is VADER. Good copy. SPG Engineers will deal with the CSAT assets. Over."] call ADF_fnc_MessageParser; sleep 12;
	["2S","","VADER this is TWO SIERRA. Roger. Out."] call ADF_fnc_MessageParser;
};

ADF_msg_hotelSupply	= {
	["2S","","VADER this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA this is VADER. Send. Over."] call ADF_fnc_MessageParser; sleep 8;	
	["2S","","VADER this is TWO SIERRA. We found a CSAT supply warehouse at HOTEL. How copy?"] call ADF_fnc_MessageParser; sleep 11;
	["ACO","ACO","TWO SIERRA this is VADER. Solid copy. Search for intel and continue wuth tasking. Over."] call ADF_fnc_MessageParser; sleep 10;
	["2S","","VADER this is TWO SIERRA. Wilco. Out."] call ADF_fnc_MessageParser;
};

ADF_msg_golfFuel	= {
	["2S","","VADER this is TWO SIERRA. Stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA this is VADER. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 8;	
	["2S","","VADER this is TWO SIERRA. There's a large fuel dump at Golf. How copy?"] call ADF_fnc_MessageParser; sleep 11;
	["ACO","ACO","TWO SIERRA this is VADER. Wait. Over."] call ADF_fnc_MessageParser; sleep 19;
	["ACO","ACO","TWO SIERRA this is VADER. MOTHER wants to salvage the fuel dump. Ignore the fuel dump and Proceed with tasking. Over."] call ADF_fnc_MessageParser; sleep 14;
	["2S","","VADER this is TWO SIERRA. Wilco. Out."] call ADF_fnc_MessageParser;
};

ADF_msg_endMission	= {
	["ACO","ACO","TWO SIERRA this is VADER. MOTHER send his congratulations. Break. We are dispatching SPG, 1ST and 3RD to set-up security. Break. Head over to FOXTROT. 22nd will bring the mess truck with some cold ones.<br/><br/>Splendid adchievement boys! Out."] call ADF_fnc_MessageParser;
	sleep 10;
	_l = ["tLayer"] call BIS_fnc_rscLayer; 
	_l cutText ["", "BLACK", 20];
	["<img size= '10' shadow='false' image='Img\intro_TwoSierra.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 09 | Keyhole</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
	['END2',true,22] call BIS_fnc_endMission;
};
	