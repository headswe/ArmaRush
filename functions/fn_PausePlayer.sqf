
private ["_curPos","_spawnPos"];
_spawnPos = getpos player;
while{HE_PASUED} do
{
	_curPos = getpos player;
	if(_spawnPos select 0 != _curPos select 0 || _spawnPos select 1 != _curPos select 1 || _spawnPos select 2 != _curPos select 2 ) then {player setpos _spawnPos};
	sleep 0.3;
};