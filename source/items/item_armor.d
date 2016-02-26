import item;
import item_equipable;
import enums;

import std.conv : to;

class ItemArmor : ItemEquipable
{
    this(string name, ArmorType type, Material material, int[Attributes] stats, int value)
    {
        super(name, material, stats, value);
        m_armorType = type;
    }

    auto armorType() const @property
    {
        return m_armorType;
    }

private:
    ArmorType m_armorType;
}

/**
 * Create armor. If name is null, name becomes "material + type".
 * Return: ItemArmor
 */
ItemArmor createArmor(string name, ArmorType type, Material material, int[Attributes] stats, int value)
{
    if(name is null) {
        name ~= to!string(material) ~ ' ' ~ to!string(type);
    }

    return new ItemArmor(name, type, material, stats, value);
}
