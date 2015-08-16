objBearclaw setName ["Jeff Kroger","Jeff","Kroger"];
bearClawAction = objBearclaw addAction ["<t align='left' color='#9DA698'>Rescue Bearclaw</t>",{[[],"ADF_TS_bearclawRescued"] call BIS_fnc_MP;},[],-95,true,true,"",""];
objBearclaw addEventHandler ["killed", {[[],"ADF_TS_bearclawKilled",true,false,false] spawn BIS_fnc_MP;}];

ADF_TS_bearclawRescued = {
	//objBearclaw enableAI "MOVE";
	objBearclaw removeAction bearClawAction;
	[objBearclaw] joinSilent player;
	BearclawRescued = true; publicVariable "BearclawRescued";	
	hint parseText"<br/><br/><t color='#6C7169' align='left'>Jeff Kroger (BEARCLAW), thanks fellas, it is really good to see you guys.<br/><br/></t>";
	uiSleep 8;
	hint parseText"<img size= '5' shadow='false' image='Img\2SIERRA_logo.paa'/><br/><br/><t color='#6C7169' align='left'>TWO SIERRA: FIRESTONE this is TWO SIERRA, we have BEARCLAW, I repeat we have BEARCLAW. How copy?<br/><br/></t>";	
	
	uiSleep 10;

	if (xRayDestroyed) then {
		hint parseText"<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: Good job TWO SIERRA. Escort BEARCLAW back to RV ZEBRA.<br/><br/></t>";
		_logTime = [dayTime] call BIS_fnc_timeToString;
		_logTimeText = "Log: " + _logTime;
		player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: Good job TWO SIERRA. Escort BEARCLAW back to RV ZEBRA.</font><br/><br/>"]];	
	} else {
		hint parseText"<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: Good job TWO SIERRA. Provide security for BEARCLAW.<br/><br/></t><t color='#6C7169' align='left'>Your next objective is to neutralize XRAY.<br/><br/></t>";
		_logTime = [dayTime] call BIS_fnc_timeToString;
		_logTimeText = "Log: " + _logTime;
		player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6C7169'>FIRESTONE: Good job TWO SIERRA. Provide security for BEARCLAW.<br/><br/>Your next objective is to neutralize XRAY.</font><br/><br/>"]];	
	};
};

ADF_TS_bearclawKilled = {
	hint parseText"<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: TWO SIERRA, we just received intel that BEARCLAW is K.I.A. Mission aborted. RTB asap!<br/></t>";
	_logTime = [dayTime] call BIS_fnc_timeToString;
	_logTimeText = "Log: " + _logTime;
	player createDiaryRecord ["Two Sierra Log", [_logTimeText,"<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/><font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/><font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/><font color='#6c7169'>FIRESTONE: TWO SIERRA, we just received intel that BEARCLAW is K.I.A. Mission aborted. RTB asap!</font><br/><br/>"]];
	sleep 12;
	["END2",false,5] call BIS_fnc_endMission;
};

