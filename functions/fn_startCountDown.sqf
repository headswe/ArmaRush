
private ["_time","_name","_cache","_soundSource"];
_cache = _this select 0;
_time = _this select 1;
_name = _cache getvariable ["name",""];
["BombArmed",[format["%1 cache has been armed!",_name]]] call BIS_fnc_showNotification;

_soundSource = createSoundSource ["Sound_Alarm", position _cache, [], 0];
if(isServer) then
{
	while{_time > 0 && _cache getVariable ["armed",0] == 1} do
	{
		sleep 1;
		_time = _time -1;
		player sidechat format["%1",_time];
	};
	if(_cache getVariable ["armed",0] == 1) then
	{
		_name = _cache getvariable ["name",""];
		"Bo_Mk82" createVehicle (getpos _cache);
		_cache setdamage 1;
		[["CacheDestoryed",[format["%1 cache has been destroyed!",_name]]],"BIS_fnc_showNotification",true,false] call BIS_fnc_MP;
		if(!isnil "_soundSource") then
		{
			[[_soundSource],"HE_fnc_deleteSound",true] call BIS_fnc_MP;
		};
	}
	else
	{
		[["BombDisArmed",[format["%1 cache has been disarmed!",_name]]],"BIS_fnc_showNotification",true,false] call BIS_fnc_MP;
		player sidechat "disarmed";
		if(!isnil "_soundSource") then
		{
			[[_soundSource],"HE_fnc_deleteSound",true] call BIS_fnc_MP;
		};
	};
};
