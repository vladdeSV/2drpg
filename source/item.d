module item;

import enums;

class Item
{
    this(ItemKind kind, int[Attributes] attributes, string name, string description, int value)
    {
        m_kind = kind;
        m_attributes = attributes;
        m_name = name;
        m_description = description;
        m_value = value;
    }

    ItemKind m_kind;
    int[Attributes] m_attributes;
    string m_name;
    string m_description;
    int m_value;
}
