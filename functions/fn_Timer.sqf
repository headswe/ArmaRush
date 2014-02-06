
private ["_time"];
_time = _this select 0;
HE_TIME_UP = false;
HE_TIMER = _time;
HE_TIMER_LEN = _time;
HE_TIMER_UPDATE = _time;
HE_TIMER_STOP = false;
if(isnil "HE_PASUED") then
{
HE_PASUED = false;
};
waitUntil {!HE_PASUED};
HE_TIMER_START = time;
while {HE_TIMER > 0 || HE_TIMER_STOP} do
{
	HE_TIMER = HE_TIMER_LEN + (HE_TIMER_START - time);
	//player sidechat format ["%1 : %2",_dif,HE_TIMER_START ];
	sleep 0.3;
};
if(!HE_TIMER_STOP  && HE_TIMER <= 0) then
{
	HE_TIME_UP = true;
};