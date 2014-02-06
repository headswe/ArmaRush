
private ["_unit"];
_unit = _this select 0;
switch (side _unit) do
{
    case blufor:
    {
		HE_TICKETS_A =  HE_TICKETS_A-1;
    };
    case opfor:
    {
		HE_TICKETS_B = HE_TICKETS_B-1;
    };
};
publicVariable  "HE_TICKETS_A";
publicVariable  "HE_TICKETS_B";