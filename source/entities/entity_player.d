import scone.keyboard : getInputs, SK, SCK, clearInputs, KeyEvent;

import enums;
import slump;
import flags;
import game;
import craft_part;

import entity_living;

import item;
import item_stone;

import tile_water;

import event;
import event_distance;
import event_time;
import event_check;

import std.string : wrap, split;
import std.algorithm : min;
import std.algorithm.mutation : remove;
import std.math : abs;
import std.traits : EnumMembers;

class EntityPlayer : EntityLiving
{
    this(int x, int y)
    {
        _remembered["pilt"] = false;
        super(/*ListName[random($)]*/ "Hermando" , x, y, char(1), Color.yellow);

        remember("wasd");

        remember("sideui");
        //remember("stuck");

        _events =
        [
            //timeEvent(0,
            //{
            //    _remembered["stuck"] = true;
            //    remember("wasd");
            //    _events ~= timeEvent(3,
            //    {
            //        addThought("A white smile fills you with happiness. You sit in a field that stretches infinitely out filled with yellow flowers. As you pick one of the flowers the petals blow away in the wind and you can hear your mother laughing.");
            //    });

            //    _events ~= timeEvent(14,
            //    {
            //        _remembered["wasd"] = false;
            //    });
            //    _events ~= timeEvent(16,
            //    {
            //        _remembered["stuck"] = false;
            //        clearInputs();
            //        remember("sideui");
            //    });

            //    _events ~= timeEvent(20,
            //    {
            //        remember("wasd");
            //    });
            //}),
            //timeEvent(60 * 2,
            //{
            //    _remembered["stuck"] = true;

            //    _events ~= timeEvent(4,
            //    {
            //        addThought("You are hiding behind a large tree trunk. You are counting from one to five, slowly, trying to be quiet. You don't want to be found. As that thought crosses your mind you can hear your fathers voice. You were found.");
            //    });

            //    _events ~= timeEvent(14,
            //    {
            //        _remembered["stuck"] = false;
            //    });
            //}),
            //timeEvent(60 * 6,
            //{
            //    _remembered["stuck"] = true;
            //    _events ~= timeEvent(3,
            //    {
            //        addThought("The sea stretches out in front of you. The sand beneath your feet is coarse and rough and it is everywhere. You start running around with your large inflatable ball. You kick it as hard as you can and it flies out over the water. You start crying as the ball sinks into the water.");
            //    });

            //    _events ~= timeEvent(14,
            //    {
            //        _remembered["stuck"] = false;
            //    });
            //}),
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
               addThought("[We never planned for someone to walk this much, congrats, I guess]");
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

        if(typeid(Game.world.getTileAt(cast(int) _gx, cast(int) _gy)) == typeid(TileWater))
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
            !Game.world.getTileAt(nx, _gy).solid &&
             (Game.world.getEntityAt(nx, _gy) is null || Game.world.getEntityAt(nx, _gy) is this)
        )
        {
            _distanceMoved += abs(nx - _gx);
            _gx = nx;
        }
        //<<

        //>>Check y axis if tile at new location is solid. If not, move.
        if
        (
            !(ny < 0 || ny > chunkSize * worldSize) &&
            !Game.world.getTileAt(_gx, ny).solid &&
             (Game.world.getEntityAt(_gx, ny) is null || Game.world.getEntityAt(_gx, ny) is this)
        )
        {
            _distanceMoved += abs(ny - _gy);
            _gy = ny;
        }
        //<<
    }

    private void updateInventory()
    {
        if(_inventory.length)
        {
            _selectedListItem %= _inventory.length;
        }
    }

    bool hasItem(TypeInfo_Class item)
    {
        foreach(i; _inventory)
        {
            if(item == typeid(i))
            {
                return true;
            }
        }

        return false;
    }

