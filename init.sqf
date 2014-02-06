HE_DEBUG = true;

enableSaving [false, false];


HE_TICKETS_A = 300;
HE_TICKETS_B = 300;
HE_JIP = false;
HE_TIME_UP = false;
if (isNull player) then
{
	HE_JIP = true;
	[] spawn { waitUntil { !(isNull player) }; [[player],"he_fnc_addJIP",false,false] call BIS_fnc_MP; };
	player sidechat "YOU ARE JIP";
};

if(isServer) then
{
	HE_ENDED = false;

	[] spawn HE_fnc_gameLoop;
};
if(f_var_nameTags == 1) then
{
	[] spawn HE_fnc_drawNametags;
};
[] spawn HE_fnc_uiLoop;
