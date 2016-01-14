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
		["26 MAY 2019","<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"],
		["FERUZ ABAD PROVINCE","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"],
		["LMAB, NRF 5TH BAT","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"]
	] spawn ADF_fnc_typeWriter;

	["ACO","ACO","Capt. James O'Conner: Good morning TWO SIERRA.<br/>Get your men ready. Leave NLT 04:45.<br/><br/>No air support till we know what we're dealing with. Good luck TWO SIERRA."] call ADF_fnc_MessageParser;
};

[] spawn {
	waitUntil {sleep 15; time > 1200 || triggerActivated tStart};
	if (triggerActivated tStart) exitWith {};
	["ACO","ACO","Capt. James O'Conner: It is 04:45. TWO SIERRA, get moving. Now!"] call ADF_fnc_MessageParser;
};

[] spawn {
	waitUntil {sleep 30; time > 9000}; // 30 mins left
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Message. Over."] call ADF_fnc_MessageParser; sleep 7;
	["2S","","FIRESTONE this is TWO SIERRA. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. You have 30 mikes left before MOTHER pulls you out. Break. After that it is RTB and mission aborted. Over."] call ADF_fnc_MessageParser; sleep 16;
	["2S","","FIRESTONE this is TWO SIERRA. Roger. Out."] call ADF_fnc_MessageParser; 
};

