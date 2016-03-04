import item;
import std.exception;

class Container
{
    this(int size)
    {
        _items.length = size;
    }

    this(Item[] startingItems, uint size = 0)
    {
        _items = startingItems;

        if (size > 0)
        {
            _items.length = size;
        }
    }

    auto content() @property
    {
        return _items;
    }

    auto size() @property
    {
        return _items.length;
    }

private:
    Item[] _items;
}
