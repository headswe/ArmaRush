
private ["_vehMkr","_type","_car","_veh"];
_veh = _this select 0;
_veh addEventHandler ["GetOut",{_this select 0 setvariable ["he_left",time]}];
_veh addEventHandler ["Getin",{_this select 0 setvariable ["he_left",99999999999]}];
waitUntil {sleep 1;!alive _veh || _veh getVariable ["he_stopped",0] == 1 || time - (_veh getVariable ["he_left",99999999999999999999]) >= 30};
if(_veh getVariable ["he_stopped",0] == 0) then
{
sleep 5;
_vehMkr = _veh getvariable ["spawnPos",""];

_type = typeOf _veh;
HE_Vehs = HE_Vehs - [_veh];
deleteVehicle _veh;
_car = [_vehMkr,_type] call he_fnc_spawnVehicle;
HE_Vehs = HE_Vehs + [_car];
[_car] spawn he_fnc_respawnVehicle;
}
else
{
	HE_Vehs = HE_Vehs - [_veh];
	deleteVehicle _veh;
};