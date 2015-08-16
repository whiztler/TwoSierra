// Vars init
ADF_pashtunWaveClear 		= false;
ADF_pashtunAOtriggered	= false;
ADF_SatanClearUp			= false;
ADF_SatanControl			= false;
ADF_redZoneOpforCnt		= 0;

// Server Init
if (isServer) then {
	#include "init_server.sqf"
};

// Client init
if (hasInterface) then {
	#include "init_client.sqf"
};

// All Clients
execVM "Scr\ADF_CAS.sqf";

// Server/HC
if (!ADF_HC_execute) exitWith {}; // HC Autodetect. If no HC present execute on the Server.

#include "init_AO.sqf" // Server/HC
