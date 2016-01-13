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
		["19 MAY 2019","<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"],
		["ZARGABAD REGIONAL DISTRICT","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"],
		["RV ZEBRA, NORTH OF MSR LIMA","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"]
	] spawn ADF_fnc_typeWriter;

	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA at ROMEO VICTOR ZEBRA. How copy?"] call ADF_fnc_MessageParser; sleep 15;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Solid copy. Stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 6;
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Standing-by. Over."] call ADF_fnc_MessageParser; sleep 9;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. FRAGO:<br/><br/>1. Locate BEARCLAW. Intel indicates BEARCLAW is held captive somewhere in grid ALPHA or in grid BRAVO. Break.<br/><br/>2. Neutralize XRAY. Break."] call ADF_fnc_MessageParser; sleep 17;

	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>Latest intel:<br/><br/>1. CEASAR is allowing us to search for XRAY. CEASAR has no knowledge of BEARCLAW.<br/><br/>2. CEASAR is to be considered neutral. Do not engage unless fired upon.<br/><br/>3. When stopped by CEASAR, follow instructions. Notify FIRESTONE immediately.<br/><br/>4. Avoid CEASAR red zones. Avoid Zargabad marked grid. Avoid any and all religious sites.<br/><br/>5. Avoid civilian casualties at all cost. Minimize civilian contact.<br/><br/>6. Stay on roads as much as possible. Off-road is only permitted in ALHPA, BRAVO and XRAY objective. Avoid collateral damage.<br/><br/>7. Check your fire. Weapons cold until ordered otherwise. Out.</font><br/><br/>"]];	

	for "_i" from 0 to 40 do {
		hintSilent parseText "<img size= '5' shadow='false' image='Img\logo_ACO.paa'/><br/><br/><t color='#6C7169' align='left'>1. CEASAR is allowing us to search for XRAY. CEASAR has no knowledge of BEARCLAW. Break.</t><br/><br/><t color='#6C7169' align='left'>2. CEASAR is to be considered neutral. Do not engage unless fired upon. Break.</t><br/><br/><t color='#6C7169' align='left'>3. When stopped by CEASAR, follow instructions. Notify FIRESTONE immediately. Break.</t><br/><br/><t color='#6C7169' align='left'>4. Avoid CEASAR red zones. Avoid ZARGABAD marked grid. Avoid any and all religious sites. Break.</t><br/><br/><t color='#6C7169' align='left'>5. Avoid civilian casualties at all cost. Minimize civilian contact. Break.</t><br/><br/><t color='#6C7169' align='left'>6. Stay on roads as much as possible. Off-road only permitted in ALHPA, BRAVO and XRAY objective. Avoid collateral damage. Break.</t><br/><br/><t color='#6C7169' align='left'>7. Check your fire. Weapons cold until ordered otherwise. How copy?</t><br/><br/>";
		sleep 1;
	};
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Copy on all. We are OSCAR MIKE. Out."] call ADF_fnc_MessageParser; sleep 15;
};

ADF_msg_cp = {
	hintSilent parseText"<img size= '7' shadow='false' image='Img\logo_CSAT.paa'/><br/><br/><t color='#e36b6b' size='1.5'>STOP!</t><br/><br/><t color='#6C7169' align='left'>Corporal Derafsh: wait here infidel.</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: Corporal Derafsh</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>STOP! Wait here infidel.</font><br/><br/>"]];
	sleep 10;

	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA at Checkpoint 3. We've been ordered to halt. How copy?"] call ADF_fnc_MessageParser; sleep 9;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Solid copy. Sit tight. Order your men to hold it together. Let's see what CSAT wants. Over."] call ADF_fnc_MessageParser; sleep 9;
	["CSAT","Corporal Derafsh","Corporal Derafsh: Infidel, where ar yu papers?"] call ADF_fnc_MessageParser; sleep 8;
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. CSAT is asking if we have papers. Over."] call ADF_fnc_MessageParser; sleep 7;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Inform CSAT to contact Colonel Mahshid. He will clear your passage. Over."] call ADF_fnc_MessageParser; sleep 7;
	["CSAT","Corporal Derafsh","Corporal Derafsh: Yu do not give urder too me infidel. Dis is not Amerika.<br/><br/>Wate heer!"] call ADF_fnc_MessageParser; sleep 70;
	["CSAT","Corporal Derafsh","Corporal Derafsh: Yu can go.<br/><br/>Go now!"] call ADF_fnc_MessageParser; sleep 7;
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. We are OSCAR MIKE. Out."] call ADF_fnc_MessageParser;
};

