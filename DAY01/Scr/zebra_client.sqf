if (!hasInterface) exitWith {};
["ACO","ACO","FIRESTONE: Good to see you made it back TWO SIERRA.<br/><br/>Regroup and RTB."] call ADF_fnc_MessageParser; sleep 10;
_l = ["tLayer"] call BIS_fnc_rscLayer; 
_l cutText ["", "BLACK", 20];
["<img size= '10' shadow='false' image='Img\intro_TwoSierra.paa'/><br/><br/><t size='.7' color='#FFFFFF'>Day 01 | Bearclaw</t>",0,0,9,8] spawn BIS_fnc_dynamicText;		
['END1',true,22] call BIS_fnc_endMission;
