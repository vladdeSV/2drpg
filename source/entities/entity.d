import enums;
import names;
import enums;

import std.random;

abstract class Entity
{
    this(int x, int y, char sprite, Color color)
    {
        _lx = x;
        _ly = y;
        _sprite = sprite;
        _color = color;

        _lookingDirection = cast(Direction) uniform(1, 5);
    }

    void update() {}

    ///Returns: int[x, y]
    auto position() const @property
    {
        return [_lx, _ly];
    }

    auto sprite() const @property
    {
        return _sprite;
    }

    Color color() const @property
    {
        return _color;
    }

private:
    ///Local x and y in chunk
    int _lx, _ly;
    char _sprite;
    Color _color;

    Direction _lookingDirection;
}
