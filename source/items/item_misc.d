import item;
import enums;

import std.conv : to;

class ItemMisc : Item
{
    this(string name, int value)
    {
        super(name, value);
    }
}

/**
 * Create misc item.
 * Return: ItemMisc
 */
ItemMisc createMiscItem(string name, int value)
{
    return new ItemMisc(name, value);
}