ADF_msg_start = {
	waitUntil {sleep 1; time > 360};
	["ACO","ACO","TWO SIERRA, this is FIRESTONE. Message. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","FIRESTONE this is TWO SIERRA. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 7;
	["ACO","ACO","TWO SIERRA, this is FIRESTONE. Frago: do not attempt to disarm IED's. Mark them for EOD. Over."] call ADF_fnc_MessageParser; sleep 14;
	["2S","","FIRESTONE this is TWO SIERRA. Roger. Will advice EOD of IED locations. Over."] call ADF_fnc_MessageParser;
	["ACO","ACO","TWO SIERRA, this is FIRESTONE. Good luck. Out."] call ADF_fnc_MessageParser;
};

ADF_msg_dolphin = {
	["2S","","FIRESTONE, this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA, this is FIRESTONE. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","FIRESTONE, TWO SIERRA is at location DOLPHIN. Doesn't look good. Over."] call ADF_fnc_MessageParser; sleep 12;
	["ACO","ACO","TWO SIERRA, this is FIRESTONE. Solid copy. Neutralize DOLPHIN and proceed with tasking. Over."] call ADF_fnc_MessageParser; sleep 11;
	["2S","","FIRESTONE, this is TWO SIERRA. Roger. Out."] call ADF_fnc_MessageParser; sleep 8;
};

ADF_msg_greenZone = {
	params ["_n"];
	ADF_greenCnt = ADF_greenCnt + 1;

	if (ADF_greenCnt < 4) then {publicVariable "ADF_greenCnt";};
	
	["2S","","FIRESTONE, this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 5;
	["ACO","ACO","TWO SIERRA, this is FIRESTONE. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 7;
	["2S","","FIRESTONE this is TWO SIERRA, requesting permission to cross green zone. How copy?"] call ADF_fnc_MessageParser; sleep 15;

	if (_n == 1) exitWith {["ACO","ACO","TWO SIERRA, this is FIRESTONE. Negative TWO SIERRA. Permission denied. Out."] call ADF_fnc_MessageParser;};
	if (_n == 2) exitWith {["ACO","ACO","TWO SIERRA, this is FIRESTONE. Negative TWO SIERRA. You do not have permission to cross the green zone. Order your men to stay South of the green zone. Out."] call ADF_fnc_MessageParser;}; 
	if (_n == 3) exitWith {["ACO","ACO","Seriously TWO SIERRA. Once again, permission denied. Don't request again! Out."] call ADF_fnc_MessageParser;};
	if (_n > 3) exitWith {["2S","","FIRESTONE this is TWO SIERRA. Did you copy?"] call ADF_fnc_MessageParser;};
};

// End Mission
[] spawn {
	waitUntil {sleep 10; ADF_endMission};	
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Message. Over."] call ADF_fnc_MessageParser; sleep 7;
	["2S","","FIRESTONE this is TWO SIERRA. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. RTB for debrief. How Copy?"] call ADF_fnc_MessageParser; sleep 18;
	["2S","","FIRESTONE this is TWO SIERRA. Wilco. TWO SIERRA is OSCAR MIKE. Over."] call ADF_fnc_MessageParser; sleep 7;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Roger. Out."] call ADF_fnc_MessageParser; sleep 7;
};

ADF_msg_cache1 = {
	["2S","","FIRESTONE this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","FIRESTONE this is TWO SIERRA. We discovered an ammo cache at the Mosque in Feruz Abad city. Break. Interrogative tasking. How copy?"] call ADF_fnc_MessageParser; sleep 14;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Good copy. Wait. Over."] call ADF_fnc_MessageParser; sleep 32;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 9;
	["2S","","FIRESTONE this is TWO SIERRA. Send. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Tasking. Neutralize the ammo cache. How copy?"] call ADF_fnc_MessageParser; sleep 14;
	["2S","","FIRESTONE this is TWO SIERRA. Solid copy. Out."] call ADF_fnc_MessageParser;
};

ADF_msg_apc1 = {
	["2S","","FIRESTONE this is TWO SIERRA. Stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","FIRESTONE this is TWO SIERRA. We found two brand new APC's at the old base in Feruz Abad city. How copy?"] call ADF_fnc_MessageParser; sleep 14;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Solid copy. Do the APC's have any markings? Over."] call ADF_fnc_MessageParser; sleep 14;
	["2S","","Negative FIRESTONE. APC's are painted in the same colour scheme of JONAH vehicles in SATAN. Over."] call ADF_fnc_MessageParser; sleep 14;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Roger. Wait. Over."] call ADF_fnc_MessageParser; sleep 40;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 9;
	["2S","","FIRESTONE this is TWO SIERRA. Send. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA this is FIRESTONE. Tasking. MOTHER wants those vehicles destroyed. How copy?"] call ADF_fnc_MessageParser; sleep 14;
	["2S","","FIRESTONE this is TWO SIERRA. Wilco. Out."] call ADF_fnc_MessageParser;
};

ADF_msg_base1 = {
	["2S","","FIRESTONE this is TWO SIERRA. stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 7;
	["ACO","ACO","TWO SIERRA, this is FIRESTONE. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	["2S","","FIRESTONE, we found some sort of supply base at grid PAPPA VICTOR 0-2-5-1.0-5-0-2. How copy?"] call ADF_fnc_MessageParser; sleep 15;
	["ACO","ACO","TWO SIERRA, this is FIRESTONE. Good copy. Break. Search the premises for intel. Over."] call ADF_fnc_MessageParser; sleep 12;
	["2S","","FIRESTONE this is TWO SIERRA. Wilco. Out."] call ADF_fnc_MessageParser; sleep 50;
	["2S","","FIRESTONE this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO","ACO","TWO SIERRA, this is FIRESTONE. Send. Over."] call ADF_fnc_MessageParser; sleep 8;	
	["2S","","FIRESTONE this is TWO SIERRA. We found a laptop at the supply base at grid PAPPA VICTOR 0-2-5-1.0-5-0-2. How copy?"] call ADF_fnc_MessageParser; sleep 11;
	["ACO","ACO","TWO SIERRA, this is FIRESTONE. Secure laptop and bring to TOC. Over."] call ADF_fnc_MessageParser; sleep 11;
	["2S","","FIRESTONE this is TWO SIERRA. Roger. Out."] call ADF_fnc_MessageParser;
};

ADF_msg_endMission = {			
	sleep 25;
	["ACO","ACO","Capt. James O'Conner:. Welcome back TWO SIERRA<br/><br/>We are getting reports about Pashtun insurgents all over the Feruz Abad province. They must have a base of operations somewhere. MOTHER has already tasked TWO SIEERA with a mission for tomorrow.<br/><br/>Nice work today. Doris has hot coffee and chow waiting for you in the mess."] call ADF_fnc_MessageParser;
	sleep 20;
	_l = ["tLayer"] call BIS_fnc_rscLayer; 
	_l cutText ["", "BLACK", 20];
	["<img size= '10' shadow='false' image='Img\intro_TwoSierra.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 03 | Dolphin</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
	['END1',true,22] call BIS_fnc_endMission;
};