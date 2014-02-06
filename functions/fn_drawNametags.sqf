waitUntil {!isnil "HE_OBJECTIVES"};
F_FONT_NAMETAGS = "EtelkaMonospaceProBold";
addMissionEventHandler ["Draw3D", {
_ents = (position player) nearEntities [["CAManBase","LandVehicle","Helicopter","Plane","Ship_F"], 10];
{
	if(typeof _x iskindof "Man") then
	{
		if(side _x == side player && _x != player) then
		{
			_pos = visiblePosition _x;
			drawIcon3D ["", [1,1,1,0.6], [_pos select 0,_pos select 1,(getPosATL _x select 2) + 2], 0, 0, 0,  name _x, 0, 0.04, F_FONT_NAMETAGS];
		};
	}
	else
	{
		_veh = _x;
		_inc = 1;
		_alternate = 0;
		{
			_prefix = "P:";
			_color = [1,1,1,0.6];
			if(driver _veh == _x) then
			{
				_prefix = "D:";
				_color = [0,0,1,0.6];
			};
			if(gunner _veh == _x) then
			{
				_prefix = "G:";
				_color = [0,0,1,0.6];
			};
			if(commander _veh == _x) then
			{
				_prefix = "C:";
				_color = [0,0,1,0.6];
			};
			if(assignedVehicleRole _x select 0 == "Turret" && commander _veh != _x && gunner _veh != _x && driver _veh != _x) then
			{
				_prefix = "G:";
				_color = [0,0,1,0.6];
			};
			_pos = visiblePosition _x;
			if(_pos distance (visiblePosition (driver _veh)) > 0.1 || driver _veh == _x) then
			{
				if(driver _veh == _x) then
				{
					_maxSlots = getNumber(configfile >> "CfgVehicles" >> typeof _veh >> "transportSoldier");
					_freeSlots = _veh emptyPositions "cargo";
				drawIcon3D ["", _color, [_pos select 0,_pos select 1,(getPosATL _x select 2) + 2], 0, 0, 0,  format["%1%2(%3/%4)",_prefix,name _x,(_maxSlots-_freeSlots),_maxSlots], 0, 0.04, F_FONT_NAMETAGS];
				}
				else
				{
					drawIcon3D ["", _color, [_pos select 0,_pos select 1,(getPosATL _x select 2) + 2], 0, 0, 0,  format["%1%2",_prefix,name _x], 0, 0.04, F_FONT_NAMETAGS];
				};
			}
			else
			{
				if(_x == gunner _veh) then
				{
					_pos = _veh modeltoworld (_veh selectionPosition "gunnerview");
					_visPos = visiblePosition _x;
					drawIcon3D ["", _color, [_pos select 0,_pos select 1,(getPosATL _x select 2) + 2], 0, 0, 0,  format["%1%2",_prefix,name _x], 0, 0.04, F_FONT_NAMETAGS];
				}
				else
				{
					_pos = visiblePosition _x;
					_angle = (getdir _veh)+180;
					_pos = [((_pos select 0) + sin(_angle)*(0.6*_inc)) , (_pos select 1) + cos(_angle)*(0.6*_inc),_pos select 2];
					drawIcon3D ["", _color, [_pos select 0,_pos select 1,(getPosATL _x select 2) + 1.5], 0, 0, 0,  format["%1%2",_prefix,name _x], 0, 0.04, F_FONT_NAMETAGS];
					_inc = _inc + 1;
				};
			};

		} foreach crew _veh;
	};
} foreach _ents;
if(!isnil "HE_OBJECTIVES") then
{
{
	if(alive _x) then
	{
		_pos = visiblePosition _x;
		_name = _x getvariable ["name",""];
		if(side player == opfor) then
		{
			_color = [0,1,0,0.9];
			if((_x getvariable ["armed",0]) == 1) then
			{
				_color = [0,0.5,0.5,0.9];
			};
			_dist = round(player distance _pos);
			drawIcon3D ["\A3\ui_f\data\map\markers\nato\o_hq.paa", _color, [_pos select 0,_pos select 1,(_pos select 2) + 1.5], 0, 0, 0,  format["%1(%2m)",_name,_dist], 0, 0.04, F_FONT_NAMETAGS];
		}
		else
		{
			_color = [1,0,0,0.9];
			if((_x getvariable ["armed",0]) == 1) then
			{
				_color = [0,0.5,0.5,0.9];
			};
			_dist = round(player distance _pos);
			drawIcon3D ["\A3\ui_f\data\map\markers\nato\o_hq.paa", _color, [_pos select 0,_pos select 1,(_pos select 2) + 1.5], 0, 0, 0,  format["%1(%2m)",_name,_dist], 0, 0.04, F_FONT_NAMETAGS];
		};
	};
} foreach HE_OBJECTIVES;

};


}];

