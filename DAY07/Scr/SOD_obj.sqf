params ["_f"];

if (ADF_isHC) exitWith {};

if (_f == 1) then {	
	Obj_1 = true;
	
	if (isServer) then {
		oFlag_1 setFlagTexture "Img\flag_NRF.paa";
		publicVariable "Obj_1"; // JIP queue
		diag_log	"----------------------------------------------------------------------";
		diag_log "TWO SIERRA: Obj 1 (Flag DIANA) completed";
		diag_log	"----------------------------------------------------------------------";
	};

	if (hasInterface) then {		
		if (Obj_2) then {
			["2S","","FAIRCHILD this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 6;
			["ACO","ACO","TWO SIERRA this is FAIRCHILD. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 8;		
			["2S","","FAIRCHILD this is TWO SIERRA. We secured DIANA. Both NOLA and DIANA are blue. How copy"] call ADF_fnc_MessageParser; sleep 14;
			["ACO","ACO","TWO SIERRA this is FAIRCHILD. Solid copy. Break.<br/><br/>2SPG and 4Th will RV at your current position. Break. Set up security and get the mess in working order. Break.<br/><br/>MOTHER wants you to remain at NOLA. ACE is detecting a lot of movement at Lopatino. Break.<br/><br/>Get some chow and some rest. MOTHER suggests you get back into action soon..."] call ADF_fnc_MessageParser; sleep 20;
			["2S","","FAIRCHILD this is TWO SIERRA. Roger. Out."] call ADF_fnc_MessageParser;
			sleep 20;
			_l = ["tLayer"] call BIS_fnc_rscLayer; 
			_l cutText ["", "BLACK", 20];
			["<img size= '10' shadow='false' image='Img\intro_TwoSierra.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 07 | Nola</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
			['END1',true,22] call BIS_fnc_endMission;	
		} else {
			["2S","","FAIRCHILD this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 6;
			["ACO","ACO","TWO SIERRA this is FAIRCHILD. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 8;		
			["2S","","FAIRCHILD this is TWO SIERRA. DIANA is blue. How copy"] call ADF_fnc_MessageParser; sleep 11;
			["ACO","ACO","TWO SIERRA this is FAIRCHILD. Good copy. Break. Push on to NOLA. Over."] call ADF_fnc_MessageParser; sleep 7;
			["2S","","FAIRCHILD this is TWO SIERRA. Wilco. Out."] call ADF_fnc_MessageParser;
		};		
	};
};

if (_f == 2) then {	
	Obj_2 = true;
	
	if (isServer) then {
		oFlag_2 setFlagTexture "Img\flag_NRF.paa";
		publicVariable "Obj_2"; // JIP queue
		diag_log	"----------------------------------------------------------------------";
		diag_log "TWO SIERRA: Obj 2 (Flag NOLA) completed";
		diag_log	"----------------------------------------------------------------------";
	};

	if (hasInterface) then {		
		if (Obj_1) then {
			["2S","","FAIRCHILD this is TWO SIERRA. stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 6;
			["ACO", "ACO","TWO SIERRA this is FAIRCHILD. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
			["ACO","ACO","TWO SIERRA this is FAIRCHILD. Solid copy. Break.<br/><br/>2SPG and 4Th will RV at your current position. Break. Set up security and get the mess in working order. Break.<br/><br/>MOTHER wants you to remain at NOLA. ACE is detecting a lot of movement at Lopatino. Break.<br/><br/>Get some chow and some rest. MOTHER suggests you get back into action soon..."] call ADF_fnc_MessageParser; sleep 20;
			["2S","","FAIRCHILD this is TWO SIERRA. Roger. Out."] call ADF_fnc_MessageParser;
			sleep 20;
			_l = ["tLayer"] call BIS_fnc_rscLayer; 
			_l cutText ["", "BLACK", 20];
			["<img size= '10' shadow='false' image='Img\intro_TwoSierra.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 07 | Nola</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
			['END1',true,22] call BIS_fnc_endMission;	
		} else {
			["2S","","FAIRCHILD this is TWO SIERRA. stand-by for traffic. Over."] call ADF_fnc_MessageParser; sleep 6;
			["ACO", "ACO","TWO SIERRA this is FAIRCHILD. Send. Over."] call ADF_fnc_MessageParser; sleep 8;		
			["2S","","FAIRCHILD this is TWO SIERRA. NOLA is blue. How copy"] call ADF_fnc_MessageParser; sleep 14;
			["ACO","ACO","TWO SIERRA this is FAIRCHILD. Good copy. Break. Push on to DIANA. Over."] call ADF_fnc_MessageParser; sleep 7;
			["2S","","FAIRCHILD this is TWO SIERRA. Wilco. Out."] call ADF_fnc_MessageParser;
		};		
	};
};
