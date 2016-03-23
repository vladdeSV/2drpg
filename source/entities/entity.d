import enums;
import names;
import game;
import bits;

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
        float nx = _gx, ny = _gy;

        if(hasFlag(dir, Direction.up))
        {
            ny -= playerVelocity;
        }
        if(hasFlag(dir, Direction.down))
        {
            ny += playerVelocity;
        }
        if(hasFlag(dir, Direction.left))
        {
            nx -= playerVelocity;
        }
        if(hasFlag(dir, Direction.right))
        {
            nx += playerVelocity;
        }

        //Check x axis
        if
        (
            !(nx < 0 || nx > chunkSize * worldSize) &&
            !Game.world
            .getChunk(cast(int)(nx / chunkSize), cast(int)(_gy / chunkSize))
            .getTile(cast(int) nx % chunkSize, cast(int) _gy % chunkSize)
            .solid
        )
        {
            _gx = nx;
        }

        //Check y axis
        if
        (
            !(ny < 0 && chunkSize * worldSize) &&
            !Game.world
            .getChunk(cast(int)(_gx / chunkSize), cast(int)(ny / chunkSize))
            .getTile(cast(int) _gx % chunkSize, cast(int) ny % chunkSize)
            .solid
        )
        {
            _gy = ny;
        }
    }

    void update()
    {
        move(_movingDirection);
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
    float _gx, _gy;
    char _sprite;
    Color _color;

    Direction _movingDirection;
    Direction _lookingDirection;
}
