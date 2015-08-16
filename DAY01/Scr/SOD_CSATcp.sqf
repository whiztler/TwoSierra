if (hasInterface) then {
	hintSilent parseText"<img size= '7' shadow='false' image='Img\CSAT_logo.paa'/><br/><br/><t color='#e36b6b' size='1.5'>STOP!</t><br/><br/><t color='#6C7169' align='left'>Corporal Derafsh: wait here infidel.</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: Corporal Derafsh</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>STOP! Wait here infidel.</font><br/><br/>"]];

	sleep 10;

	hintSilent parseText"<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>TWO SIERRA: FIRESTONE this is TWO SIERRA at Checkpoint 3. We've been ordered to halt, over.<br/><br/></t>";	

	sleep 10;

	hintSilent parseText"<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: Copy that TWO SIERRA. Sit tight. Order your men to hold it together. Let's see what they want.<br/><br/></t>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: Copy that TWO SIERRA. Sit tight. Order your men to hold it together. Let's see what they want.</font><br/><br/>"]];

	sleep 10;

	hintSilent parseText"<img size= '7' shadow='false' image='Img\CSAT_logo.paa'/><br/><br/><t color='#6C7169' align='left'>Corporal Derafsh: Infidel, where ar yu papers?</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: Corporal Derafsh</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>Corporal Derafsh: Infidel, where ar yu papers?</font><br/><br/>"]];

	sleep 10;

	hintSilent parseText"<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>TWO SIERRA: FIRESTONE this is TWO SIERRA. They are asking if we have papers.<br/><br/></t>";

	sleep 5;

	hintSilent parseText"<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: Tell them to contact Colonel Mahshid. He will clear your passage.<br/><br/></t>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: Tell them to contact Colonel Mahshid. He will clear your passage.</font><br/><br/>"]];

	sleep 10;

	hintSilent parseText"<img size= '7' shadow='false' image='Img\CSAT_logo.paa'/><br/><br/><t color='#6C7169' align='left'>Corporal Derafsh: Yu do not give order too me infidel. Dis is not Amerika.</t><br/><br/><t color='#6C7169' align='left'>Wate heer!</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: Corporal Derafsh</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>Corporal Derafsh: Yu do not give order too me infidel. Dis is not Amerika.<br/><br/>Wate heer!</font><br/><br/>"]];

	sleep 70;

	hintSilent parseText"<img size= '7' shadow='false' image='Img\CSAT_logo.paa'/><br/><br/><t color='#6C7169' align='left'>Corporal Derafsh: Yu can go.</t><br/><br/><t color='#6C7169' align='left'>Go now!</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: Corporal Derafsh</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>Corporal Derafsh: Yu can go.<br/><br/>Go now!</font><br/><br/>"]];

	sleep 10;

	hintSilent parseText"<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>TWO SIERRA: FIRESTONE this is TWO SIERRA. We are OSCAR MIKE, out.<br/><br/></t>";
}; 
