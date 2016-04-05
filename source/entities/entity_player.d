import scone : getInputs, SK, SCK;
import entity_living;
import enums;
import game;
import misc;
import tile_water;

import event;
import event_time;
import event_distance;

import std.algorithm;
import std.math;
import std.string : wrap;
import std.array : split;

enum velPlayer = 0.1;
enum velPlayerRunning = 0.1;

class EntityPlayer : EntityLiving
{
    //this(int x, int y, char sprite, Color color, string name, int maxHealth, int[Attributes] stats)
    this(int x, int y)
    {
        super(x, y, char(1), Color.yellow, "Hermando", 10, [Attributes.strength : 150, Attributes.intelligence : -15]);

        remembered["tree"] = false;
        remembered["flowers"] = false;
        remembered["moving"] = false;

    }

    auto thoughts() @property
    {
        return _thoughts;
    }

    override void move(Direction dir)
    {
        float nx = _gx, ny = _gy;
        float vel = velPlayer;

        if(Game.world.getChunkAtLocation(cast(int) _gx, cast(int) _gy).getTile(cast(int) _gx % chunkSize, cast(int) _gy % chunkSize).type == TileType.water)
        {
            vel -= 0.05;
        }

        if(_running)
        {
            vel += velPlayerRunning;
        }

        //>>Check moving directions and move accordingly
        if(hasFlag(dir, Direction.up))
        {
            ny -= _firstMove ? 0.6 : vel;
        }
        if(hasFlag(dir, Direction.down))
        {
            ny += _firstMove ? 0.6 : vel;
        }
        if(hasFlag(dir, Direction.left))
        {
            nx -= _firstMove ? 0.6 : vel;
        }
        if(hasFlag(dir, Direction.right))
        {
            nx += _firstMove ? 0.6 : vel;
        }
        //<<

        //>>Check x axis if tile at new location is solid. If not, move.
        if
        (
            !(nx < 0 || nx > chunkSize * worldSize) &&
            !Game.world
            .getChunk(cast(int)(nx / chunkSize), cast(int)(_gy / chunkSize))
            .getTile(cast(int) nx % chunkSize, cast(int) _gy % chunkSize)
            .solid
        )
        {
            distanceMoved += abs(nx - _gx);
            _gx = nx;
        }
        //<<

        //>>Check y axis if tile at new location is solid. If not, move.
        if
        (
            !(ny < 0 && chunkSize * worldSize) &&
            !Game.world
            .getChunk(cast(int)(_gx / chunkSize), cast(int)(ny / chunkSize))
            .getTile(cast(int) _gx % chunkSize, cast(int) ny % chunkSize)
            .solid
        )
        {
            distanceMoved += abs(ny - _gy);
            _gy = ny;
        }
        //<<
    }

    override void update()
    {
        if(_movingDirection == 0)
        {
            _gx = cast(int) _gx + 0.5;
            _gy = cast(int) _gy + 0.5;

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

            //Check if player should be running
            _running = input.hasControlKey(SCK.shift);

            //>>Set movemental direction
            if(input.key == SK.up || input.key == SK.w)
            {
                if(input.pressed)
                {
                    addFlag(_movingDirection, Direction.up);
                }
                else
                {
                    removeFlag(_movingDirection, Direction.up);
                }
            }
            else if(input.key == SK.down || input.key == SK.s)
            {
                if(input.pressed)
                {
                    addFlag(_movingDirection, Direction.down);
                }
                else
                {
                    removeFlag(_movingDirection, Direction.down);
                }
            }
            else if(input.key == SK.left || input.key == SK.a)
            {
                if(input.pressed)
                {
                    addFlag(_movingDirection, Direction.left);
                }
                else
                {
                    removeFlag(_movingDirection, Direction.left);
                }
            }
            else if(input.key == SK.right || input.key == SK.d)
            {
                if(input.pressed)
                {
                    addFlag(_movingDirection, Direction.right);
                }
                else
                {
                    removeFlag(_movingDirection, Direction.right);
                }
            }
        }

        super.update();
    }

    auto addThought(string thought)
    {
        _thoughts = split(thought.wrap(sidebarWidth - 2), '\n') ~ _thoughts;
    }

    int flowers, trees;
    int memory = 20;
    float distanceMoved = 0;
    bool[string] remembered;

private:
    //gö en array av events, varpå du ändast läseer av id:S från gdrive.
    string[] _thoughts;
    bool _firstMove;
    bool _running;
}

