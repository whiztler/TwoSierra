if (hasInterface) then {
	private ["_msg", "_p"];
	["2S", "", "TWO SIERRA: FIRESTONE this is TWO SIERRA. Stand by for traffic. Over."] call ADF_fnc_MessageParser; sleep 6;
	["ACO", "ACO", "FIRESTONE: TWO SIERRA, this is FIRESTONE. Send. Over."] call ADF_fnc_MessageParser; sleep 8;
	_p = getMarkerPos ADF_bopLoc;
	_msg = format ["FIRESTONE, this is TWO SIERRA. AKIRA located at grid PAPPA VICTOR %1.%2. How copy?", round (_p select 0), round (_p select 1)];
	["2S", "",_msg] call ADF_fnc_MessageParser; sleep 12;
	["ACO", "ACO", "FIRESTONE: Solid copy TWO SIERRA. Neutralize AKIRA. No prisoners. Out."] call ADF_fnc_MessageParser;
};

if (isServer) then {
	diag_log	"-----------------------------------------------------";
	diag_log "TWO SIERRA: BOP reinforce trigger activated";
	diag_log	"-----------------------------------------------------";

	// Init
	private ["_c", "_wp", "_v", "_t"];
	
	// enable the vehicles
	{_x hideObject false; _x enableSimulationGlobal true;} forEach [vOpforAPC_1, vOpforAPC_2, vOpforAPC_3];
	
	// Crew the vehicles and give them orders
	for "_i" from 1 to 3 do {
		_t = format ["vOpforAPC_%1",_i];
		_v = call compile format ["%1",_t];	
		_wpPos = getPos tBOPdetect;
		
		_c = createGroup independent; 
		_p = _c createUnit ["I_Crew_F", getMarkerPos "reEnfor", [], 0, "LIEUTENANT"]; _p moveInCommander _v;
		_p = _c createUnit ["I_Crew_F", getMarkerPos "reEnfor", [], 0, "SERGEANT"]; _p moveInGunner _v;
		_p = _c createUnit ["I_Crew_F", getMarkerPos "reEnfor", [], 0, "CORPORAL"]; _p moveInDriver _v;
		{[_x] call ADF_fnc_redressPashtun} forEach units _c;

		[_c, _wpPos, 300, 2, "SAD", "SAFE", "RED", "LIMITED", 25] call ADF_fnc_vehiclePatrol;
	};
};