import enums;
public import entity_player;
import item;

abstract class Tile
{
    this(TileType type, char sprite, Color color, Color backgroundColor, bool solid = false)
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

    Item item;

protected:
    TileType _type;
    char _sprite;
    bool _solid;
    Color _color, _backgroundColor;
    bool _used;
}
