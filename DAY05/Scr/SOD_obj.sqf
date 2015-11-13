// Init
private ["_tObjList","_vObj1atMary","_vObj2atMary"];
_tObjList 	= list tObj;
_vObj1atMary = false;
_vObj2atMary = false;

if (vObj1 in _tObjList) then {_vObj1atMary = true};
if (vObj2 in _tObjList) then {_vObj2atMary = true};

if (hasInterface) then {
	if (_vObj1atMary && _vObj2atMary) then {
		["2S","","FAIRCHILD this is TWO SIERRA at MARY. Both EVEREST1 and EVEREST2 delivered safely. How copy?"] call ADF_fnc_MessageParser;
	} else {
		if (_vObj1atMary) then {
			["2S","","FAIRCHILD this is TWO SIERRA at MARY. EVEREST1 delivered, EVEREST2 didn't make it. How copy?"] call ADF_fnc_MessageParser;
		} else {
			["2S","","FAIRCHILD this is TWO SIERRA at MARY. EVEREST2 delivered, EVEREST1 didn't make it. How copy?"] call ADF_fnc_MessageParser;
		};
	};
	sleep 12;
	
	ADF_endMission = true;
	
	["ACO","ACO","FAIRCHILD: Wait one."] call ADF_fnc_MessageParser;
	sleep 40 + (random 90);
	["ACO","ACO","FAIRCHILD: Good job TWO SIERRA. Return to FARGO asap. Out."] call ADF_fnc_MessageParser; 
};

ADF_endMissionMsg = {
	if !(hasInterface) exitWith {};
	sleep 10;	
	["ACO","ACO","FAIRCHILD: Good to see you back in once piece TWO SIERRA.<br/><br/>MARY is very grateful for the supplies. Hot meals waiting in the mess. You're heading back out tonight."] call ADF_fnc_MessageParser; 
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
diag_log	"-----------------------------------------------------";

// Counter Fireteams
for "_i" from 1 to 2 do {
	private ["_g","_maryPos","_rX","_rY","_spawnPos","_wp"];
	_maryPos		= getMarkerPos ADF_maryLoc;
	_rX			= 100 + (random 250);
	_rY			= 100 + (random 300);	
	_spawnPos	= [(_maryPos select 0) + _rX,(_maryPos select 1) + _rY,0];
	
	_g = [_spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;
	
	_wp = _g addWaypoint [_maryPos, 0];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointSpeed "FAST";
};

// Counter Vehicles
for "_i" from 1 to 2 do {
	private ["_g","_maryPos","_rX","_rY","_randomPos","_spawnPos","_wp"];
	_maryPos		= getMarkerPos ADF_maryLoc;
	_rX			= 800 + (random 200);
	_rY			= 600 + (random 300); 
	_randomPos	= [(_maryPos select 0) + _rX,(_maryPos select 1) + _rY,0];
	_spawnPos	= [_randomPos, 1, 150, 5, 0, 20, 0] call BIS_fnc_findSafePos;
	
	_g = [ _spawnPos, EAST, (configFile >> "CfgGroups" >> "EAST" >> "OPF_F" >> "Infantry" >> "OIA_InfTeam")] call BIS_fnc_spawnGroup;
	{[_x] call ADF_fnc_redressRebel} forEach units _g;
	
	_wp = _g addWaypoint [_maryPos, 0];
	_wp setWaypointType "SAD";
	_wp setWaypointBehaviour "COMBAT";
	_wp setWaypointSpeed "FAST";
};