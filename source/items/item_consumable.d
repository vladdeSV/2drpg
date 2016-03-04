import item;
import enums;

import std.conv : to;

class ItemConsumable : Item
{
    this(string name, int healing, int value)
    {
        super(name, value);
        _healing = healing;
    }

    auto healing() const @property
    {
        return _healing;
    }

private:
    int _healing;
}

/**
 * Create consumable.
 * Return: ItemConsumable
 */
ItemConsumable createConsumable(string name, int healing, int value)
{
    return new ItemConsumable(name, healing, value);
}
