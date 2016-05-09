import enums;
public import entity_player;
import item;

abstract class Tile
{
    this(char sprite, Color color, Color backgroundColor, bool solid = false)
    {
        _sprite = sprite;
        _solid = solid;
        _color = color;
        _backgroundColor = backgroundColor;
    }

    auto sprite() const @property
    {
        return _sprite;
    }

    auto solid() const @property
    {
        return _solid;
    }

    Color color() const @property
    {
        return _color;
    }

    Color backgroundColor() const @property
    {
        return _backgroundColor;
    }

    bool used() const @property
    {
        return _used;
    }

    bool interact(EntityPlayer p)
    {
        return false;
    }

    void putItem(Item item)
    {
        _items ~= item;
    }

    Item[] items()
    {
        return _items;
    }

    Item grabItem()
    {
        if(!_items.length)
        {
            return null;
        }

        auto a = _items[$ - 1];
        _items.length -= 1;
        return a;
    }

    bool hasItem(TypeInfo_Class type)
    {
        foreach(ref item; _items)
        {
            if(typeid(item) == type)
            {
                return true;
            }
        }

        return false;
    }

protected:
    Item[] _items;
    char _sprite;
    bool _solid;
    Color _color, _backgroundColor;
    bool _used = true;
}
