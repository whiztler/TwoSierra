if (isServer || ADF_isHC) exitWith {};
hint parseText"<img size= '5' shadow='false' image='Img\ACO_logo.paa'/><br/><br/><t color='#6C7169' align='left'>FIRESTONE: Good to see you made it back TWO SIERRA.<br/><br/></t><t color='#6C7169' align='left'>Regroup and RTB.<br/><br/></t>";
_logTime = [dayTime] call BIS_fnc_timeToString;
_logTimeText = "Log: " + _logTime;
player createDiaryRecord ["Two Sierra Log", [_logTimeText,"
<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/>
<font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/>
<font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/>
<font color='#6C7169'>FIRESTONE: Good to see you made it back TWO SIERRA.<br/><br/>Regroup and RTB.</font>
<br/><br/>"]];

sleep 20;

_l = ["tLayer"] call BIS_fnc_rscLayer; 
_l cutText ["", "BLACK", 20];
["<img size= '10' shadow='false' image='Img\2SIERRA_intro.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 01 | Bearclaw</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
['END1',true,22] call BIS_fnc_endMission;
