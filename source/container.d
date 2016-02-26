import item;
import std.exception;

class Container
{
    this(int size)
    {
        m_items.length = size;
    }

    this(Item[] startingItems, uint size = 0)
    {
        m_items = startingItems;

        if (size > 0)
        {
            m_items.length = size;
        }
    }

    auto content() @property
    {
        return m_items;
    }

    auto size() @property
    {
        return m_items.length;
    }

private:
    Item[] m_items;
}