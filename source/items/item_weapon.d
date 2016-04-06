import item;
import item_equipable;
import enums;

import std.conv : to;

class ItemWeapon : ItemEquipable
{
    this(string name, WeaponType type, Material material, int[Attributes] stats, bool twoHanded)
    {
        super(name, material, stats);
        _twoHanded = twoHanded;
    }

    auto twoHanded() const @property
    {
        return _twoHanded;
    }

private:
    bool _twoHanded;
}

/**
 * Create weapon. If name is null, name becomes "material + type".
 * Return: ItemWeapon
 */
ItemWeapon createWeapon(string name, WeaponType type, Material material, int[Attributes] stats, bool twoHanded)
{
    return new ItemWeapon(name, type, material, stats, twoHanded);
}
