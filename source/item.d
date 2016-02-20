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
    this(WeaponType type, int[Attributes] attributes, string name, bool twoHanded int value)
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

class ItemArmor : Item
{
    this(ArmorType type, int[Attributes] attributes, string name, int value)
    {
        m_attributes = attributes;
        m_type = type;
        m_name = name;
        m_value = value;
    }

private:
    auto type() const @property
    {
        return m_type;
    }

    ArmorType m_type;
}

class ItemConsumable : Item
{
    this(ConsumableType type, int[Attributes] attributes, string name, int value, bool twoHanded)
    {
        m_attributes = attributes;
        m_type = type;
        m_name = name;
        m_value = value;
        m_twoHanded = twoHanded;
    }

private:
    auto type() const @property
    {
        return m_type;
    }

    ConsumableType m_type;
}

//TODO: I DO NOT WANT A SINGLE CLASS! POLYMORPHISM!
