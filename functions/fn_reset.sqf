
private ["_mkr","_forEachIndex","_name","_currentObjective","_objectives","_westSpawn","_eastSpawn","_timer"];
if(!isDedicated) then

{

call he_fnc_waitForJIP;

waitUntil {alive player};

};
_currentObjective = _this select 0;
_objectives = _currentObjective getvariable ["objective",[]];
_westSpawn = _currentObjective getvariable ["west_spawn",[]];
_eastSpawn = _currentObjective getvariable ["east_spawn",[]];
_timer = _currentObjective getvariable ["timer",900];
_tickets = _currentObjective getvariable ["tickets",30];
HE_TICKETS_A = _tickets;
HE_TIMER_STOP = true;
HE_PASUED = true;
HE_OBJECTIVES = _objectives;
if(!isNil "HE_TIMER_SCRIPT") then
{
    terminate HE_TIMER_SCRIPT;
};
HE_TIMER_SCRIPT = [_timer] spawn he_fnc_timer;
waitUntil {!isNil "HE_TIMER_UPDATE"};
he_base_marker_blufor = _westSpawn select 0; // denotes a marker where you can spawn at base
he_base_marker_opfor = _eastSpawn select 0;
if(side player == blufor) then
{
    sleep 0.1;
	player setpos (getmarkerpos he_base_marker_blufor) findEmptyPosition [10,50,typeof player];
	// rearm
};
if(side player == opfor) then
{
    sleep 0.1;
    _startPos = _objectives call BIS_fnc_selectRandom;
	player setpos (getpos _startPos) findEmptyPosition [10,50,typeof player];
	// rearm
};


{
_mkr = createMarkerLocal [(format["Obj_%1",_forEachIndex]),getpos _x];
_mkr setMarkerTypeLocal "mil_circle";
_name = [_forEachIndex+1] call BIS_fnc_phoneticalWord;
_x setVariable ["name",_name];
switch (side player) do
{
    case blufor:
    {
    	_mkr setMarkerTextLocal format["Destroy %1",_name];
    	_mkr setMarkerColorLocal "ColorRed";
    };

    case opfor:
    {
     	_mkr setMarkerTextLocal format["Defend %1",_name];
     	_mkr setMarkerColorLocal "ColorGreen";
    };
};
[_x] call he_fnc_AddAction;
} foreach _objectives;
if(HE_JIP) then
{
    [player] execVM "onPlayerRespawn.sqf";
    HE_JIP = false;
};

// Alarm_BLUFOR