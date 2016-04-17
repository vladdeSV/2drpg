import std.typecons : Tuple;

alias CraftPart = Tuple!(TypeInfo_Class, int);

struct Craft
{
    TypeInfo_Class itemType;
    CraftPart[] parts;
}
