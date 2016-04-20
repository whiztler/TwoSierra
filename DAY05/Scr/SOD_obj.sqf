// Init
private ["_tObjList", "_vObj1atMary", "_vObj2atMary"];
_tObjList 	= list tObj;
_vObj1atMary = false;
_vObj2atMary = false;

if (vObj1 in _tObjList) then {_vObj1atMary = true};
if (vObj2 in _tObjList) then {_vObj2atMary = true};

if (_vObj1atMary && alive vObj2) then {_vObj2atMary = true};
if (_vObj2atMary && alive vObj1) then {_vObj1atMary = true};

if (hasInterface) then {
	if (_vObj1atMary && _vObj2atMary) then {
		["2S", "", "TWO SIERRA: FAIRCHILD this is TWO SIERRA. Message. Over."] call ADF_fnc_MessageParser; sleep 6;
		["ACO", "ACO", "FAIRCHILD: This is FAIRCHILD. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 8;
		["2S", "", "FAIRCHILD this is TWO SIERRA at MARY. Both EVEREST1 and EVEREST2 delivered safely. How copy?"] call ADF_fnc_MessageParser;
	} else {
		if (_vObj1atMary) then {
			["2S", "", "FAIRCHILD this is TWO SIERRA at MARY. EVEREST1 delivered, EVEREST2 didn't make it. How copy?"] call ADF_fnc_MessageParser;
		} else {
			["2S", "", "FAIRCHILD this is TWO SIERRA at MARY. EVEREST2 delivered, EVEREST1 didn't make it. How copy?"] call ADF_fnc_MessageParser;
		};
	};
	sleep 12;
	
	ADF_endMission = true;
	
	["ACO", "ACO", "FAIRCHILD: Solid Copy TWO SIERRA. Wait one. Out."] call ADF_fnc_MessageParser;
	sleep 40 + (random 90);
	["ACO", "ACO", "FAIRCHILD: TWO SIERRA this is FAIRCHILD. Message. Over."] call ADF_fnc_MessageParser; sleep 7;
	["2S", "", "TWO SIERRA: FAIRCHILD this is TWO SIERRA. Send traffic. Over."] call ADF_fnc_MessageParser; sleep 8;
	["ACO", "ACO", "FAIRCHILD: TWO SIERRA, return to FARGO. Over."] call ADF_fnc_MessageParser; sleep 12;
	["2S", "", "TWO SIERRA: Solid Copy FAIRCHILD. TWO SIERRA is OSCAR MIKE. Out."] call ADF_fnc_MessageParser; sleep 8;
};

ADF_endMissionMsg = {
	if !(hasInterface) exitWith {};
	sleep 10;	
	["ACO", "ACO", "FAIRCHILD: Good to see you back in one piece TWO SIERRA.<br/><br/>MARY is very grateful for the supplies. Hot meals waiting in the mess. You're heading back out tonight."] call ADF_fnc_MessageParser; 
	sleep 20;

	_l = ["tLayer"] call BIS_fnc_rscLayer; 
	_l cutText ["", "BLACK", 20];
	["<img size= '10' shadow='false' image='Img\intro_TwoSierra.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 05 | Saint Mary</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
	['END1',true,22] call BIS_fnc_endMission;
};

if (!isServer) exitWith {};
{_x allowDamage false} forEach [vObj1,vObj2];

ADF_endMission = true;

diag_log	"-----------------------------------------------------";
diag_log "TWO SIERRA: EndMission process started.";
diag_log "TWO SIERRA: Spawning counter teams.";
diag_log	"-----------------------------------------------------";

// Counter Fireteams
for "_i" from 1 to 2 do {
	private ["_g", "_m", "_rX", "_rY", "_p", "_wp", "_t"];
	_m	= getMarkerPos ADF_maryLoc;
	_rX	= 150 + (random 150);
	_rY	= 150 + (random 300);	
	_p	= [[(_m select 0) + _rX, (_m select 1) + _rY, 0], 1, 150, 5, 0, 20, 0] call BIS_fnc_findSafePos;
	_t 	= ["OIA_InfTeam", "OIA_InfSquad"] call BIS_fnc_selectRandom;
	
	_g = [_p, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> _t)] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;
	
	_g allowFleeing 0;
	_wp = _g addWaypoint [_m, 0];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "FAST";
};

// Counter far
for "_i" from 1 to 2 do {
	private ["_g", "_m", "_rX", "_rY", "_p", "_wp"];
	_m	= getMarkerPos ADF_maryLoc;
	_rX	= 800 + (random 200);
	_rY	= 600 + (random 300); 
	_p	= [[(_m select 0) + _rX,(_m select 1) + _rY,0], 1, 150, 5, 0, 20, 0] call BIS_fnc_findSafePos;
	
	_g = [ _p, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;
	
	_g allowFleeing 0;
	_wp = _g addWaypoint [_m, 0];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "FAST";
};