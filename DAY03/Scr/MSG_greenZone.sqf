ADF_greenCnt = ADF_greenCnt + 1;

if (ADF_greenCnt < 4) then {publicVariable "ADF_greenCnt";};

["2S","","FIRESTONE this is TWO SIERRA, requesting permission to cross green zone. How copy?"] call ADF_fnc_MessageParser; sleep 15;

if (ADF_greenCnt == 1) exitWith {["ACO","ACO","FIRESTONE: Negative TWO SIERRA. Permission denied. Out."] call ADF_fnc_MessageParser;};
if (ADF_greenCnt == 2) exitWith {["ACO","ACO","FIRESTONE: Negative TWO SIERRA. You do not have permission to cross the green zone. Please order your men to stay South of the green zone. Out."] call ADF_fnc_MessageParser;}; 
if (ADF_greenCnt == 3) exitWith {["ACO","ACO","FIRESTONE: Seriously TWO SIERRA. Once again, permission denied. Don't request again! Out."] call ADF_fnc_MessageParser;};
if (ADF_greenCnt > 3) exitWith {["2S","","FIRESTONE this is TWO SIERRA. Do you read?"] call ADF_fnc_MessageParser;};