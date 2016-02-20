module item;

import enums;

class Item
{
    string m_name;
    string m_description;

    ItemKind m_kind;

    int m_value;
    int[Attributes] m_attributes;
}
