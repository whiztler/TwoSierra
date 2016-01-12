diag_log "ADF RPT: Init - executing Scr\init_client.sqf"; // Reporting. Do NOT edit/remove

call compile preprocessFileLineNumbers "Core\F\ADF_fnc_typeWriter.sqf";
player createDiarySubject ["Two Sierra Log","Two Sierra Log"];
player createDiaryRecord ["Two Sierra Log",["Two Sierra Communications Log","<br/><br/><font color='#6c7169'>The Two Sierra Log is a logbook of all operational radio comms between Two Sierra and ACO<br/>The messages are logged once displayed on screen. All messages are time-stamped and saved in order of appearance.</font><br/><br/>"]];

ADF_fnc_MOTS = {player allowDamage false; MotsActive = true};
ADF_fnc_MOTS_captive = {params ["_c"]; player setCaptive _c};

waitUntil {!isNil "foggyBottom"};
0 setFog foggyBottom;
_hdl = ppEffectCreate ["colorCorrections", 1501];
_hdl ppEffectEnable true;			
_hdl ppEffectAdjust [.6, 1.0, 0.0, [0.84, 0.67, 0.44, 0.22], [0.81, 0.76, 0.64, 0.43], [0.81, 0.77, 0.62, 0.31]]; // light beige/dessert
_hdl ppEffectCommit 0;

// Desert Storm
desertStorm = [player,0.05,0.9,false] call BIS_fnc_sandStorm;
[.45] execVM "Scr\goon_dust.sqf";

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

ADF_msg_tPrice = {["Aegis","Aegis","Love to chat but we expect those Pashtun basteds launch another assault any minute now. They usually come at us around dusk. We're only 20 strong, including the storage facility and our checkpoint. We got a few 50 cals in those bunkers that have been holding them off quite successfully.<br/><br/>You fellas can set up your defences where ever you see fit. Gimme a shout if you fellas need anything."] call ADF_fnc_MessageParser;};
ADF_msg_tBaltimore = {["Aegis","Aegis","Dean Strawoski: Good to see you guys. Logan is waiting for you at the airfield."] call ADF_fnc_MessageParser;};

waitUntil {sleep 2; ADF_missionInit}; sleep 5;

if (!didJIP) then {
	[
		["23 MAY 2019","<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"],
		["SHAPUR DISTRICT","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"],
		["MSR PARIS, EAST OF KENNEDY","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"]
	] spawn ADF_fnc_typeWriter;

	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA, at MSR PARIS, over."] call ADF_fnc_MessageParser; sleep 15;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Roger.<br/>Drive to KENNEDY. Break. Contact Aegis CO 'Patrick Logan' at Aegis HQ. Logan will brief re latest intel. Break.<br/><br/>MOTHER suggests you stay clear of the red zone till we know what we are dealing with. How copy?"] call ADF_fnc_MessageParser; sleep 22;
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Good copy on all. Out."] call ADF_fnc_MessageParser; sleep 15;
};

// Assault defeated msg
[] spawn {
	waitUntil {sleep 10; ADF_pashtunWaveClear};
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA, Message. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 9;
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. JONAH assault defeated. Interrogative reinforcements. How copy?"] call ADF_fnc_MessageParser; sleep 15;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Solid Copy. Wait. Over."] call ADF_fnc_MessageParser; sleep 45;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 6;
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Send. Over"] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Clear and secure Blue grid. Break<br/><br/>When Blue grid is secure, assault and clear SATAN. Break. Drive JONAH out of SATAN. How copy?"] call ADF_fnc_MessageParser; sleep 22;
	["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Good copy on all. Out."] call ADF_fnc_MessageParser;
};

// End Mission
[] spawn {
	waitUntil {sleep 15; ADF_SatanClearUp};
	if (ADF_SatanControl) then {
		["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA, Message. Over."] call ADF_fnc_MessageParser; sleep 8;
		["ACO","ACO","TWO SIERRA this is FIRESTONE. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 9;
		["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA, SATAN is clear. JONAH body count 1-7-0. How copy?"] call ADF_fnc_MessageParser; sleep 15;
		["ACO","ACO","TWO SIERRA this is FIRESTONE. Solid copy.<br/><br/>Job well done. RTB. We got a bunch of cold ones waiting for you. Over."] call ADF_fnc_MessageParser; sleep 18;
		["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA, Roger. TWO SIERRRA is OSCAR MIKE. Out."] call ADF_fnc_MessageParser; sleep 20;
		_l = ["tLayer"] call BIS_fnc_rscLayer; 
		_l cutText ["", "BLACK", 20];
		["<img size= '10' shadow='false' image='Img\intro_TwoSierra.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 02 | Satan's Fire</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
		['END1',true,22] call BIS_fnc_endMission;	
	} else {	
		["ACO","ACO","TWO SIERRA this is FIRESTONE. Message. Over."] call ADF_fnc_MessageParser; sleep 7;
		["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
		["ACO","ACO","TWO SIERRA this is FIRESTONE. RTB. break.<br/><br/>4TH Platoon will finish and clean up SATAN. How copy?"] call ADF_fnc_MessageParser; sleep 16;
		["2S","TWO SIERRA","FIRESTONE this is TWO SIERRA. Solid copy. TWO SIERRA is OSCAR MIKE. Out."] call ADF_fnc_MessageParser; sleep 20;
		_l = ["tLayer"] call BIS_fnc_rscLayer; 
		_l cutText ["", "BLACK", 20];
		["<img size= '10' shadow='false' image='Img\intro_TwoSierra.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 02 | Satan's Fire</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
		['END2',true,22] call BIS_fnc_endMission;	
	};
};

	