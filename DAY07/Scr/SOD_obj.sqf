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
			["2S","","FAIRCHILD this is TWO SIERRA. DIANA is Ours. Both NOLA and DIANA are blue. How copy"] call ADF_fnc_MessageParser; sleep 14;
			["ACO","ACO","FAIRCHILD: Excellent TWO SIERRA<br/><br/>22 Support and 4Th are heading your way. Set up security and get the mess in working order.<br/><br/>It looks like MOTHER wants you to stay at NOLA. ACE is detecting a lot of movement at Lopatino. BORIS is up to something.<br/><br/>Get some chow and some rest. MOTHER suggests you get back into action soon..."] call ADF_fnc_MessageParser; sleep 12;
			sleep 20;
			_l = ["tLayer"] call BIS_fnc_rscLayer; 
			_l cutText ["", "BLACK", 20];
			["<img size= '10' shadow='false' image='Img\intro_TwoSierra.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 07 | Nola</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
			['END1',true,22] call BIS_fnc_endMission;	
		} else {
			["2S","","FAIRCHILD this is TWO SIERRA. DIANA is blue. How copy"] call ADF_fnc_MessageParser; sleep 14;
			["ACO","ACO","FAIRCHILD: Copy TWO SIERRA. Excellent work. MOTHER will be pleased to see our flag on top of that hill.<br/><br/>Push on to NOLA. Out."] call ADF_fnc_MessageParser;
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
			["2S","","FAIRCHILD this is TWO SIERRA. NOLA is Ours. Both NOLA and DIANA are blue. How copy"] call ADF_fnc_MessageParser; sleep 14;
			["ACO","ACO","FAIRCHILD: Excellent TWO SIERRA<br/><br/>22 Support and 4Th are heading your way. Set up security and get the mess in working order.<br/><br/>It looks like MOTHER wants you to stay at NOLA. ACE is detecting a lot of movement at Lopatino. BORIS is up to something.<br/><br/>Get some chow and some rest. MOTHER suggests you get back into action soon..."] call ADF_fnc_MessageParser; sleep 12;
			sleep 20;
			_l = ["tLayer"] call BIS_fnc_rscLayer; 
			_l cutText ["", "BLACK", 20];
			["<img size= '10' shadow='false' image='Img\intro_TwoSierra.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 07 | Nola</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
			['END1',true,22] call BIS_fnc_endMission;	
		} else {
			["2S","","FAIRCHILD this is TWO SIERRA. NOLA is blue. How copy"] call ADF_fnc_MessageParser; sleep 14;
			["ACO","ACO","FAIRCHILD: Copy TWO SIERRA. Excellent work. MOTHER will be pleased to see our flag on top of the airport.<br/><br/>Time to take that hill. Push on to DIANA. Out."] call ADF_fnc_MessageParser;
		};		
	};
};
