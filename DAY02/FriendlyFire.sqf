tlq_killTicker = { 

	_this addMPEventHandler ['MPKilled',{

		_unit = _this select 0;
		_killer = _this select 1;

		_newKill = [_unit,_killer];

		if (count tlq_killArray > 100) then {tlq_killArray = []};

		tlq_killArray set [count tlq_killArray,_newKill call tlq_parseKill];

		[] spawn tlq_killList;
		if (player == _killer) then {_newKill spawn tlq_killPopUp};


	}
	];
	
};



tlq_parseKill = {
	
	_line = "";
	_killerName = "";
	_victimName = "";
	_killerString = "";
	_victimString = "";
	_killerColor = "#99D5FF";
	_victimColor = "#99D5FF";


	_victim = _this select 0;
	_killer = _this select 1;

	if (!(isplayer _killer)) then {
		_killerName = getText (configFile >> "CfgVehicles" >> format["%1",typeOf _killer] >> "Displayname");
		if(vehicle _killer != _killer) then {_killerName = getText (configFile >> "CfgVehicles" >> format["%1 crew",typeof vehicle _killer] >> "Displayname")};
		}else{_killerName = name _killer};

	if (!(isplayer _victim)) then {
		_victimName = getText (configFile >> "CfgVehicles" >> format["%1",typeOf _victim] >> "Displayname");
		if(vehicle _victim != _victim) then {_victimName = getText (configFile >> "CfgVehicles" >> format["%1 crew",typeof vehicle _victim] >> "Displayname")};
		}else{_victimName = name _victim};

	if ((_killer==player) or (_killer == vehicle player)) then
		{
		_killerColor = "#ffff00"; //yellow
		}
		else
		{
		_killerColor = side group _killer call BIS_fnc_sideColor;

			_r = _killerColor select 0;
			_g = _killerColor select 1;
			_b = _killerColor select 2;

		_killerColor = [_r+0.1,_g+0.1,_b+0.1];

		_killerColor = _killerColor call BIS_fnc_colorRGBtoHTML;

		};

	if (_victim==player) then
		{
		_victimColor = "#ffff00"; //yellow
		}
		else
		{
		_victimColor = side group _victim call BIS_fnc_sideColor;

			_r = _victimColor select 0;
			_g = _victimColor select 1;
			_b = _victimColor select 2;

		_victimColor = [_r+0.1,_g+0.1,_b+0.1];
		
		_victimColor = _victimColor call BIS_fnc_colorRGBtoHTML;
		
		};

	_killerString = format["<t color='%1'>%2</t>",_killerColor ,_killerName];
	_victimString = format["<t color='%1'>%2</t>",_victimColor,_victimName];

	//the line which shows the final formatted kill
	_line = switch(true) do {
		case(_killer == _victim): {format ["%1 killed themselves",_killerString]};
		case(isNull _killer): {format ["Bad luck for %1",_victimString]};
		default {format ["%1 killed %2",_killerString,_victimString]};
	};

	_line;
	
};


tlq_killPopUp = {

	_victim = _this select 0;
	_killer = _this select 1;


	_victimName = "";	
	_victimString = "";
	_victimColor = "#99D5FF";


	if (!(isplayer _victim)) then {
		_victimName = getText (configFile >> "CfgVehicles" >> format["%1",typeOf _victim] >> "Displayname");
	if(vehicle _victim != _victim) then {_victimName = getText (configFile >> "CfgVehicles" >> format["%1 crew",typeof vehicle _victim] >> "Displayname")};
		}else{_victimName = name _victim};

	_victimColor = (side group _victim call BIS_fnc_sideColor) call BIS_fnc_colorRGBtoHTML;

	_victimString = format["<t color='%1'>%2</t>",_victimColor,_victimName];

	_line = if ((_killer == player) and (_victim == player)) then {
		"<t size='0.5'>You killed yourself</t>";
	} else {
		format ["<t size='0.5'>You killed %1</t>",_victimString];
	};	

 	[_line,0,0.8,2,0,0,7017] spawn bis_fnc_dynamicText;

};



tlq_killList = {
	

	//flush kills and  show most recent
	if (time - tlq_killTime > 37) then {
		tlq_displayedKills = [];
	};


	tlq_displayedKills set [count tlq_displayedKills, tlq_killArray select (count tlq_killArray - 1)];



	_tickerText = "";


	_c = 0;
	for "_i" from (count tlq_displayedKills) to 0 step -1 do{

		_c = _c + 1;
	
		_tickerText = format ["%1<br />%2",tlq_displayedKills select _i,_tickerText];

		if (_c > 8) exitWith{};

	};

	hintsilent parsetext _tickerText;

	//["<t size='0.4' align='right'>" + _tickerText + "</t>",safeZoneX,safeZoneY,10,0,0,7016] call bis_fnc_dynamicText;


	tlq_killTime = time;

};



//declare global variables

tlq_killArray = [];
tlq_displayedKills = [];
tlq_killTime = 0;

//start kill registration for player
if (!isNull player) then {
	player spawn tlq_killTicker;
};

if (isServer) then {
	//ai
	{
		if (!(isPlayer _x)) then {
			_x spawn tlq_killTicker};
	} forEach allUnits;
};