import enums;
import item;
import parser;

import std.array;
import std.conv;
import std.csv;
import std.file;
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
    ///Create weapons from file 'source/list/csv/weapons.csv'
    foreach(weapon; csvReader!(Tuple!(string, string, string, string, string, string, string))(readText("source/list/csv/weapons.csv").replace("\t", ",")))
    {
        string refId = weapon[0];
        string name = (weapon[1].length ? weapon[1] : null);
        WeaponType type = weaponTypeFromString(weapon[2]);
        Material material = materialFromString(weapon[3]);
        int[Attributes] stats = statsFromString(weapon[4]);
        bool twoHanded = (weapon[5] == "TRUE");
        int value = to!int(weapon[6]);
        ListItemWeapon[refId] = cast(immutable)createWeapon(name, type, material, stats, twoHanded, value);
    }

    ///Create armors from file 'source/list/csv/armors.csv'
    foreach(armor; csvReader!(Tuple!(string, string, string, string, string, string))(readText("source/list/csv/armors.csv").replace("\t", ",")))
    {
        string refId = armor[0];
        string name = armor[1];
        ArmorType type = armorTypeFromString(armor[2]);
        Material material = materialFromString(armor[3]);
        int[Attributes] stats = statsFromString(armor[4]);
        int value = to!int(armor[5]);
        ListItemArmor[refId] = cast(immutable)createArmor(name, type, material, stats, value);
    }

    ///Create consumables from file 'source/list/csv/consumables.csv'
    foreach(consumable; csvReader!(Tuple!(string, string, string, string))(readText("source/list/csv/consumables.csv").replace("\t", ",")))
    {
        string refId = consumable[0];
        string name = consumable[1];
        int healing = to!int(consumable[2]);
        int value = to!int(consumable[3]);

        ListItemConsumable[refId] = cast(immutable)createConsumable(name, healing, value);
    }

    ///Create misc items from file 'source/list/csv/miscs.csv'
    foreach(misc; csvReader!(Tuple!(string, string, string))(readText("source/list/csv/miscs.csv").replace("\t", ",")))
    {
        string refId = misc[0];
        string name = misc[1];
        int value = to!int(misc[2]);

        ListItemMisc[refId] = cast(immutable)createMiscItem(name, value);
    }
}