    override void update()
    {
        updateInventory();

        if(hasRemembered("stuck"))
        {
            _movingDirection = Direction.none;
            _crafting = false;
        }
        else if(_movingDirection == 0)
        {
            _gx = cast(int) _gx + 0.5;
            _gy = cast(int) _gy + 0.5;

            _firstMove = true;
        }
        else
        {
            _firstMove = false;
        }

        if(hasRemembered("stuck"))
        {
            _remembered["sideui"] = false;
        }
        else
        {
            _remembered["sideui"] = true;
        }

        foreach(input; getInputs())
        {
            if(input.key == SK.escape && input.pressed)
            {
                if(_crafting)
                {
                    _crafting = false;
                }
                else
                {
                    Game.running = false;
                }
                break;
            }

            if(hasRemembered("stuck"))
            {
                return;
            }

            //Check if player should be running
            _running = input.hasControlKey(SCK.shift);

            if(input.key == SK.w)
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
            else if(input.key == SK.s)
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
            else if(input.key == SK.a)
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
            else if(input.key == SK.d)
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
            else if(input.pressed)
            {
                if(input.key == SK.e && Game.world.getTileAt(cast(int) _gx, cast(int) _gy).items.length)
                {
                    if(_inventory.length < maxItems)
                    {
                        addItem(Game.world.getTileAt(cast(int) _gx, cast(int) _gy).grabItem());
                        //Game.world.getTileAt(cast(int) _gx, cast(int) _gy).item = null;
                        updateInventory();
                    }
                    else
                    {
                        addThought("I can't carry more.");
                    }
                }
                else if(input.key == SK.f)
                {
                    if(!Game.world.getTileAt(cast(int) _gx, cast(int) _gy).interact(this))
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

                        Game.world.getTileAt(cast(int) nx, cast(int) ny).interact(this);
                    }
                }
                else if(input.key == SK.c)
                {
                    _crafting = !crafting;
                }
                else if(inventory.length)
                {
                    if(input.key == SK.right)
                    {
                        _selectedListItem = (_selectedListItem + 1) % _inventory.length;
                    }
                    else if(input.key == SK.left)
                    {
                        _selectedListItem = (_selectedListItem + _inventory.length - 1) % _inventory.length;
                    }
                    else if(input.key == SK.u)
                    {
                        if(_inventory[_selectedListItem].usable)
                        {
                            _inventory[_selectedListItem].use(this);
                            _inventory = _inventory.remove(_selectedListItem);
                        }

                        updateInventory();
                    }
                    else if(input.key == SK.i)
                    {
                        _inventory[_selectedListItem].inspect(this);
                    }
                    else if(input.key == SK.q)
                    {

                        if(!Game.world.getTileAt(cast(int) _gx + (_lookingDirection == Direction.right ? 1 : 0) + (_lookingDirection == Direction.left ? -1 : 0),
                                                cast(int) _gy + (_lookingDirection == Direction.down ? 1 : 0 ) + (_lookingDirection == Direction.up  ? -1 : 0 )).solid)
                        {
                            Game.world.getTileAt(cast(int) _gx +
                                                (_lookingDirection == Direction.right ? 1 : 0) +
                                                (_lookingDirection == Direction.left ? -1 : 0),
                                                cast(int) _gy +
                                                (_lookingDirection == Direction.down ? 1 : 0 ) +
                                                (_lookingDirection == Direction.up  ? -1 : 0 ))
                                                .putItem(_inventory[_selectedListItem]);
                            _inventory = _inventory.remove(_selectedListItem);
                            updateInventory();
                        }
                    }
                }

                if(crafting && input.pressed)
                {
                    if(input.key == SK.up)
                    {
                        _selectedCraftItem = (_selectedCraftItem + CraftList.length - 1) % CraftList.length;
                    }
                    else if(input.key == SK.down)
                    {
                        _selectedCraftItem = (_selectedCraftItem + 1) % CraftList.length;
                    }
                    else if(input.key == SK.enter)
                    {
                        //This entire part is stupid and NOT good.

                        Craft craft = CraftList[_selectedCraftItem];

                        int[] itemCount = new int[](craft.parts.length);

                        foreach(item; _inventory)
                        {
                            foreach(m, part; craft.parts)
                            {
                                if(typeid(item) == part[0])
                                {
                                    itemCount[m] += 1;
                                }
                            }
                        }

                        bool allMaterials = true;
                        foreach(n, part; craft.parts)
                        {
                            allMaterials &= itemCount[n] >= part[1];
                        }

                        int[] itemsNeeded;

                        foreach(p; craft.parts)
                        {
                            itemsNeeded ~= p[1];
                        }

                        if(allMaterials)
                        {
                            for(int i = 0; i < _inventory.length; ++i)
                            {
                                foreach(n, part; craft.parts)
                                {
                                    if(itemsNeeded[n] > 0 && typeid(_inventory[i]) == part[0])
                                    {
                                        itemsNeeded[n] -= 1;
                                        _inventory = _inventory.remove(i);
                                        --i;
                                        break;
                                    }
                                }
                            }

                            addItem(cast(Item) craft.itemType.create());
                        }

                        updateInventory();
                    }
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

    private int lastThoughtN = 0;
    void addThought(string[] thoughts)
    {
        int n = min(random(thoughts.length), random(thoughts.length));

        if(lastThoughtN == n && thoughts.length > 1)
        {
            n = (n + 1) % thoughts.length;
        }

        lastThoughtN = n;

        _thoughts = split(thoughts[n].wrap(wSidebar - 4), '\n') ~ _thoughts;
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
            if((typeid(item) in _counter) is null)
            {
                _counter[typeid(item)] = 1;
            }
            else
            {
                _counter[typeid(item)] += 1;
            }

            _inventory ~= item;
            //++itemsPicked;
        }
        else
        {
            addThought([
                "I can't carry more, on the ground it goes.",
                "Oops, I dropped it.",
                "Aww, I can't carry more.",
                "Things shouldn't lay on the ground."
            ]);
            Game.world.getTileAt(_gx, _gy).putItem(item);
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

    bool crafting() const @property
    {
        return _crafting;
    }

    int counter(TypeInfo_Class type) @property
    {
        if((type in _counter) is null)
        {
            return _counter[type] = 0;
        }
        else
        {
            return _counter[type];
        }
    }

    TypeInfo_Class equipped() @property
    {
        if(_inventory.length > 0)
        {
            return typeid(this._inventory[_selectedListItem]);
        }
        else
        {
            return null;
        }
    }

    void addMemory(int amount = 1)
    {
        _memory += amount;
    }

    uint selectedListItem() @property const
    {
        return _selectedListItem;
    }

    uint selectedCraftItem() @property const
    {
        return _selectedCraftItem;
    }

    private float _distanceMoved = 0;
    private float _warmth = 6;
    private string[] _thoughts;
    private bool[string] _remembered;
    private int[TypeInfo_Class] _counter;
    private Personality _personality;
    private Item[] _inventory;
    private Event[] _events;
    private bool _running, _firstMove, _crafting;

    private uint _memory = 0;
    private uint _selectedListItem = 0;
    private uint _selectedCraftItem = 0;

    immutable int maxItems = 10;
}
