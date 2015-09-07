if (hasInterface) then {
	hintSilent parseText"<img size= '7' shadow='false' image='Img\logo_CSAT.paa'/><br/><br/><t color='#e36b6b' size='1.5'>STOP!</t><br/><br/><t color='#6C7169' align='left'>Corporal Derafsh: wait here infidel.</t><br/><br/>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: Corporal Derafsh</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>STOP! Wait here infidel.</font><br/><br/>"]];

	sleep 10;

	["2S","TWO SIERRA","TWO SIERRA: FIRESTONE this is TWO SIERRA at Checkpoint 3. We've been ordered to halt, over."] call ADF_fnc_MessageParser; sleep 9;
	["ACO","ACO","FIRESTONE: Copy that TWO SIERRA. Sit tight. Order your men to hold it together. Let's see what they want."] call ADF_fnc_MessageParser; sleep 9;
	["CSAT","Corporal Derafsh","Corporal Derafsh: Infidel, where ar yu papers?"] call ADF_fnc_MessageParser; sleep 8;
	["2S","TWO SIERRA","TWO SIERRA: They are asking if we have papers."] call ADF_fnc_MessageParser; sleep 7;
	["ACO","ACO","FIRESTONE: Tell them to contact Colonel Mahshid. He will clear your passage."] call ADF_fnc_MessageParser; sleep 7;
	["CSAT","Corporal Derafsh","Corporal Derafsh: Yu do not give order too me infidel. Dis is not Amerika.<br/><br/>Wate heer!"] call ADF_fnc_MessageParser; sleep 70;
	["CSAT","Corporal Derafsh","Corporal Derafsh: Yu can go.<br/><br/>Go now!"] call ADF_fnc_MessageParser; sleep 7;
	["2S","TWO SIERRA","TWO SIERRA: FIRESTONE, TWO SIERRA OSCAR MIKE, out."] call ADF_fnc_MessageParser;
}; 
