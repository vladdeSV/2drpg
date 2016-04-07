import scone : getInputs, SK, SCK;
import entity_living;
import enums;
import game;
import misc;
import tile_water;

import event;
import event_time;
import event_distance;

import names;

import std.algorithm;
import std.math;
import std.string : wrap;
import std.array : split;
import std.random;

enum velPlayer = 0.1;
enum velPlayerRunning = 0.1;

class EntityPlayer : EntityLiving
{
    //this(int x, int y, char sprite, Color color, string name, int maxHealth, int[Attributes] stats)
    this(int x, int y)
    {
        super(x, y, char(1), Color.yellow, ListName[random($)], 10);

        foreach(ref s;
        [
            "tree",
            "berries",
            "stone",
            "grass",
            "fire",
            "berrystick",
            "treehurt"
        ]
        )
        {
            remembered[s] = false;
        }

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
            _lookingDirection = dir;
        }
        if(hasFlag(dir, Direction.down))
        {
            ny += _firstMove ? 0.6 : vel;
            _lookingDirection = dir;
        }
        if(hasFlag(dir, Direction.left))
        {
            nx -= _firstMove ? 0.6 : vel;
            _lookingDirection = dir;
        }
        if(hasFlag(dir, Direction.right))
        {
            nx += _firstMove ? 0.6 : vel;
            _lookingDirection = dir;
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
            else if(input.key == SK.e && input.pressed)
            {
                if(!Game.world.getChunkAtLocation(cast(int) _gx, cast(int) _gy).getTile(cast(int) _gx % chunkSize, cast(int) _gy % chunkSize).interact(this))
                {
                    int nx = cast(int) _gx, ny = cast(int) _gy;
                    if(_lookingDirection == Direction.up)
                    {
                        --ny;
                    }
                    else if(_lookingDirection == Direction.down)
                    {
                        ++ny;
                    }
                    else if(_lookingDirection == Direction.left)
                    {
                        --nx;
                    }
                    else if(_lookingDirection == Direction.right)
                    {
                        ++nx;
                    }

                    Game.world.getChunkAtLocation(nx, ny).getTile(nx % chunkSize, ny % chunkSize).interact(this);
                }
            }
        }

        super.update();
    }

    void addThought(string thought)
    {
        addThought([thought]);
    }

    void addThought(string[] thoughts)
    {
        auto thought = thoughts[random($)];
        if(thought != "")
        {
            _thoughts = split(thought.wrap(sidebarWidth - 2), '\n') ~ _thoughts;
        }
    }

    bool remember(string s)
    {
        if(remembered[s])
        {
            return true;
        }
        else
        {
            auto ans = remembered[s];
            remembered[s] = true;
            return ans;
        }

    }

    //item count
    int grass, stones, trees, berries;
    //stats count
    uint firesLit, housesBuilt;
    int memory = 20;
    float distanceMoved = 0;
    float warmth = 6; //Heat goes from 0 to 10

    bool[string] remembered;

private:
    string[] _thoughts;
    bool _firstMove;
    bool _running;
}

