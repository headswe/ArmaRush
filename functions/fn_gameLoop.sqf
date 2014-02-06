
private ["_currentObjective","_car","_westVeh","_mkr","_forEachIndex","_objs","_linked","_currentIndex"];
waitUntil {!isNil "f_var_ChainNum"};
_currentIndex = f_var_ChainNum;
_currentObjective = HE_LOGIC select 0;
if(HE_DEBUG) then
{
player sidechat format ["%1", f_var_ChainNum];
};
if(_currentIndex == -1) then
{
	_currentObjective = HE_LOGIC call BIS_fnc_selectRandom;
}
else
{
	_currentObjective = HE_LOGIC select _currentIndex;
};

HE_Vehs = [];
HE_JIPS = [];
HE_STATUS = 0;
// 0 = prep
// 1 = running
// 2 = objectives completed or lost

sleep 1;
while{!HE_ENDED} do
{
	switch (HE_STATUS) do
	{
	    case 0:
	    {
			[[_currentObjective],"HE_fnc_Reset",true,false] call BIS_fnc_MP;
			waitUntil {!isNil "HE_TIMER_UPDATE"};
			sleep 5;

			HE_STATUS = 1;
			[[],"HE_fnc_start",true,false] call BIS_fnc_MP;
	    	_westVeh = (_currentObjective getvariable ["west_veh",[]]) +  (_currentObjective getvariable ["east_veh",[]]);
	    	{
	    		_car = _x call he_fnc_spawnVehicle;
	    		HE_Vehs = HE_Vehs + [_car];
	    		[_car] spawn he_fnc_respawnVehicle;

	    	} foreach _westVeh;
			player sidechat "starting";
	    };
	    case 1:
	    {
	    	_objs = _currentObjective getvariable ["objective",[]];
	    	{
	    		if(!alive _x) then
	    		{
	    			_mkr = format["Obj_%1",_forEachIndex];
	    			[[_mkr,"ColorGreen"],"he_fnc_SetMarkerColor",blufor,false] call BIS_fnc_MP;
	    			[[_mkr,"ColorRed"],"he_fnc_SetMarkerColor",opfor,false] call BIS_fnc_MP;
	    		};

	    	} forEach _objs;
	    	{
    			[[_currentObjective],"HE_fnc_Reset",[_x],false] call BIS_fnc_MP;
    			[[],"HE_fnc_start",[_x],false] call BIS_fnc_MP;
    			HE_JIPS = HE_JIPS - [_x];
	    	} foreach HE_JIPS;
	    	if({alive _x} count _objs <= 0) then
	    	{
	    		HE_STATUS = 2;
	    		player sidechat "ending";
	    	};
	    	if(HE_TICKETS_A <= 0) then
	    	{
	    		HE_STATUS = 2;
	    		player sidechat "no tickets left";

	    	};
	    	if(!isnil "HE_TIMER_UPDATE") then
	    	{
				if(HE_TIMER_UPDATE -HE_TIMER  > 30 ) then
				{
					[[HE_TIMER,HE_TIMER_LEN,HE_TIMER_START],"HE_fnc_setTimer",true,false] call BIS_fnc_MP;
					HE_TIMER_UPDATE = HE_TIMER;
					diag_log "sent update";
				};
			};
			if(!isnil "HE_TIME_UP") then
			{
				if (HE_TIME_UP) then
				{
					HE_STATUS = 2;
					diag_log "times up";
				};
			};
		};
		case 2:
		{
			_objs = _currentObjective getvariable ["objective",[]];
    		if(typename (_currentObjective getVariable ["linked","null"])  != "STRING" && HE_TICKETS_A > 0 && ({alive _x} count _objs) <= 0) then
    		{
				[["RoundComplete"],"BIS_fnc_showNotification",true,false] call BIS_fnc_MP;
    			_linked = (_currentObjective getVariable ["linked",nil]);
		    	_objs = _currentObjective getvariable ["objective",[]];
		    	{
		    		_mkr = format["Obj_%1",_forEachIndex];
		    		[[_mkr],"he_fnc_delMarkerLocal",true,false] spawn BIS_fnc_MP;

		    	} forEach _objs;
		    	{
		    		_x setvariable ["he_stopped",1];
		    	} foreach HE_VEHS;
    			_currentObjective = _linked;
    			sleep 1;
    			HE_STATUS = 0;
    			player sidechat "yay new _currentObjective";
    		}
    		else
    		{
    			player sidechat "ELSE";
    			if(HE_TICKETS_A <= 0) then
    			{
    				[["End2",false,true],"BIS_fnc_endMission",true,false] spawn BIS_fnc_MP;
    				HE_ENDED = true;
    			};
				if(HE_TIME_UP) then
				{
					[["End3",true,true],"BIS_fnc_endMission",true,false] spawn BIS_fnc_MP;
					HE_ENDED = true;
				};
				if(HE_TICKETS_A > 0 && !HE_TIME_UP ) then
				{
					///[["End1",true,true],"BIS_fnc_endMission",blufor,false] spawn BIS_fnc_MP;
					[["End1",false,true],"BIS_fnc_endMission",true,false] spawn BIS_fnc_MP;
					//["End1",false,true] spawn BIS_fnc_endMission;
					HE_ENDED = true;
				};
    		};
		};
	};
};