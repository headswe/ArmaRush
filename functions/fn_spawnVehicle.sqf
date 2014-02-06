
private ["_mkr","_vehClass","_veh"];
_mkr = _this select 0;
_vehClass = _this select 1;
player sidechat format["%1 - %2",_mkr,_vehClass];
_veh = _vehClass createVehicle (getmarkerpos _mkr);
sleep 0.3;
_veh setdir markerDir _mkr;
_veh setvariable ["spawnPos",_mkr];
_veh;