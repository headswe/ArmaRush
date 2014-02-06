
private ["_cache","_unit"];
_cache = _this select 0;
_unit = _this select 1;
_cache setvariable ["armed",1,true];
_cache setvariable ["time",f_var_cacheTimer,true];
[[_cache,f_var_cacheTimer],"he_fnc_startCountDown",false] call BIS_fnc_MP;
