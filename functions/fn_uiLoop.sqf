
private ["_oldTicket","_tickets","_add","_timer","_min","_seconds","_disp","_oldTime"];
disableSerialization;
546 cutRsc ["he_statusDialog", "PLAIN"];
waitUntil {!isNull (uiNamespace getVariable ["he_statusDialog",displayNull])};
_disp = (uiNamespace getVariable "he_statusDialog");
_oldTicket = 300;
_oldTime = 900;
while{true} do
{

	if(!isnil "HE_TICKETS_A") then
	{
		if(_oldTicket != HE_TICKETS_A ) then
		{
		_oldTicket = HE_TICKETS_A;
		_tickets = _disp displayCtrl 1001;
		_tickets ctrlSetText format["Tickets:%1",HE_TICKETS_A];
		};
	};
	if(!isnil "HE_TIMER") then
	{
		if(_oldTime != HE_TIMER ) then
		{
		_oldTicket = HE_TIMER;
		_timer = _disp displayCtrl 1003;
		_min = floor (he_timer / 60);
		_seconds = round(abs((_min * 60) - HE_TIMER));
		_add = "";
		if(_seconds < 10) then
		{
			_add = "0";
		};
		_timer ctrlSetText format["%1:%2%3",_min,_add,_seconds];
		};
	};
	sleep 0.3;
};
// oldTicket != HE_TICKETS_A || _oldTime != HE_TIMER 924440