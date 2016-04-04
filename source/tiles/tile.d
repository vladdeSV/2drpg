import enums;

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

    this()
    {
        _sprite = '?';
        _solid = false;
        _color = Color.red;
        _backgroundColor = Color.white;
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

private:
    TileType _type;
    dchar _sprite;
    bool _solid;
    Color _color, _backgroundColor;
}
