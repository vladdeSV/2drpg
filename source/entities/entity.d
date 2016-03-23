import enums;
import names;

import std.random;

abstract class Entity
{
    this(int x, int y, char sprite, Color color)
    {
        _gx = x;
        _gy = y;
        _sprite = sprite;
        _color = color;

        _lookingDirection = cast(Direction) uniform(1, 5);
    }

    void move(Direction dir)
    {
        if(dir == Direction.up)
        {

        }
        else if(dir == Direction.down)
        {

        }
        else if(dir == Direction.left)
        {

        }
        else if(dir == Direction.right)
        {

        }
    }

    void update()
    {

    }

    ///Returns: int[x, y]
    auto globalLocation() const @property
    {
        return [cast(int)_gx, cast(int)_gy];
    }

    auto localLocation() const @property
    {
        return [cast(int)_gx % chunkSize, cast(int)_gy % chunkSize];
    }

    auto chunkLocation()
    {
        return [cast(int)(_gx / chunkSize), cast(int)(_gy / chunkSize)];
    }

    auto sprite() const @property
    {
        return _sprite;
    }

    Color color() const @property
    {
        return _color;
    }

protected:
    ///Global x and y coordinates
    double _gx, _gy;
    char _sprite;
    Color _color;

    Direction _movingDirection;
    Direction _lookingDirection;
}
