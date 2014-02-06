
private ["_linked","_logic","_objectives","_westSpawn","_eastSpawn","_westVeh","_eastVeh","_timer","_bool"];
_logic = _this select 0;
_objectives = _this select 1;
_westSpawn = _this select 2;
_eastSpawn = _this select 3;
_westVeh = _this select 4;
_eastVeh = _this select 5;
_timer = _this select 6;
_tickets = _this select 7;
_bool = _this select 8;
_linked = "null";
if(count _this > 9) then
{
	_linked = _this select 9;
	player sidechat "linked!";
};

_logic setvariable ["objective",_objectives];
_logic setvariable ["west_spawn",_westSpawn];
_logic setvariable ["east_spawn",_eastSpawn];
_logic setvariable ["west_veh",_westVeh];
_logic setvariable ["east_veh",_eastVeh];
_logic setvariable ["timer",_timer];
_logic setvariable ["tickets",_tickets];
_logic setvariable ["linked",_linked];

if(HE_DEBUG) then
{
	player sidechat format["Logic saved with %1 | %2 | %3 | %4 | %5",_objectives,_westSpawn,_eastSpawn,_linked];
};
if(_bool) then
{
	if(isnil "HE_LOGIC") then
	{
		HE_LOGIC = [_logic];
	}
	else
	{
		HE_LOGIC = HE_LOGIC + [_logic];
	}
};