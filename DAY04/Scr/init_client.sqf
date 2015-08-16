diag_log "ADF RPT: Init - executing init_client.sqf"; // Reporting. Do NOT edit/remove

call compile preprocessFileLineNumbers "Core\F\ADF_fnc_typeWriter.sqf";
player createDiarySubject ["Two Sierra Log","Two Sierra Log"];
player createDiaryRecord ["Two Sierra Log",["Two Sierra Communications Log","<br/><br/><font color='#6c7169'>The Two Sierra Log is a logbook of all operational radio comms between Two Sierra and ACO<br/>The messages are logged once displayed on screen. All messages are time-stamped and saved in order of appearance.</font><br/><br/>"]];

waitUntil {ADF_gearLoaded}; // Wait till the unit has their gear before continuing

sleep 3; // Loadout finished > pri weapon loaded

// PC 		- MRAP_INF_PC
if !(isNil "INF_PC") then {if (player == INF_PC) then {INF_PC assignAsCargo MRAP_INF_PC; INF_PC moveInCargo MRAP_INF_PC}};
if !(isNil "INF_RTO_1") then {if (player == INF_RTO_1) then {INF_RTO_1 assignAsDriver MRAP_INF_PC; INF_RTO_1 moveInDriver MRAP_INF_PC}};
// 2-1 SQUAD L	- MRAP_1INF_2
if !(isNil "INF_SQL_1") then {if (player == INF_SQL_1) then {INF_SQL_1 assignAsCargo MRAP_1INF_2; INF_SQL_1 moveInCargo MRAP_1INF_2}};
if !(isNil "INF_CLS_1") then {if (player == INF_CLS_1) then {INF_CLS_1 assignAsCargo MRAP_1INF_2; INF_CLS_1 moveInCargo MRAP_1INF_2}};
// 2-1 ALPHA	- MRAP_1INF_1
if !(isNil "INF_FTL_1") then {if (player == INF_FTL_1) then {INF_FTL_1 assignAsCargo MRAP_1INF_1; INF_FTL_1 moveInCargo MRAP_1INF_1}};
if !(isNil "INF_AR_1") then {if (player == INF_AR_1) then {INF_AR_1 assignAsDriver MRAP_1INF_1; INF_AR_1 moveInDriver MRAP_1INF_1}};
if !(isNil "INF_R_1") then {if (player == INF_R_1) then {INF_R_1 assignAsGunner MRAP_1INF_1; INF_R_1 moveInGunner MRAP_1INF_1}};
// 2-1 BRAVO	- MRAP_1INF_2
if !(isNil "INF_AR_2") then {if (player == INF_AR_2) then {INF_AR_2 assignAsDriver MRAP_1INF_2; INF_AR_2 moveInDriver MRAP_1INF_2}};

// 2-2 SQUAD L	- MRAP_1INF_4
if !(isNil "INF_SQL_2") then {if (player == INF_SQL_2) then {INF_SQL_2 assignAsCargo MRAP_1INF_4; INF_SQL_2 moveInCargo MRAP_1INF_4}};
if !(isNil "INF_CLS_2") then {if (player == INF_CLS_2) then {INF_CLS_2 assignAsCargo MRAP_1INF_4; INF_CLS_2 moveInCargo MRAP_1INF_4}};
// 2-2 ALPHA	- MRAP_1INF_3
if !(isNil "INF_AR_3") then {if (player == INF_AR_3) then {INF_AR_3 assignAsDriver MRAP_1INF_3; INF_AR_3 moveInDriver MRAP_1INF_3}};
if !(isNil "INF_R_3") then {if (player == INF_R_3) then {INF_R_3 assignAsGunner MRAP_1INF_3; INF_R_3 moveInGunner MRAP_1INF_3}};
// 2-2 BRAVO	- MRAP_1INF_4
if !(isNil "INF_FTL_4") then {if (player == INF_FTL_4) then {INF_FTL_4 assignAsCargo MRAP_1INF_4; INF_FTL_4 moveInCargo MRAP_1INF_4}};
if !(isNil "INF_AR_4") then {if (player == INF_AR_4) then {INF_AR_4 assignAsDriver MRAP_1INF_4; INF_AR_4 moveInDriver MRAP_1INF_4}};

