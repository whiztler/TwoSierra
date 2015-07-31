if (hasInterface) then {
	hintSilent parseText"<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>TWO SIERRA: FIRESTONE this is TWO SIERRA at Xray, over.<br/><br/></t>";
	sleep 10;
	hintSilent parseText"<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: Copy that TWO SIERRA. We have you on SatNav. Proceed with the objective. Out.<br/><br/></t>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: Copy that TWO SIERRA. We have you on SatNav. Proceed with the objective. Out</font><br/><br/>"]];

	waitUntil {sleep 3; !alive vXray};

	if (BearclawRescued) then {
		hint parseText"<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: Great fireworks TWO SIERRA. Escort BEARCLAW back to RV ZEBRA.<br/><br/></t>";
		_logTime = [dayTime] call BIS_fnc_timeToString;
		_logTimeText = "Log: " + _logTime;
		player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: Great fireworks TWO SIERRA. Escort BEARCLAW back to RV ZEBRA.</font><br/><br/>"]];	
	} else {
		hint parseText"<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: Good job TWO SIERRA. Next objective: BEARCLAW<br/><br/></t><t color='#6C7169' align='left'>Your next objective is to neutralize XRAY.<br/><br/></t>";
		_logTime = [dayTime] call BIS_fnc_timeToString;
		_logTimeText = "Log: " + _logTime;
		player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: Good job TWO SIERRA. Next objective: BEARCLAW</font><br/><br/>"]];	
	};
};

