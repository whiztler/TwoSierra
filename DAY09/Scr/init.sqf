private ["_diagTestStart","_diagTestEnd"];
_diagTestStart = diag_tickTime;
diag_log "ADF RPT: Init - executing Scr\init.sqf"; // Reporting. Do NOT edit/remove

// PreComp
call compile preprocessFileLineNumbers "Scr\ADF_messageParser.sqf";

// Vars init
ADF_msg_endMission	= {diag_log "-----------------------------------------------------";diag_log "TWO SIERRA: End Mission activated";diag_log	"-----------------------------------------------------";};
ADF_msg_corazolBlue	= {diag_log "-----------------------------------------------------";diag_log "TWO SIERRA: Objective CORAZOL completed";diag_log "-----------------------------------------------------";};
ADF_msg_calvinBlue	= {diag_log "-----------------------------------------------------";diag_log "TWO SIERRA: Objective CALVIN completed";diag_log "-----------------------------------------------------";};
ADF_msg_foxtrotBlue	= {diag_log "-----------------------------------------------------";diag_log "TWO SIERRA: Objective FOXTROT completed";diag_log "-----------------------------------------------------";};
ADF_msg_foxtrotBase	= {diag_log "-----------------------------------------------------";diag_log "TWO SIERRA: message FOXTROT base";diag_log "-----------------------------------------------------";};
ADF_msg_foxtrotAmmo	= {diag_log "-----------------------------------------------------";diag_log "TWO SIERRA: message FOXTROT ammo cache";diag_log "-----------------------------------------------------";};
ADF_msg_golfBlue		= {diag_log "-----------------------------------------------------";diag_log "TWO SIERRA: Objective GOLF completed";diag_log "-----------------------------------------------------";};
ADF_msg_golfFuel		= {diag_log "-----------------------------------------------------";diag_log "TWO SIERRA: message GOLF fuel";diag_log "-----------------------------------------------------";};
ADF_msg_hotelBlue		= {diag_log "-----------------------------------------------------";diag_log "TWO SIERRA: Objective HOTEL completed";diag_log "-----------------------------------------------------";};
ADF_msg_DeltaBlue		= {diag_log "-----------------------------------------------------";diag_log "TWO SIERRA: Objective DELTA completed";diag_log "-----------------------------------------------------";};
ADF_msg_EchoBlue		= {diag_log "-----------------------------------------------------";diag_log "TWO SIERRA: Objective ECHO completed";diag_log "-----------------------------------------------------";};
ADF_msg_RomeoBlue		= {diag_log "-----------------------------------------------------";diag_log "TWO SIERRA: Objective ROMEO completed";diag_log "-----------------------------------------------------";};

ADF_obj_corazol		= false;
ADF_obj_calvin		= false;
ADF_obj_foxtrot		= false;
ADF_obj_golf			= false;
ADF_obj_hotel			= false;
ADF_obj_Delta			= false;
ADF_obj_Echo			= false;
ADF_obj_Romeo			= false;

// Server Init
if (isServer) then {
	//#include "init_server.sqf"
};

// Client init
if (hasInterface) then {
	//#include "init_client.sqf"
};

// HC init
if (ADF_isHC) then {
	#include "init_hc.sqf"
};

// All clients
//execVM "Scr\ADF_CAS.sqf";

_diagTestEnd = diag_tickTime;
diag_log format ["ADF RPT: Init - FINISHED Scr\init.sqf  [%1]",_diagTestStart - _diagTestEnd];