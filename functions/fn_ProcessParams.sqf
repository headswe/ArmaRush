// F3 - Process ParamsArray
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================


private ["_paramName","_forEachIndex","_paramValue","_paramCode","_code","_paramArray"];
_paramArray = paramsArray;
{
	_paramName =(configName ((missionConfigFile >> "Params") select _forEachIndex));
	_paramValue = (_paramArray select _forEachIndex);
	_paramCode = ( getText (missionConfigFile >> "Params" >> _paramName >> "code"));
	_code = format[_paramCode, _paramValue];
	call compile _code;
} foreach _paramArray;