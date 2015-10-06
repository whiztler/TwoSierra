diag_log "ADF RPT: Init - executing init_client.sqf"; // Reporting. Do NOT edit/remove

call compile preprocessFileLineNumbers "Core\F\ADF_fnc_typeWriter.sqf";
player createDiarySubject ["Two Sierra Log","Two Sierra Log"];
player createDiaryRecord ["Two Sierra Log",["Two Sierra Communications Log","<br/><br/><font color='#6c7169'>The Two Sierra Log is a logbook of all operational radio comms between Two Sierra and ACO<br/>The messages are logged once displayed on screen. All messages are time-stamped and saved in order of appearance.</font><br/><br/>"]];

waitUntil {sleep 2; ADF_missionInit}; sleep 5;

[
	["04 APR 2019","<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"],
	["REPUBLIC OF TAKISTAN","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"],
	["FOB LYON, FERUZ ABAD","<t align = 'center' shadow = '1' size = '1.0'>%1</t><br/>"]
] spawn ADF_fnc_typeWriter;

_logTime = [dayTime] call BIS_fnc_timeToString;
_logTimeText = "Log: " + _logTime;
player createDiaryRecord ["Two Sierra Log", [_logTimeText,"
<br/><br/><font color='#9da698' size='14'>From: ACO</font><br/>
<font color='#9da698' size='14'>Time: " + _logTime + "</font><br/><br/>
<font color='#6c7169'>------------------------------------------------------------------------------------------</font><br/><br/>
<t color='#A1A4AD' size='17'>Two Sierra WarmUp</t><br/><br/>
<font color='#6c7169'>WarmUp for a TWO SIERRA mission<br/><br/>	
Train your (motorized) infantry skills<br/><br/>
Test TWO SIERRA mission mods<br/><br/>
Objective: Clear OpFor AO's<br/><br/>
JIP / Respawn enabled<br/><br/>
Teleport to Leader at Flagpole<br/><br/>
Vanilla loadout. Supplies in vehicles</font>
"]];

hint parseText"<img size= '5' shadow='false' image='Img\logo_TwoSierra.paa'/><br/><br/>
<t color='#A1A4AD' size='1.7'>Two Sierra WarmUp</t><br/><br/>
<t color='#6C7169'>WarmUp for a<br/>TWO SIERRA mission</t><br/><br/>	
<t color='#6C7169'>Train your (motorized)<br/>infantry skills</t><br/><br/>
<t color='#6C7169'>Test mission mods</t><br/><br/>
<t color='#6C7169'>Objective: Clear<br/>OpFor AO's</t><br/><br/>
<t color='#6C7169'>JIP / Respawn enabled</t><br/><br/>
<t color='#6C7169'>Teleport to Leader<br/>at Flagpole</t><br/><br/>
<t color='#6C7169'>Vanilla loadout. Supplies<br/>in vehicles</t><br/><br/>	
";
