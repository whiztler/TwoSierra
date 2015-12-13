diag_log "ADF RPT: Init - executing Scr\init_client.sqf"; // Reporting. Do NOT edit/remove

call compile preprocessFileLineNumbers "Core\F\ADF_fnc_typeWriter.sqf";
player createDiarySubject ["Two Sierra Log","Two Sierra Log"];
player createDiaryRecord ["Two Sierra Log",["Two Sierra Communications Log","<br/><br/><font color='#6c7169'>The Two Sierra Log is a logbook of all operational radio comms between Two Sierra and ACO<br/>The messages are logged once displayed on screen. All messages are time-stamped and saved in order of appearance.</font><br/><br/>"]];

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

	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA at RV ZEBRA"] call ADF_fnc_MessageParser; sleep 15;

	hintSilent parseText "<img size= '5' shadow='false' image='Img\logo_ACO.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: Copy TWO SIERRA. FRAGO:</t><br/><br/><t color='#6C7169' align='left'>1. Locate </t><t color='#9DA698' align='left'>BEARCLAW</t><t color='#6C7169' align='left'>. Intel indicates BEARCLAW is held captive somewhere in grid </t><t color='#9DA698' align='left'>ALPHA</t><t color='#6C7169' align='left'> or in grid </t><t color='#9DA698' align='left'>BRAVO</t><t color='#6C7169' align='left'>.</t><br/><br/><t color='#6C7169' align='left'>2. Neutralize </t><t color='#9DA698' align='left'>XRAY</t><t color='#6C7169' align='left'>. Break.</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: Copy TWO SIERRA. FRAGO:<br/><br/>1. Locate BEARCLAW. Intel indicates BEARCLAW is held captive somewhere in grid ALPHA or in grid BRAVO.<br/><br/>2. Neutralize XRAY. Break</font><br/><br/>"]];

	sleep 14;

	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: Latest intel:<br/><br/>1. CEASAR is allowing us to search for XRAY. CEASAR has no knowledge of BEARCLAW.<br/><br/>2. CEASAR is to be considered neutral. Do not engage unless fired upon.<br/><br/>3. When stopped by CEASAR, follow instructions. Notify FIRESTONE immediately.<br/><br/>4. Avoid CEASAR red zones. Avoid Zargabad marked grid. Avoid any and all religious sites.<br/><br/>5. Avoid civilian casualties at all cost. Minimize civilian contact.<br/><br/>6. Stay on roads as much as possible. Off-road is only permitted in ALHPA, BRAVO and XRAY objective. Avoid collateral damage.<br/><br/>7. Check your fire. Weapons cold until ordered otherwise. Out</font><br/><br/>"]];	

	for "_i" from 0 to 40 do {
		hintSilent parseText "<img size= '5' shadow='false' image='Img\logo_ACO.paa'/><br/><br/><t color='#6C7169' align='left'>1. CEASAR is allowing us to search for XRAY. CEASAR has no knowledge of BEARCLAW.</t><br/><t color='#6C7169' align='left'>2. CEASAR is to be considered neutral. Do not engage unless fired upon.</t><br/><t color='#6C7169' align='left'>3. When stopped by CEASAR, follow instructions. Notify FIRESTONE immediately.</t><br/><t color='#6C7169' align='left'>4. Avoid CEASAR red zones. Avoid ZARGABAD marked grid. Avoid any and all religious sites.</t><br/><t color='#6C7169' align='left'>5. Avoid civilian casualties at all cost. Minimize civilian contact.</t><br/><t color='#6C7169' align='left'>6. Stay on roads as much as possible. Off-road only permitted in ALHPA, BRAVO and XRAY objective. Avoid collateral damage.</t><br/><t color='#6C7169' align='left'>7. Check your fire. Weapons cold until ordered otherwise. Out.</t><br/><br/><br/>";
		sleep 1;
	};
};

// CEASAR switch sides
[] spawn {
	waitUntil {sleep 10; CSAThostile};	
	hintSilent parseText "<img size= '5' shadow='false' image='Img\logo_ACO.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: TWO SIERRA, </t><t color='#e15c13' align='left'>Urgent Message</t><t color='#6C7169' align='left'>.</t><br/><br/><t color='#6C7169' align='left'>CEASAR and ELVIS have joined forces. CEASAR is now to be considered hostile.</t><br/><t color='#6C7169' align='left'>ROE remains unchanged. Let's wrap this up asap! Out.</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: TWO SIERRA, Urgent Message<br/><br/>CEASAR and ELVIS have joined forces. CEASAR is now to be considered hostile.<br/>ROE remains unchanged. Let's wrap this up asap! Out</font><br/><br/>"]];
};

// XRAY destroyed
ADF_fnc_xRayDestroyed = {
	player addRating 15000;
	["2S","TWO SIERRA","TWO SIERRA: FIRESTONE this is TWO SIERRA. XRAY neutralized. How copy?"] call ADF_fnc_MessageParser; sleep 12;
	if (BearclawRescued) then {
		["ACO","ACO","FIRESTONE: Great fireworks TWO SIERRA. Escort BEARCLAW back to RV ZEBRA. Out."] call ADF_fnc_MessageParser;
	} else {
		["ACO","ACO","FIRESTONE: Good job TWO SIERRA. Your next objective is to locate and secure BEARCLAW. Out."] call ADF_fnc_MessageParser;
	};
};

