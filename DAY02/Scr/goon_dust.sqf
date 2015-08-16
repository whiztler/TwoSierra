/* 
Goon/Gooncorp 2015
call with alpha parameter
[.1] execVM "goon_dust.sqf"; would be faint particles
[.6] execVM "goon_dust.sqf"; would be strong/opaque particles
*/

_alpha = (_this select 0) + random 0.15;// set the alpha of the particles based on call parameter
[_alpha] spawn {     
        while {true} do {		
	       _obj = (vehicle player);
	       _pos = getposASL _obj;
               setWind [0.401112*2,0.204166*2,false];
               _n =  abs(wind select 0) + abs(wind select 1) + abs(wind select 2);
               _velocity = wind;
               _color = [.38, .33, .2];             
               _dust = "#particlesource" createVehicleLocal _pos;  
               _dust setParticleParams [["a3\data_f\ParticleEffects\Universal\Universal.p3d", 16, 12, 8, 0], "", "Billboard", 1, 30, [0, 0, 0], _velocity, (_n * 12), 1.275, 1, 1, [75 + (random 46)], [_color + [0], _color + [(_this select 0)], _color + [0]], [1000], 1, 1, "", "", _obj];
               _dust setParticleRandom [3, [400 + (random 8), 400 + (random 10), 75], [2, 2, 0], 1, 0, [0, 0, 0, 0.01], 0, 0];
               _dust setParticleCircle [0.1, [0, 0, 0]];
               _dust setDropInterval 0.019; 
               _delay = 25 + (random 5);
               sleep _delay;
               deletevehicle _dust;
        };
     };