import item;
import enums;

import std.conv : to;

class ItemConsumable : Item
{
    this(string name, int healing)
    {
        super(name);
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
ItemConsumable createConsumable(string name, int healing)
{
    return new ItemConsumable(name, healing);
}
