import item;
import enums;

import std.conv : to;

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

/**
 * Create consumable.
 * Return: ItemConsumable
 */
ItemConsumable createConsumable(string name, int healing, int value)
{
    return new ItemConsumable(name, healing, value);
}
