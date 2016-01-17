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
	["17 JUN 2019","<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"],
	["CHERNARUS","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"],
	["BALOTA AB","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"]
] spawn ADF_fnc_typeWriter;

["2S","","FAIRCHILD this is TWO SIERRA. We're OSCAR MIKE. Over."] call ADF_fnc_MessageParser; sleep 12;
["ACO","ACO","TWO SIERRA this is FAIRCHILD. Solid copy. Break. ACE has spotted several victors in NOVEMBER. Break. Expect more resistance. KUJO has mobilized its forces in the area. Break.<br /><br />IED’s are much harder to spot in the dark. Instruct your drivers to scan the roads carefully. Break.<br /><br />DONALD is patrolling in the green zone. Do not engage them. Break.<br /><br />Avoid the BORIS perimeter at any cost.<br /><br />Good luck TWO Sierra. Over."] call ADF_fnc_MessageParser; sleep 20;
["2S","","FAIRCHILD this is TWO SIERRA. Roger. Out"] call ADF_fnc_MessageParser;

ADF_fnc_CacheDestroyed = {
	ADF_cacheCnt = ADF_cacheCnt + 1;
	if (ADF_cacheCnt == 1) exitWith {
		sleep random 5;
		["2S","","FAIRCHILD this is TWO SIERRA. stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 6;
		["ACO","ACO","TWO SIERRA this is FAIRCHILD. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
		["2S","","FAIRCHILD this is TWO SIERRA. Found and destroyed one BULLDOG. How copy?"] call ADF_fnc_MessageParser; sleep 13;
		["ACO","ACO","TWO SIERRA this is TWO SIERRA this is FAIRCHILD Good copy. One BULLDOG destroyed. Continue with tasking. Over."] call ADF_fnc_MessageParser; sleep 11;
		["2S","","FAIRCHILD this is TWO SIERRA. Roger. Out"] call ADF_fnc_MessageParser;
	};
	if (ADF_cacheCnt == 2) exitWith {
		sleep random 5;
		["2S","","FAIRCHILD this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 6;
		["ACO","ACO","TWO SIERRA this is FAIRCHILD. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 8;			
		["2S","","FAIRCHILD this is TWO SIERRA. Found and destroyed another BULLDOG. How copy?"] call ADF_fnc_MessageParser; sleep 13;
		["ACO","ACO","TWO SIERRA this is FAIRCHILD Solid copy. Two BULLDOGS destroyed. Continue with tasking. Over."] call ADF_fnc_MessageParser; sleep 11;
		["2S","","FAIRCHILD this is TWO SIERRA. Roger. Out"] call ADF_fnc_MessageParser;
	};
	if (ADF_cacheCnt == 3) exitWith {
		ADF_endMission = true;
		sleep random 5;
		["2S","","FAIRCHILD this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 6;
		["ACO","ACO","TWO SIERRA this is FAIRCHILD. Send message. Over."] call ADF_fnc_MessageParser; sleep 8;			
		["2S","","FAIRCHILD this is TWO SIERRA. Destroyed BULLDOG number three. How copy?"] call ADF_fnc_MessageParser; sleep 13;
		["ACO","ACO","TWO SIERRA this is FAIRCHILD. Good copy. Break.<br/><br/>If you're up for it you can keep searching for more BULLDOGS. Break.<br/><br/>If not, you may RTB. Either case, mission accomplished. Over."] call ADF_fnc_MessageParser; sleep 20;
		["2S","","FAIRCHILD this is TWO SIERRA. Roger. Out"] call ADF_fnc_MessageParser;
	};
	if (ADF_cacheCnt == 4) exitWith {
		sleep random 5;
		["2S","","FAIRCHILD this is TWO SIERRA. stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 6;
		["ACO","ACO","TWO SIERRA this is FAIRCHILD. Send. Over."] call ADF_fnc_MessageParser; sleep 8;			
		["2S","","FAIRCHILD this is TWO SIERRA. We decided to keep looking. Just found and destroyed another BULLDOG. How copy?"] call ADF_fnc_MessageParser; sleep 13;
		["ACO","ACO","TWO SIERRA this is FAIRCHILD. Solid copy. BULLDOG number four destroyed. Out."] call ADF_fnc_MessageParser;	
	};
	if (ADF_cacheCnt == 5) exitWith {
		sleep random 5;
		["2S","","FAIRCHILD this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 6;
		["ACO","ACO","TWO SIERRA this is FAIRCHILD. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 8			
		["2S","","FAIRCHILD this is TWO SIERRA. BULLDOG number five destroyed. How copy?"] call ADF_fnc_MessageParser; sleep 13;
		["ACO","ACO","TWO SIERRA this is FAIRCHILD. Solid copy. RTB. That's an order! Over."] call ADF_fnc_MessageParser; sleep 14;
		["2S","","FAIRCHILD this is TWO SIERRA. Roger. Out"] call ADF_fnc_MessageParser;		
	};		
	if (ADF_cacheCnt == 6) exitWith {
		sleep random 5;
		["2S","","FAIRCHILD this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 6;
		["ACO","ACO","TWO SIERRA this is FAIRCHILD. Send. Over."] call ADF_fnc_MessageParser; sleep 8;					
		["2S","","FAIRCHILD this is TWO SIERRA. Six BULLDOGS destroyed. How copy?"] call ADF_fnc_MessageParser; sleep 13;
		["ACO","ACO","TWO SIERRA this is FAIRCHILD. Solid copy. Break. Appreciate the additional effort. Break.<br /><br />RTB. How copy?"] call ADF_fnc_MessageParser; sleep 18;
		["2S","","FAIRCHILD this is TWO SIERRA. Roger. TWO SIERRA is OSCAR MIKE. Out."] call ADF_fnc_MessageParser;	
	};		
};

ADF_endMissionMsg = {
	sleep 10;	
	["ACO","ACO","Job well done TWO SIERRA.<br/><br/>MOTHER said we delivered quite a blow by destroying those weapons caches.<br/><br/>Hot coffee and cold ones waiting in the mess."] call ADF_fnc_MessageParser; 
	sleep 20;

	_l = ["tLayer"] call BIS_fnc_rscLayer; 
	_l cutText ["", "BLACK", 20];
	["<img size= '10' shadow='false' image='Img\intro_TwoSierra.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 06 | Bulldogs</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
	['END1',true,22] call BIS_fnc_endMission;
};	