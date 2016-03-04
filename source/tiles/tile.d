import enums;

class Tile
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

private:
    char _sprite;
    bool _solid;
    Color _color, _backgroundColor;
}
