diag_log "ADF RPT: Init - executing init_client.sqf"; // Reporting. Do NOT edit/remove

call compile preprocessFileLineNumbers "Core\F\ADF_fnc_typeWriter.sqf";
player createDiarySubject ["Two Sierra Log","Two Sierra Log"];
player createDiaryRecord ["Two Sierra Log",["Two Sierra Communications Log","<br/><br/><font color='#6c7169'>The Two Sierra Log is a logbook of all operational radio comms between Two Sierra and ACO<br/>The messages are logged once displayed on screen. All messages are time-stamped and saved in order of appearance.</font><br/><br/>"]];

waitUntil {!isNil "foggyBottom"};
0 setFog foggyBottom;
if (!isDedicated) then {	
	_hdl = ppEffectCreate ["colorCorrections", 1501];
	_hdl ppEffectEnable true;			
	_hdl ppEffectAdjust [.6, 1.0, 0.0, [0.84, 0.67, 0.44, 0.22], [0.81, 0.76, 0.64, 0.43], [0.81, 0.77, 0.62, 0.31]]; // light beige/dessert
	_hdl ppEffectCommit 0;
};

// Desert Storm
desertStorm = [player,0.05,0.9,false] call BIS_fnc_sandStorm;
[.45] execVM "Scr\goon_dust.sqf";

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

ADF_msg_tPrice = {
	hintSilent parseText "<img size= '5' shadow='false' image='Img\aegis_logo.paa'/><br/><br/><t color='#6C7169' align='left'>Patrick Logan: great to see you TWO SIERRA.</t><br/><br/><t color='#6C7169' align='left'>Love to chat but we expect those Pashtun basteds launch another assault any minute now. They usually come at us around dusk. We're only 20 strong, including the storage facility and our checkpoint. We got a few 50 cals in those bunkers that have been holding them off quite successfully.<br/><br/>You fellas can set up your defences where ever you see fit. Gimme a shout if you fellas need anything.</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: Aegis</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>Patrick Logan: great to see you TWO SIERRA.<br/><br/>DLove to chat but we expect those Pashtun basteds launch another assault any minute now. They usually come at us around dusk. We're only 20 strong, including the storage facility and our checkpoint. We got a few 50 cals in those bunkers that have been holding them off quite successfully.<br/><br/>You fellas can set up your defences where ever you see fit. Gimme a shout if you fellas need anything.</font><br/><br/>"]];
};

ADF_msg_tBaltimore = {
	hintSilent parseText "<img size= '5' shadow='false' image='Img\aegis_logo.paa'/><br/><br/><t color='#6C7169' align='left'>Dean Strawoski: Good to see you guys. Logan is waiting for you at the airfield.</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: Aegis</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>Dean Strawoski: Good to see you guys. Logan is waiting for you at the airfield.</font><br/><br/>"]];
};

waitUntil {sleep 2; ADF_missionInit}; sleep 5;

[
	["23 MAY 2019","<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"],
	["SHAPUR DISTRICT","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"],
	["MSR PARIS, EAST OF KENNEDY","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"]
] spawn ADF_fnc_typeWriter;

hintSilent parseText "<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE this is TWO SIERRA, at MSR PARIS, over.</t><br/><br/>";

sleep 15;

hintSilent parseText "<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: Copy TWO SIERRA.</t><br/>
<t color='#6C7169' align='left'>Drive to KENNEDY. Contact Aegis CO 'Patrick Logan' at Aegis HQ. Logan will brief re latest intel.<br/><br/>
MOTHER suggests you stay clear of the red zone till we know what we are dealing with. Good luck TWO SIERRA. Out.</t>";
_logTime = [dayTime] call BIS_fnc_timeToString;
_logTimeText = "Log: " + _logTime;
player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: Copy TWO SIERRA.<br/>Drive to KENNEDY. Contact Aegis CO 'Patrick Logan' at Aegis HQ. Logan will brief re latest intel. Out.</font><br/><br/>"]];

// Assault defeated msg
[] spawn {
	waitUntil {sleep 10; ADF_pashtunWaveClear};
	hintSilent parseText "<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE this is TWO SIERRA, JONAH assault defeated.  How about those reinforcements. How copy?</t><br/><br/>";

	sleep 12;

	hintSilent parseText "<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: Copy TWO SIERRA. Clear and secure the Blue Zone.<br/><br/>	When the Blue Zone is secure MOTHER wants you to assault and clear SATAN. Drive JONAH out of SATAN. Out.</t>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>	FIRESTONE: Copy TWO SIERRA.	Clear and secure the Blue Zone.<br/><br/>When the Blue Zone is secure MOTHER wants you to assault and clear SATAN. Drive JONAH out of SATAN. Out.</font><br/><br/>"]];
};

// End Mission
[] spawn {
	waitUntil {sleep 15; ADF_SatanClearUp};
	if (ADF_SatanControl) then {	
		hintSilent parseText "<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE this is TWO SIERRA, SATAN has been cleared. JONAH body count of more than 170. How copy?</t><br/><br/>";

		sleep 16;

		hintSilent parseText "<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: Copy TWO SIERRA.<br/><br/>Job well done. RTB. We got a bunch of cold one waiting for you. Out.</t><br/><br/>";
		_logTime = [dayTime] call BIS_fnc_timeToString;
		_logTimeText = "Log: " + _logTime;
		player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>	FIRESTONE: Copy TWO SIERRA.<br/><br/>Job well done. RTB. We got a bunch of cold one waiting for you. Out.</font><br/><br/>"]];

		sleep 20;

		_l = ["tLayer"] call BIS_fnc_rscLayer; 
		_l cutText ["", "BLACK", 20];
		["<img size= '10' shadow='false' image='Img\2SIERRA_intro.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 02 | Satan's Fire</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
		['END1',true,22] call BIS_fnc_endMission;	
	} else {	
		hintSilent parseText "<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: TWO SIERRA, time to wrap it up.<br/><br/>4TH Platoon will finish and clean up SATAN. RTB TWO SIERRA. Out.</t><br/><br/>";
		_logTime = [dayTime] call BIS_fnc_timeToString;
		_logTimeText = "Log: " + _logTime;
		player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: TWO SIERRA, time to wrap it up.<br/><br/>4TH Platoon will finish and clean up SATAN. RTB TWO SIERRA. Out.</font><br/><br/>"]];

		sleep 20;

		_l = ["tLayer"] call BIS_fnc_rscLayer; 
		_l cutText ["", "BLACK", 20];
		["<img size= '10' shadow='false' image='Img\2SIERRA_intro.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 02 | Satan's Fire</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
		['END2',true,22] call BIS_fnc_endMission;	
	};
};

	