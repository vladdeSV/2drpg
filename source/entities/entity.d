import enums;
import names;
import game;
import bits;

import std.algorithm.mutation : remove;
import std.random;

abstract class Entity
{
    this(int x, int y, char sprite, Color color)
    {
        _gx = x;
        _gy = y;
        _tcx = chunkLocation[0];
        _tcy = chunkLocation[1];
        _sprite = sprite;
        _color = color;

        _lookingDirection = cast(Direction) uniform(1, 5);
    }

    void move(Direction dir)
    {
        int ny, nx;
        if(hasFlag(dir, Direction.up))
        {
            ny -= 1;
        }
        if(hasFlag(dir, Direction.down))
        {
            ny += 1;
        }
        if(hasFlag(dir, Direction.left))
        {
            nx -= 1;
        }
        if(hasFlag(dir, Direction.right))
        {
            nx += 1;
        }

        //Check x axis
        if
        (
            !(nx < 0 || nx > chunkSize * worldSize) &&
            !Game.world
            .getChunk(cast(int)(nx / chunkSize), cast(int)(_gy / chunkSize))
            .getTile(nx % chunkSize, cast(int) _gy % chunkSize)
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
            .getTile(cast(int) _gx % chunkSize, ny % chunkSize)
            .solid
        )
        {
            _gy = ny;
        }
    }


    void update()
    {
        move(_movingDirection);

        if(chunkLocation[0] != _tcx || chunkLocation[1] != _tcy)
        {
            foreach (n, e; Game.world.getChunk(_tcx, _tcy).entities)
            {
                if(this is e)
                {
                    Game.world.getChunk(_tcx, _tcy).entities = remove(Game.world.getChunk(_tcx, _tcy).entities, n);
                    break;
                }
            }

            Game.world.getChunk(chunkLocation[0], chunkLocation[1]).entities ~= this;
        }

        _tcx = chunkLocation[0];
        _tcy = chunkLocation[1];
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
    ///Current chunk location
    int _tcx, _tcy;
    char _sprite;
    Color _color;

    Direction _movingDirection;
    Direction _lookingDirection;
}
