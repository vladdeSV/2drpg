import game;
import enums;
import slump;
import flags;

import std.algorithm.mutation : remove;

abstract class Entity
{
    this(int x, int y, char sprite, Color color)
    {
        _wx = x;
        _wy = y;
        _tempCurrentChunk[0] = chunkLocation[0];
        _tempCurrentChunk[1] = chunkLocation[1];
        _sprite = sprite;
        _color = color;

        _movingDirection = Direction.none;
        _lookingDirection = cast(Direction)(random(4) + 1);
    }

    void move(Direction direction)
    {
        //new x (nx) and new y (ny)
        float nx = _wx, ny = _wy;
        if(hasFlag(direction, Direction.up))
        {
            ny -= 1;
        }
        if(hasFlag(direction, Direction.down))
        {
            ny += 1;
        }
        if(hasFlag(direction, Direction.left))
        {
            nx -= 1;
        }
        if(hasFlag(direction, Direction.right))
        {
            nx += 1;
        }

        //Not moving? Simply return
        if(direction == Direction.none)
        {
            return;
        }

        //Check if new location is inside world border and not on a solid tile
        if
        (
            !(nx < 0 || nx > chunkSize * worldSize) &&
            !Game.world.getTileAt(nx, cast(int) _wy).solid
        )
        {
            _wx = nx;
        }

        if
        (
            !(ny < 0 || ny > chunkSize * worldSize) &&
            !Game.world.getTileAt(cast(int) _wx, ny).solid
        )
        {
            _wy = ny;
        }
    }


    void update()
    {
        move(_movingDirection);

        if(chunkLocation[0] != _tempCurrentChunk[0] || chunkLocation[1] != _tempCurrentChunk[1])
        {
            foreach (n, e; Game.world.getChunk(_tempCurrentChunk[0], _tempCurrentChunk[1]).entities)
            {
                if(this is e)
                {
                    Game.world.getChunk(_tempCurrentChunk[0], _tempCurrentChunk[1]).entities = remove(Game.world.getChunk(_tempCurrentChunk[0], _tempCurrentChunk[1]).entities, n);
                    break;
                }
            }

            Game.world.getChunk(chunkLocation[0], chunkLocation[1]).entities ~= this;
        }

        _tempCurrentChunk = chunkLocation;
    }

    ///Returns: int[x, y]
    auto globalLocation() const @property
    {
        return [cast(int) _wx, cast(int) _wy];
    }

    auto chunkLocation() const @property
    {
        return [cast(int)(_wx / chunkSize), cast(int)(_wy / chunkSize)];
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
    protected float _wx, _wy;
    private char _sprite;
    private Color _color;
    private int[2] _tempCurrentChunk;

    ///Current chunk location
    private float _moveVelocity;
    protected Direction _movingDirection = Direction.none;
    protected Direction _lookingDirection = Direction.none;
}
