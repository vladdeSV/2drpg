module inventory;

import item;
import std.exception;

class Inventory
{
    this(int size, Item[] items = null)
    {
        m_items = items;

        //Will cut off items
        m_items.length = size;
    }

private:
    Item[] m_items;
}