// 2-1/2 AQUAD	- TRPTTRUCK_INF1
if !(isNil "INF_RAT_1") then {if (player == INF_RAT_1) then {INF_RAT_1 assignAsDriver TRPTTRUCK_INF1; INF_RAT_1 moveInDriver TRPTTRUCK_INF1}};
if !(isNil "INF_FTL_2") then {if (player == INF_FTL_2) then {INF_FTL_2 assignAsCargo TRPTTRUCK_INF1; INF_FTL_2 moveInCargo TRPTTRUCK_INF1}};
if !(isNil "INF_FTL_3") then {if (player == INF_FTL_3) then {INF_FTL_3 assignAsCargo TRPTTRUCK_INF1; INF_FTL_3 moveInCargo TRPTTRUCK_INF1}};
if !(isNil "INF_R_2") then {if (player == INF_R_2) then {INF_R_2 assignAsCargo TRPTTRUCK_INF1; INF_R_2 moveInCargo TRPTTRUCK_INF1}};
if !(isNil "INF_AAR_2") then {if (player == INF_AAR_2) then {INF_AAR_2 assignAsCargo TRPTTRUCK_INF1; INF_AAR_2 moveInCargo TRPTTRUCK_INF1}};
if !(isNil "INF_RAT_2") then {if (player == INF_RAT_2) then {INF_RAT_2 assignAsCargo TRPTTRUCK_INF1; INF_RAT_2 moveInCargo TRPTTRUCK_INF1}};
if !(isNil "INF_AAR_1") then {if (player == INF_AAR_1) then {INF_AAR_1 assignAsCargo TRPTTRUCK_INF1; INF_AAR_1 moveInCargo TRPTTRUCK_INF1}};
if !(isNil "INF_RAT_3") then {if (player == INF_RAT_3) then {INF_RAT_3 assignAsCargo TRPTTRUCK_INF1; INF_RAT_3 moveInCargo TRPTTRUCK_INF1}};	
if !(isNil "INF_R_4") then {if (player == INF_R_4) then {INF_R_4 assignAsCargo TRPTTRUCK_INF1; INF_R_4 moveInCargo TRPTTRUCK_INF1}};
if !(isNil "INF_AAR_4") then {if (player == INF_AAR_4) then {INF_AAR_4 assignAsCargo TRPTTRUCK_INF1; INF_AAR_4 moveInCargo TRPTTRUCK_INF1}};
if !(isNil "INF_RAT_4") then {if (player == INF_RAT_4) then {INF_RAT_4 assignAsCargo TRPTTRUCK_INF1; INF_RAT_4 moveInCargo TRPTTRUCK_INF1}};
if !(isNil "INF_AAR_3") then {if (player == INF_AAR_3) then {INF_AAR_3 assignAsCargo TRPTTRUCK_INF1; INF_AAR_3 moveInCargo TRPTTRUCK_INF1}};

// 2-3 ALPHA	- MRAP_1INF_WT1
if !(isNil "INF_WTL_1") then {if (player == INF_WTL_1) then {INF_WTL_1 assignAsCargo MRAP_1INF_WT1; INF_WTL_1 moveInCargo MRAP_1INF_WT1}};
if !(isNil "INF_CLS_3") then {if (player == INF_CLS_3) then {INF_CLS_3 assignAsCargo MRAP_1INF_WT1; INF_CLS_3 moveInCargo MRAP_1INF_WT1}};
if !(isNil "INF_AMG_1") then {if (player == INF_AMG_1) then {INF_AMG_1 assignAsGunner MRAP_1INF_WT1; INF_AMG_1 moveInGunner MRAP_1INF_WT1}};
if !(isNil "INF_MG_1") then {if (player == INF_MG_1) then {INF_MG_1 assignAsDriver MRAP_1INF_WT1; INF_MG_1 moveInDriver MRAP_1INF_WT1}};
// 2-3 ALPHA	- MRAP_1INF_WT2
if !(isNil "INF_MS_1") then {if (player == INF_MS_1) then {INF_MS_1 assignAsCargo MRAP_1INF_WT2; INF_MS_1 moveInCargo MRAP_1INF_WT2}};
if !(isNil "INF_AMS_1") then {if (player == INF_AMS_1) then {INF_AMS_1 assignAsDriver MRAP_1INF_WT2; INF_AMS_1 moveInDriver MRAP_1INF_WT2}};
if !(isNil "INF_HMG_1") then {if (player == INF_HMG_1) then {INF_HMG_1 assignAsGunner MRAP_1INF_WT2; INF_HMG_1 moveInGunner MRAP_1INF_WT2}};
if !(isNil "INF_AHMG_1") then {if (player == INF_AHMG_1) then {INF_AHMG_1 assignAsCargo MRAP_1INF_WT2; INF_AHMG_1 moveInCargo MRAP_1INF_WT2}};

