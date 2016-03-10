import enums;

import std.array;
import std.conv;
import std.format;
import std.traits;

WeaponType weaponTypeFromString(string s)
{
    switch(s)
    {
    case "sword":
        return WeaponType.sword;
    case "bow":
        return WeaponType.bow;
    case "staff":
        return WeaponType.staff;
    case "sheild":
        return WeaponType.sheild;
    case "axe":
        return WeaponType.axe;
    case "polearm":
        return WeaponType.polearm;
    default:
        assert(0, format("Unknown weapon type: %s", s));
    }
}

ArmorType armorTypeFromString(string s)
{
    switch(s)
    {
    case "head":
        return ArmorType.head;
    case "neck":
        return ArmorType.neck;
    case "body":
        return ArmorType.body_;
    case "arm":
        return ArmorType.arm;
    case "hand":
        return ArmorType.hand;
    case "hip":
        return ArmorType.hip;
    case "leg":
        return ArmorType.leg;
    case "boot":
        return ArmorType.boot;
    default:
        assert(0, format("Unknown armor type: %s", s));
    }
}

Material materialFromString(string s)
{
    switch(s)
    {
    case "cloth":
        return Material.cloth;
    case "leather":
        return Material.leather;
    case "wood":
        return Material.wood;
    case "stone":
        return Material.stone;
    case "bronze":
        return Material.bronze;
    case "iron":
        return Material.iron;
    case "steel":
        return Material.steel;
    case "gold":
        return Material.gold;
    case "diamond":
        return Material.diamond;
    default:
        assert(0, format("Unknown material: %s", s));
    }
}

/**
 * "str=3 def=4 int=-3"
 */
int[Attributes] statsFromString(string s)
{
    string[] attrs = s.split();

    int[Attributes] a;

    foreach(attr; attrs)
    {
        string[2] b = attr.split("=");
        a[attributeFromString(b[0])] = to!int(b[1]);
    }

    foreach(att; EnumMembers!Attributes)
    {
        if (att !in a)
        {
            a[att] = 0;
        }
    }
    return a.rehash();
}

Attributes attributeFromString(string s)
{
    switch(s)
    {
    case "str":
        return Attributes.strength;
    case "con":
        return Attributes.constitution;
    case "def":
        return Attributes.defense;
    case "dex":
        return Attributes.dexterity;
    case "int":
        return Attributes.intelligence;
    case "cha":
        return Attributes.charisma;
    case "wis":
        return Attributes.wisdom;
    case "will":
        return Attributes.willpower;
    case "perc":
        return Attributes.perception;
    case "luck":
        return Attributes.luck;
    default:
        assert(0, format("Unknown attribute: %s", s));
    }
}
