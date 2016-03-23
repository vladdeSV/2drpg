import entity_living;
import enums;

import scone;
import game;

import std.stdio;

class EntityPlayer : EntityLiving
{
    //this(int x, int y, char sprite, Color color, string name, int maxHealth, int[Attributes] stats)
    this(int x, int y)
    {
        super(x, y, char(1), Color.yellow, "Hermando", 10, [Attributes.strength : 150, Attributes.intelligence : -15]);
    }

    private bool _firstMove;

    override void move(Direction dir)
    {
        float nx = _gx, ny = _gy;

        if(hasFlag(dir, Direction.up))
        {
            if(_firstMove)
            {
                ny -= 1;
            }
            else
            {
                ny -= playerVelocity;
            }
        }
        if(hasFlag(dir, Direction.down))
        {
            if(_firstMove)
            {
                ny += 1;
            }
            else
            {
                ny += playerVelocity;
            }
        }
        if(hasFlag(dir, Direction.left))
        {
            if(_firstMove)
            {
                nx -= 1;
            }
            else
            {
                nx -= playerVelocity;
            }
        }
        if(hasFlag(dir, Direction.right))
        {
            if(_firstMove)
            {
                nx += 1;
            }
            else
            {
                nx += playerVelocity;
            }
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

    override void update()
    {
        if(_movingDirection == 0)
        {
            _firstMove = true;
        }
        else
        {
            _firstMove = false;
        }

        foreach(input; getInputs())
        {
            if(input.key == SK.escape)
            {
                Game.running = false;
                break;
            }

            if(input.pressed)
            {
                if(input.key == SK.up)
                {
                    _movingDirection |= Direction.up;
                }
                else if(input.key == SK.down)
                {
                    _movingDirection |= Direction.down;
                }
                else if(input.key == SK.left)
                {
                    _movingDirection |= Direction.left;
                }
                else if(input.key == SK.right)
                {
                    _movingDirection |= Direction.right;
                }
            }
            else
            {
                if(input.key == SK.up)
                {
                    _movingDirection ^= Direction.up;
                }
                else if(input.key == SK.down)
                {
                    _movingDirection ^= Direction.down;
                }
                else if(input.key == SK.left)
                {
                    _movingDirection ^= Direction.left;
                }
                else if(input.key == SK.right)
                {
                    _movingDirection ^= Direction.right;
                }
            }
        }

        super.update();
    }
}
