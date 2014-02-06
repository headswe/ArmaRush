
private ["_can","_id","_cache"];
_cache = _this select 0;
if(side player == blufor) then
{
_can = "_target distance _this <= 4 && side _this == blufor && _target getvariable['armed',0] != 1 && alive _target";
_id = _cache addAction ["Arm!", {_this call he_fnc_ArmCache}, "", 6, true, true,"", _can ];
player setvariable ["ArmID",_id];
}
else
{
_id = _cache addAction ["disarm!", {_this call he_fnc_disArmCache}, "", 6, true, true, "", "_target distance _this <= 4 && side _this == opfor && _target getvariable['armed',0] == 1 && alive _target"];
player setvariable ["disArmID",_id];
};
