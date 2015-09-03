diag_log "ADF RPT: Init - executing init_server.sqf"; // Reporting. Do NOT edit/remove
if (isServer) then {
	execVM "Scr\bearclaw_server.sqf";
	execVM "Scr\xray_server.sqf";	
};