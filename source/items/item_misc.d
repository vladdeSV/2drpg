import item;
import enums;

import std.conv : to;

class ItemMisc : Item
{
    this(string name)
    {
        super(name);
    }
}

/**
 * Create misc item.
 * Return: ItemMisc
 */
ItemMisc createMiscItem(string name)
{
    return new ItemMisc(name);
}
