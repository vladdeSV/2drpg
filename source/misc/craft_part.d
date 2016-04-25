import std.typecons : Tuple;

alias CraftPart = Tuple!(TypeInfo_Class, int);

struct Craft
{
    string desc;
    TypeInfo_Class itemType;
    CraftPart[] parts;
}
