if (isServer) then {diag_log	"-----------------------------------------------------"; diag_log "TWO SIERRA: Dolphin trigger activated"; diag_log	"-----------------------------------------------------";};
	
if (!hasInterface) exitWith {};
["2S","","TWO SIERRA: FIRESTONE, TWO SIERRA at DOLPHIN. Doesn't look good. Over."] call ADF_fnc_MessageParser; sleep 12;
["ACO","ACO","FIRESTONE: Copy TWO SIERRA. Neutralize DOLPHIN and proceed with the mission objective. out."] call ADF_fnc_MessageParser;
