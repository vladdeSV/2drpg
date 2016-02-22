module item;

import enums;

class Item
{
    this(string name, int value)
    {
        m_name = name;
        m_value = value;
    }

    auto name() const @property
    {
        return m_name;
    }

    auto value() const @property
    {
        return m_value;
    }

private:
    string m_name;
    int m_value;
}

abstract class ItemEquipable : Item
{
    this(string name, Material material, int[Attributes] stats, int value)
    {
        super(name, value);
        m_material = material;
        m_stats = cast(int[Attributes]) stats;
    }

    auto stats() const @property
    {
        return m_stats;
    }

    auto material() const @property
    {
        return m_material;
    }

    int[Attributes] m_stats;
    Material m_material;
}

class ItemWeapon : ItemEquipable
{
    this(string name, Material material, int[Attributes] stats, bool twoHanded, int value)
    {
        super(name, material, stats, value);
        m_twoHanded = twoHanded;
    }

    auto twoHanded() const @property
    {
        return m_twoHanded;
    }

private:
    bool m_twoHanded;
}

class ItemArmor : ItemEquipable
{
    this(string name, Material material, int[Attributes] stats, ArmorType type, int value)
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


class ItemConsumable : Item
{
    this(string name, int healing, int value)
    {
        super(name, value);
        m_healing = healing;
    }

    auto healing() const @property
    {
        return m_healing;
    }

private:
    int m_healing;
}
