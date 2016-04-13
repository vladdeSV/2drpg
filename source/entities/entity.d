import game;
import enums;
import slump;
import flags;

import std.algorithm.mutation : remove;

abstract class Entity
{
    this(int x, int y, char sprite, Color color)
    {
        _gx = x;
        _gy = y;
        _ccx = chunkLocation[0];
        _ccy = chunkLocation[1];
        _sprite = sprite;
        _color = color;

        _lookingDirection = cast(Direction)(random(4) + 1);
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
            !Game.world.getTileAt(nx, cast(int) _gy).solid
        )
        {
            _gx = nx;
        }

        //Check y axis
        if
        (
            !(ny < 0 || ny > chunkSize * worldSize) &&
            !Game.world.getTileAt(cast(int) _gx, ny).solid
        )
        {
            _gy = ny;
        }
    }


    void update()
    {
        move(_movingDirection);

        if(chunkLocation[0] != _ccx || chunkLocation[1] != _ccy)
        {
            foreach (n, e; Game.world.getChunk(_ccx, _ccy).entities)
            {
                if(this is e)
                {
                    Game.world.getChunk(_ccx, _ccy).entities = remove(Game.world.getChunk(_ccx, _ccy).entities, n);
                    break;
                }
            }

            Game.world.getChunk(chunkLocation[0], chunkLocation[1]).entities ~= this;
        }

        _ccx = chunkLocation[0];
        _ccy = chunkLocation[1];
    }

    ///Returns: int[x, y]
    auto globalLocation() const @property
    {
        return [cast(int)_gx, cast(int)_gy];
    }

    auto chunkLocation() const @property
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

    float velocity() const @property
    {
        return _moveVelocity;
    }

    Direction movingDirection() const @property
    {
        return _movingDirection;
    }

    Direction lookingDirection() const @property
    {
        return _lookingDirection;
    }

    ///Global x and y coordinates
    protected float _gx, _gy;
    private char _sprite;
    private Color _color;
    private int _ccx, _ccy;

    ///Current chunk location
    private float _moveVelocity;
    protected Direction _movingDirection;
    protected Direction _lookingDirection;
}
