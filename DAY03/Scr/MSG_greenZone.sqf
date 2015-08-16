ADF_greenCnt = ADF_greenCnt + 1;
if (ADF_greenCnt < 4) then {publicVariable "ADF_greenCnt";};

if (ADF_greenCnt == 1) exitWith {
	hintSilent parseText "<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE this is TWO SIERRA, requesting permission to cross green zone. How copy?</t><br/><br/>";
	sleep 15;
	hintSilent parseText "<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: Negative TWO SIERRA. Permission denied. Out.</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: Negative TWO SIERRA. Permission denied. Out.</font><br/><br/>"]];
};

if (ADF_greenCnt == 2) exitWith {
	hintSilent parseText "<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE this is TWO SIERRA, requesting permission to cross green zone. How copy?</t><br/><br/>";
	sleep 15;
	hintSilent parseText "<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: Negative TWO SIERRA. You do not have permission to cross the green zone. Please order your men to stay South of the green zone. Out.</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: Negative TWO SIERRA. You do not have permission to cross the green zone. Please order your men to stay South of the green zone. Out.</font><br/><br/>"]];
}; 

if (ADF_greenCnt == 3) exitWith {
	hintSilent parseText "<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE this is TWO SIERRA, requesting permission to cross green zone. How copy?</t><br/><br/>";
	sleep 15;
	hintSilent parseText "<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: Seriously TWO SIERRA. Once again, permission denied. Don't request again! Out.</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: Seriously TWO SIERRA. Once again, permission denied. Don't request again! Out.</font><br/><br/>"]];
};

if (ADF_greenCnt > 3) exitWith {
	hintSilent parseText "<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE this is TWO SIERRA, requesting permission to cross green zone. How copy?</t><br/><br/>";
	sleep 9;
	hintSilent parseText "<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE this is TWO SIERRA. Do you read?</t><br/><br/>";
};