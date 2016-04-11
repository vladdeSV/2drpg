import scone.keyboard : getInputs, SK, SCK;

import enums;
import slump;
import flags;
import game;

import entity_living;

import item;

import event;
import event_distance;
import event_time;
import event_check;

import std.string : wrap, split;
import std.algorithm : min;
import std.math : abs;


class EntityPlayer : EntityLiving
{
    this(int x, int y)
    {
        super(/*ListName[random($)]*/ "Hermando" , x, y, char(1), Color.yellow);

        //gör en array av events, varpå du endast läseer av ID från Google Drive
        _events =
        [
            timeEvent(2, {
               addThought(name);
            }),
            checkEvent(
            {
                return warmth < 3;
            },
            {
                if(warmth < 1)
                {
                    addThought("I'm freezing...");
                }
                else
                {
                    addThought("It's very cold...");
                }
            }, 20),
            checkEvent(
            {
                return _warmth > 9;
            },
            {
               addThought
               ([
                    "It's hot!",
                    "It's burning hot!",
                    "I should cool down",
                ]);
            }, 20),
            distanceEvent(this, 1_000,
            {
               addThought("I've walked quite far.");
            }),
            distanceEvent(this, 10_000,
            {
               addThought("Why do I keep on walking? Why do I keep on keeping on?");
            }),
            distanceEvent(this, 100_000,
            {
               addThought("I have walked for so long but even now it doesn't matter.");
            }),
            distanceEvent(this, 1_000_000,
            {
               addThought("[We never planned for someone to walk this much, congrats, I guess] //Vladde och Fredde");
            }),
            //checkEvent(this, {
            //   addThought("");
            //}),
            //checkEvent(this, {
            //   addThought("");
            //}),
            //checkEvent(this, {
            //   addThought("");
            //}),
        ];
    }

    override void move(Direction dir)
    {
        float nx = _gx, ny = _gy;
        float vel = 0.1;

        if(Game.world.getTileAt(cast(int) _gx, cast(int) _gy).type == TileType.water)
        {
            vel -= 0.05;
        }

        if(_running)
        {
            vel += 0.1;
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
            _distanceMoved += abs(nx - _gx);
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
            _distanceMoved += abs(ny - _gy);
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
                //if(!Game.world.getTileAt(cast(int) _gx, cast(int) _gy).interact(this))
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

                    Game.world.getTileAt(nx, ny).interact(this);
                }
            }
        }

        foreach(ref e; _events)
        {
            e.check();
        }

        super.update();
    }

    void addThought(string s)
    {
        addThought([s]);
    }

    int lastThoughtN = 0;
    void addThought(string[] thoughts)
    {
        int n = min(random(thoughts.length), random(thoughts.length));

        if(lastThoughtN == n && thoughts.length > 1)
        {
            n = (n + 1) % thoughts.length;
        }

        lastThoughtN = n;

        _thoughts ~= split(thoughts[n].wrap(wSidebar - 2), '\n') ~ _thoughts;
    }

    void remember(string s)
    {
        _remembered[s] = true;
    }

    bool hasRemembered(string s)
    {
        if((s in _remembered) !is null)
        {
            return _remembered[s];
        }

        return false;
    }

    Personality personality() const @property
    {
        return _personality;
    }

    auto thoughts()
    {
        return _thoughts;
    }

    Item[] inventory() @property
    {
        return _inventory;
    }

    void addItem(Item item)
    {
        if(!inventoryFull)
        {
            _inventory ~= item;
        }
        else
        {
            assert(0, "Oopsie, I made a mistake in the code when it comes to items. Sorry ;)");
        }
    }

    bool inventoryFull() const @property
    {
        return _inventory.length >= maxItems;
    }

    float distanceMoved() const @property
    {
        return _distanceMoved;
    }

    float warmth() const @property
    {
        return _warmth;
    }

    int memory = 0;

    private float _distanceMoved = 0;
    private float _warmth = 6;
    private string[] _thoughts;
    private bool[string] _remembered;
    private Personality _personality;
    private Item[] _inventory;
    private Event[] _events;
    private bool _running, _firstMove;

    private immutable int maxItems = 10;
}