ADF_AO_alpha = {
	["2S", "TWO SIERRA", "FIRESTONE this is TWO SIERRA. We are approaching grid ALPHA. Over."] call ADF_fnc_MessageParser; sleep 15;
	["ACO", "ACO", "TWO SIERRA this is FIRESTONE. Roger. Stand-by for traffic. Over."] call ADF_fnc_MessageParser;  sleep 7;
	["2S", "TWO SIERRA", "FIRESTONE this is TWO SIERRA. Standing-by. Over."] call ADF_fnc_MessageParser; sleep 30;
	["ACO", "ACO", "TWO SIERRA this is FIRESTONE. Traffic. Additional intel ALPHA grid. Break.<br/><br/>1. ACE has confirmed 30+ ELVIS pax in and around ALPHA. Break<br/><br/>2. ACE is tracking 3 ELVIS victors around ALPHA. How copy?"] call ADF_fnc_MessageParser; sleep 20;
	["2S", "TWO SIERRA", "FIRESTONE this TWO SIERRA. Solid copy on all. Out."] call ADF_fnc_MessageParser;
};

ADF_AO_bravo = {
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. We are closing in on BRAVO. Over."] call ADF_fnc_MessageParser; sleep 15;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Solid copy. Stand-by for traffic. Over."] call ADF_fnc_MessageParser;  sleep 7;
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Standing-by. Over."] call ADF_fnc_MessageParser; sleep 30;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Traffic. Additional intel BRAVO grid. Break.<br/><br/>1. MOTHER is tracking 20+ ELVIS pax in BRAVO grid. Break.<br/><br/>2. ACE is tracking 2 victors around BRAVO. Several CEASAR victors in the vicinity of BRAVO. Over."] call ADF_fnc_MessageParser; sleep 20;
	["2S","TWO SIERRA","FIRESTONE this TWO SIERRA. Solid copy on all. Out."] call ADF_fnc_MessageParser;
};

ADF_msg_xRay = {
	private ["_p", "_msg"];
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 11;
	_p = getPos vXray;
	_msg = format ["TWO SIERRA","FIRESTONE this is TWO SIERRA at location XRAY. Grid PAPPA VICTOR %1 . %2. Over.",round (_p select 0), round (_p select 1)];
	["2S",_msg] call ADF_fnc_MessageParser; sleep 15;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Solid copy. ACE has you on SatNav. Proceed with tasking. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Roger. Out."] call ADF_fnc_MessageParser; sleep 8;
};

// CEASAR switch sides
[] spawn {
	waitUntil {sleep 10; CSAThostile};	
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Priority message. Over."] call ADF_fnc_MessageParser; sleep 15;
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. CEASAR and ELVIS have joined forces. CEASAR is now to be considered hostile. Break.<br/>ROE remains unchanged. Let's wrap this up asap! Out."] call ADF_fnc_MessageParser; sleep 15;
};

// XRAY destroyed
ADF_fnc_xRayDestroyed = {
	player addRating 15000;
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 12;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. XRAY neutralized. How copy?"] call ADF_fnc_MessageParser; sleep 12;
	if (BearclawRescued) then {
		["ACO","ACO","TWO SIERRA this is FIRESTONE. Solid copy. Escort BEARCLAW back to RV ZEBRA. How copy?"] call ADF_fnc_MessageParser; sleep 12;
		["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Roger. Out."] call ADF_fnc_MessageParser;
	} else {
		["ACO","ACO","TWO SIERRA this is FIRESTONE. Good copy. Break. Your next objective is to locate and secure BEARCLAW. Over"] call ADF_fnc_MessageParser; sleep 16;
		["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Wilco. Out."] call ADF_fnc_MessageParser;
	};
};

ADF_msg_endMission = {
	["ACO","ACO","Good to see you made it back TWO SIERRA.<br/><br/>Regroup and RTB."] call ADF_fnc_MessageParser; sleep 10;
	
	_l = ["tLayer"] call BIS_fnc_rscLayer; 
	_l cutText ["", "BLACK", 20];
	["<img size= '10' shadow='false' image='Img\intro_TwoSierra.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 01 | Bearclaw</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
	['END1',true,22] call BIS_fnc_endMission;
};
