diag_log "ADF RPT: Init - executing init_client.sqf"; // Reporting. Do NOT edit/remove

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

if (didJIP) exitWith {};

waitUntil {sleep 2; ADF_missionInit}; sleep 5;

[
	["22 JUN 2019","<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"],
	["CHERNARUS","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"],
	["NOLA AB","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"]
] spawn ADF_fnc_typeWriter;

["ACO","ACO","FAIRCHILD: TWO SIERRA, get your defences in order as soon as possible. ACE expects VLAD to commence its assault within the next 30 minutes.<br/><br/>DONALD is securing DIANA and JANE<br/><br/>Good luck TWO SIERRA. Out."] call ADF_fnc_MessageParser; 

ADF_msg_MBT = {
	["ACO","ACO","FAIRCHILD: TWO SIERRA this is FAIRCHILD. Priority message. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","TWO SIERRA: FIRESTONE this is TWO SIERRA. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","FAIRCHILD: TWO SIERRA this is FAIRCHILD. ACE is tracking 2 kings and several victors and APC's. Break. ETA 6 mikes. Get your AT specialists ready! Out."] call ADF_fnc_MessageParser;
};

ADF_msg_INF = {
	["ACO","ACO","FAIRCHILD: TWO SIERRA this is FAIRCHILD. Message. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","TWO SIERRA: FIRESTONE this is TWO SIERRA. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","FAIRCHILD: TWO SIERRA, ACE is tracking 10 to 12 squads heading your way. Get ready! Out."] call ADF_fnc_MessageParser;
};

ADF_msg_sweep = {
	["ACO","ACO","FIRESTONE: TWO SIERRA this is FIRESTONE. Message. Over."] call ADF_fnc_MessageParser; sleep 7;
	["2S","","TWO SIERRA: FIRESTONE this is TWO SIERRA. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","FAIRCHILD: TWO SIERRA, ACE reports the last remaining OPFOR are scattered around NOLA. Do not let them retreat. Break. Mount up in your vehicles and clear and secure the area. How copy?"] call ADF_fnc_MessageParser; sleep 22;
	["2S","TWO SIERRA","FAIRCHILD this is TWO SIERRA. Solid copy on all. Out."] call ADF_fnc_MessageParser; sleep 9;
};

ADF_msg_endMission = {
	if (time > 9000) then {
		["ACO","ACO","FAIRCHILD: TWO SIERRA this is FAIRCHILD. Message. Over."] call ADF_fnc_MessageParser; sleep 11;
		["2S","","TWO SIERRA: FIRESTONE this is TWO SIERRA. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
		["ACO","ACO","FAIRCHILD: MOTHER is pulling you out. 4TH will finish up at NOLA. Break.<br/><br/>Head back to FARGO and pack up you gear. You're moving out to another hot zone tomorrow morning.<br/><br/>Good job TWO SIERRA. Out."] call ADF_fnc_MessageParser; sleep 25;
		_l = ["tLayer"] call BIS_fnc_rscLayer; 
		_l cutText ["", "BLACK", 20];
		["<img size= '10' shadow='false' image='Img\intro_TwoSierra.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 08 | Novi Disha</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
		['END1',true,22] call BIS_fnc_endMission;
	} else {
		["2S","","TWO SIERRA: FIRESTONE this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 6;
		["ACO","ACO","FIRESTONE: This is FIRESTONE. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 8;
		["2S","TWO SIERRA","NOLA is blue and secured. How copy?"] call ADF_fnc_MessageParser; sleep 14;
		["ACO","ACO","FIRESTONE: Solid copy TWO SIERRA. Job well done. Break.<br/><br/>MOTHER is pulling you out. 4TH will take care of NOLA security. Break.<br/><br/>Head back to FARGO and pack up you gear. You're moving out to another hot zone tomorrow morning. Out."] call ADF_fnc_MessageParser; sleep 15;
		_l = ["tLayer"] call BIS_fnc_rscLayer; 
		_l cutText ["", "BLACK", 20];
		["<img size= '10' shadow='false' image='Img\intro_TwoSierra.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 08 | Novi Disha</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
		['END1',true,22] call BIS_fnc_endMission;	
	};
};
	