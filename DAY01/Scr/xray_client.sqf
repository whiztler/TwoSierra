if (hasInterface) then {
	["2S","TWO SIERRA","TWO SIERRA: FIRESTONE this is TWO SIERRA at Xray, Over."] call ADF_fnc_MessageParser; sleep 15;
	["ACO","ACO","FIRESTONE: Copy that TWO SIERRA. We have you on SatNav. Proceed with the objective. Out."] call ADF_fnc_MessageParser;

	waitUntil {sleep 3; xRayDestroyed};
	
	["2S","TWO SIERRA","TWO SIERRA: FIRESTONE this is TWO SIERRA. XRAY neutralized. How copy?"] call ADF_fnc_MessageParser; sleep 12;
	if (BearclawRescued) then {
		["ACO","ACO","FIRESTONE: Great fireworks TWO SIERRA. Escort BEARCLAW back to RV ZEBRA. Out."] call ADF_fnc_MessageParser;
	} else {
		["ACO","ACO","FIRESTONE: Good job TWO SIERRA. Your next objective is to locate and secure BEARCLAW. Out."] call ADF_fnc_MessageParser;
	};
};

