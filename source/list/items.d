import enums;
import item;

import std.array;
import std.conv;
import std.csv;
import std.file;
import std.format;
import std.traits;
import std.typecons;

import item_weapon;
import item_armor;
import item_consumable;
import item_misc;

immutable static ItemWeapon[string] ListItemWeapon;
immutable static ItemConsumable[string] ListItemConsumable;
immutable static ItemArmor[string] ListItemArmor;
immutable static ItemMisc[string] ListItemMisc;

shared static this()
{
    ///Create weapons from file 'source/list/csv_weapons.csv'
    foreach(weapon; csvReader!(Tuple!(string, string, string, string, string, string, string))(readText("source/list/csv_weapons.csv").replace("\t", ",")))
    {
        string refId = weapon[0];
        string name = weapon[1];
        WeaponType type = weaponTypeFromString(weapon[2]);
        Material material = materialFromString(weapon[3]);
        int[Attributes] stats = statsFromString(weapon[4]);
        bool twoHanded = (weapon[5] == "TRUE");
        int value = to!int(weapon[6]);
        ListItemWeapon[refId] = cast(immutable)createWeapon(name, type, material, stats, twoHanded, value);
    }

    ///Create armors from file 'source/list/csv_armors.csv'
    foreach(armor; csvReader!(Tuple!(string, string, string, string, string, string))(readText("source/list/csv_armors.csv").replace("\t", ",")))
    {
        string refId = armor[0];
        string name = armor[1];
        ArmorType type = armorTypeFromString(armor[2]);
        Material material = materialFromString(armor[3]);
        int[Attributes] stats = statsFromString(armor[4]);
        int value = to!int(armor[5]);
        ListItemArmor[refId] = cast(immutable)createArmor(name, type, material, stats, value);
    }

    ///Create consumables from file 'source/list/csv_consumables.csv'
    foreach(consumable; csvReader!(Tuple!(string, string, string, string))(readText("source/list/csv_consumables.csv").replace("\t", ",")))
    {
        string refId = consumable[0];
        string name = consumable[1];
        int healing = to!int(consumable[2]);
        int value = to!int(consumable[3]);

        ListItemConsumable[refId] = cast(immutable)createConsumable(name, healing, value);
    }

    ///Create misc items from file 'source/list/csv_miscs.csv'
    foreach(misc; csvReader!(Tuple!(string, string, string))(readText("source/list/csv_miscs.csv").replace("\t", ",")))
    {
        string refId = misc[0];
        string name = misc[1];
        int value = to!int(misc[2]);

        ListItemMisc[refId] = cast(immutable)createMiscItem(name, value);
    }
}

private WeaponType weaponTypeFromString(string s)
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

private ArmorType armorTypeFromString(string s)
{
    switch(s)
    {
    case "belt":
        return ArmorType.belt;
    case "boots":
        return ArmorType.boots;
    case "bracer":
        return ArmorType.bracer;
    case "chest":
        return ArmorType.chest;
    case "cloak":
        return ArmorType.cloak;
    case "gauntlet":
        return ArmorType.gauntlet;
    case "glove":
        return ArmorType.glove;
    case "helmet":
        return ArmorType.helmet;
    case "necklace":
        return ArmorType.necklace;
    case "ring":
        return ArmorType.ring;
    case "robe":
        return ArmorType.robe;
    default:
        assert(0, format("Unknown armor type: %s", s));
    }
}

private Material materialFromString(string s)
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

private int[Attributes] statsFromString(string s)
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

private Attributes attributeFromString(string s)
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
