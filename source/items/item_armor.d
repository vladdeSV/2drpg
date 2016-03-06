import item;
import item_equipable;
import enums;

import std.conv : to;

class ItemArmor : ItemEquipable
{
    this(string name, ArmorType type, Material material, int[Attributes] stats, int value)
    {
        super(name, material, stats, value);
        _armorType = type;
    }

    auto armorType() const @property
    {
        return _armorType;
    }

private:
    ArmorType _armorType;
}

/**
 * Create armor. If name is null, name becomes "material + type".
 * Return: ItemArmor
 */
ItemArmor createArmor(string name, ArmorType type, Material material, int[Attributes] stats, int value)
{
    return new ItemArmor(name, type, material, stats, value);
}
