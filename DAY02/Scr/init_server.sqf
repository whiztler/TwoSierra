diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove
if (isServer) then {
	foggyBottom = [.30,0,0];	
	publicVariable "foggyBottom";
	0 setFog foggyBottom;
	forceWeatherChange;
	ADF_msg_tPrice = {};
	ADF_msg_tBaltimore = {};
};