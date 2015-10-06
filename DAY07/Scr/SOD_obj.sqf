params ["_f"];

if (ADF_isHC) exitWith {};

ADF_fnc_endMission = {
	ADF_endMission = true; 
	if (isServer) then {
		publicVariable "ADF_endMission"; // JIP queue
		diag_log	"----------------------------------------------------------------------";
		diag_log "TWO SIERRA: End Mission process started";
		diag_log	"----------------------------------------------------------------------";
		waitUntil {sleep 5; triggerActivated tEndMission};
		diag_log	"----------------------------------------------------------------------";
		diag_log "TWO SIERRA: End Mission - FOB KEARNEY";
		diag_log	"----------------------------------------------------------------------";		
	};
	
	if (hasInterface) then {
		waitUntil {sleep 5; triggerActivated tEndMission};
		["ACO","ACO","FAIRCHILD: Splendid achievement TWO SIERRA.<br/><br/>MOTHER is giving you a few days R&R. I suggest you use the time also to get your equipment in order. Your next operation will be a tough nut to crack.<br/><br/>Plenty of cold ones in the mess tent. I'll see you in two days."] call ADF_fnc_MessageParser;
		sleep 20;

		_l = ["tLayer"] call BIS_fnc_rscLayer; 
		_l cutText ["", "BLACK", 20];
		["<img size= '10' shadow='false' image='Img\intro_TwoSierra.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 07 | Nola</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
		['END1',true,22] call BIS_fnc_endMission;		
	};
};

if (_f == 1) then {	
	Obj_1 = true;
	
	if (isServer) then {
		oFlag_1 setFlagTexture "Img\flag_NRF.paa";
		publicVariable "Obj_1"; // JIP queue
		diag_log	"----------------------------------------------------------------------";
		diag_log "TWO SIERRA: Obj 1 (Flag DIANA) completed";
		diag_log	"----------------------------------------------------------------------";
		if (Obj_1 && Obj_2) exitWith {[] spawn ADF_fnc_endMission;};
	};

	if (hasInterface) then {		
		if (Obj_2) then {
			["2S","","FAIRCHILD this is TWO SIERRA. DIANA is Ours. Both SATURN and DIANA are blue. How copy"] call ADF_fnc_MessageParser; sleep 14;
			["ACO","ACO","FAIRCHILD: Copy TWO SIERRA. ACE is detecting a lot of movement at Lopatino. MOTHER wants you RTB asap before we start a war with BORIS. How copy?"] call ADF_fnc_MessageParser; sleep 12;
			["2S","","Copy FDAIRCHILD. TWO SIERRA heading home. Out"] call ADF_fnc_MessageParser;
			[] spawn ADF_fnc_endMission;
		} else {
			["2S","","FAIRCHILD this is TWO SIERRA. DIANA is blue. How copy"] call ADF_fnc_MessageParser; sleep 14;
			["ACO","ACO","FAIRCHILD: Copy TWO SIERRA. Excellent work. MOTHER will be pleased to see our flag on top of that hill.<br/><br/>Push on to SATURN. Out."] call ADF_fnc_MessageParser;
		};		
	};
};

if (_f == 2) then {	
	Obj_2 = true;
	
	if (isServer) then {
		oFlag_2 setFlagTexture "Img\flag_NRF.paa";
		publicVariable "Obj_2"; // JIP queue
		diag_log	"----------------------------------------------------------------------";
		diag_log "TWO SIERRA: Obj 2 (Flag SATURN) completed";
		diag_log	"----------------------------------------------------------------------";
		if (Obj_1 && Obj_2) exitWith {[] call ADF_fnc_endMission;};
	};

	if (hasInterface) then {		
		if (Obj_1) then {
			["2S","","FAIRCHILD this is TWO SIERRA. SATURN is Ours. Both SATURN and DIANA are blue. How copy"] call ADF_fnc_MessageParser; sleep 14;
			["ACO","ACO","FAIRCHILD: Copy TWO SIERRA. ACE is detecting a lot of movement at Lopatino. MOTHER wants you RTB asap before we start a war with BORIS. How copy?"] call ADF_fnc_MessageParser; sleep 12;
			["2S","","Copy FDAIRCHILD. TWO SIERRA heading home. Out"] call ADF_fnc_MessageParser;
			[] spawn ADF_fnc_endMission;
		} else {
			["2S","","FAIRCHILD this is TWO SIERRA. SATURN is blue. How copy"] call ADF_fnc_MessageParser; sleep 14;
			["ACO","ACO","FAIRCHILD: Copy TWO SIERRA. Excellent work. MOTHER will be pleased to see our flag on top of the airport.<br/><br/>Time to take that hill. Push on to DIANA. Out."] call ADF_fnc_MessageParser;
		};		
	};
};