waitUntil {sleep 2; ADF_missionInit}; sleep 5;

[
	["26 MAY 2019","<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"],
	["FERUZ ABAD PROVINCE","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"],
	["FOB JOHNSON, KUSHAB","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"]
] spawn ADF_fnc_typeWriter;

hintSilent parseText "<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE this is TWO SIERRA at JOHNSON. How copy?</t><br/><br/>";

sleep 12;

hintSilent parseText "<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/>
<t color='#6C7169' align='left'>FIRESTONE: Copy TWO SIERRA. Head out North, North West and locate and neutralize AKIRA. Out.</t><br/><br/>";
_logTime = [dayTime] call BIS_fnc_timeToString;
_logTimeText = "Log: " + _logTime;
player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: Copy TWO SIERRA. Head out North, North West and locate and neutralize AKIRA. Out.</font><br/><br/>"]];

// AKIRA
[] spawn {
	waitUntil {sleep 7; tBOPlive};
	
	hintSilent parseText "<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE. this is TWO SIERRA. AKIRA located. How copy?.</t><br/><br/>";
	
	uiSleep 8;
	
	hintSilent parseText "<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: Roger TWO SIERRA. Neutralize AKIRA. No prisoners. Out.</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: Roger TWO SIERRA. Neutralize AKIRA. No prisoners. Out.</font><br/><br/>"]];
};

[] spawn {
	waitUntil {sleep 30; ADF_Fairlight};

	hintSilent parseText "<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: TWO SIERRA. Priority message: FAIRLIGHT activated. RTB. How copy?.</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: TWO SIERRA. Priority message: FAIRLIGHT activated. RTB. How copy?.</font><br/><br/>"]];
	
	sleep 20;
	
	hintSilent parseText "<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>Roger FIRESTONE. RTB. Out</t><br/><br/>";
	
	sleep 20;

	_l = ["tLayer"] call BIS_fnc_rscLayer; 
	_l cutText ["", "BLACK", 20];
	["<img size= '10' shadow='false' image='Img\2SIERRA_intro.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 04 | Hannibal</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
	['END2',true,22] call BIS_fnc_endMission;
};


// End Mission comms
[] spawn {
	waitUntil {sleep 7; ADF_endMission};
	
	hintSilent parseText "<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE. this is TWO SIERRA. AKIRA neutralized. How copy?.</t><br/><br/>";
	
	uiSleep 8;
	
	hintSilent parseText "<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: Good job TWO SIERRA. Return to JOHNSON for debrief. Over.</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: Good job TWO SIERRA. Return to JOHNSON for debrief. Over</font><br/><br/>"]];
	
	uiSleep 11;
	
	hintSilent parseText "<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>Copy FIRESTONE. TWO SIERRA oscar mike. Out.</t><br/><br/>";
	
	waitUntil {sleep 5; triggerActivated tEndMission};
			
	sleep 10;

	hintSilent parseText "<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRSTONE: Good to see you back in once piece TWO SIERRA.</t><br/><br/><t color='#6C7169' align='left'>MOTHER just issued FAIRLIGHT protocol. We are leaving this hell hole.</t><br/><br/><t color='#6C7169' align='left'>Return to LEO and pack-up you shit. Oh and by the way, Nice work on that base camp.</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRSTONE: Good to see you back in once piece TWO SIERRA.<br/><br/>MOTHER just issued FAIRLIGHT protocol. We are leaving this hell hole.<br/><br/>Return to LEO and pack-up you shit. Oh and by the way, Nice work on that base camp.</font><br/><br/>"]];
	
	sleep 20;

	_l = ["tLayer"] call BIS_fnc_rscLayer; 
	_l cutText ["", "BLACK", 20];
	["<img size= '10' shadow='false' image='Img\2SIERRA_intro.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 04 | Hannibal</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
	['END1',true,22] call BIS_fnc_endMission;
};

	