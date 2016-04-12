import enums;
public import entity_player;

abstract class Tile
{
    this(TileType type, dchar sprite, Color color, Color backgroundColor, bool solid = false)
    {
        _type = type;
        _sprite = sprite;
        _solid = solid;
        _color = color;
        _backgroundColor = backgroundColor;
    }

    TileType type() const @property
    {
        return _type;
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

    bool interact(EntityPlayer p)
    {
        return false;
    }

    bool used() const @property
    {
        return _used;
    }

protected:
    TileType _type;
    dchar _sprite;
    bool _solid;
    Color _color, _backgroundColor;
    bool _used;
}
