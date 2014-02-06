
private ["_list","_count","_respawnLoc","_leader","_vehicle","_newUnit","_disp"];
_newUnit = _this select 0;
_disp = createDialog "he_RespawnDialog";
ctrlEnable  [1601, false];
_respawnLoc = missionNamespace getvariable ["he_respawnLoc",nil];
while{isNil "_respawnLoc" && dialog} do
{
	_respawnLoc = missionNamespace getvariable ["he_respawnLoc",nil];
	if(leader _newUnit != _newUnit) then
	{
		_list = (getPos leader _newUnit) nearEntities [["SoldierWB"], 125];
		_count = {player sidechat format ["%1", _x]; side _x != side _newUnit} count _list;
		player sidechat format ["%1 - %2", _count,side _newUnit];
		if(_count <= 0) then
		{
			ctrlEnable  [1601, true];
		};
	};
};
closeDialog 0;
if(side _newUnit == blufor && _respawnLoc == "BASE") then
{
	_newUnit setpos (getmarkerpos he_base_marker_blufor) findEmptyPosition [1,50,typeof player];
	_newUnit setdir (markerDir he_base_marker_blufor);
	// rearm
};
if(side _newUnit == opfor && _respawnLoc == "BASE") then
{
	_newUnit setpos (getmarkerpos he_base_marker_opfor) findEmptyPosition [1,50,typeof player];
	_newUnit setdir (markerDir he_base_marker_opfor);
	// rearm
};
if(_respawnLoc == "MOBILE") then
{
	_leader = (leader _newUnit);
	_vehicle = vehicle _leader ;
	if(_vehicle == _leader) then
	{
		_newUnit setpos (getpos (leader _newUnit)) findEmptyPosition [10,50,typeof player];
	}
	else
	{
		if(_vehicle emptyPositions "Cargo" > 0) then
		{
			_newUnit moveInCargo vehicle _leader;
		}
		else
		{
			_newUnit setpos (getpos (leader _newUnit)) findEmptyPosition [10,50,typeof player];
			_newUnit setdir (getdir (leader _newUnit));
		};
	};
};
[[_newUnit],"he_fnc_playerDead",false] call BIS_fnc_MP;
missionNamespace setvariable ["he_respawnLoc",nil];