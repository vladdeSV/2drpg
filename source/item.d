module item;

import enums;

abstract class Item
{
    auto attributes() const @property
    {
        return m_attributes;
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
    int[Attributes] m_attributes;
    string m_name;
    int m_value;
}

class ItemWeapon : Item
{
    this(WeaponType type, int[Attributes] attributes, string name, bool twoHanded, int value)
    {
        m_type = type;
        m_attributes = attributes;
        m_name = name;
        m_value = value;
        m_twoHanded = twoHanded;
    }

    auto type() const @property
    {
        return m_type;
    }

    auto twoHanded() const @property
    {
        return m_twoHanded;
    }

private:
    bool m_twoHanded;
    WeaponType m_type;
}

class ItemTool : Item
{
    this(ToolType type, int[Attributes] attributes, string name, int value);

    auto type() const @property
    {
        return m_type;
    }

private:
    ToolType m_type;
}

class ItemArmor : Item
{
    this(ArmorType type, int[Attributes] attributes, string name, int value)
    {
        m_attributes = attributes;
        m_type = type;
        m_name = name;
        m_value = value;
    }

    auto type() const @property
    {
        return m_type;
    }

private:
    ArmorType m_type;
}

class ItemConsumable : Item
{
    this(ConsumableType type, int[Attributes] attributes, string name, int value)
    {
        m_attributes = attributes;
        m_type = type;
        m_name = name;
        m_value = value;
    }

    auto type() const @property
    {
        return m_type;
    }

private:
    ConsumableType m_type;
}
