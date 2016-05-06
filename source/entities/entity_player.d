import scone.keyboard : getInputs, SK, SCK, clearInputs, KeyEvent;

import enums;
import slump;
import flags;
import game;
import craft_part;
import quest;

import entity_living;
import entity_animal;

import item;
import item_stone;

import tile_water;
import tile_berry;

import event;
import event_distance;
import event_time;
import event_check;

import std.string : wrap, split;
import std.algorithm : min;
import std.algorithm.mutation : remove;
import std.math : abs;
import std.traits : EnumMembers;

private enum eventStartTime = 3;
private enum minute = 60;

class EntityPlayer : EntityLiving
{
    this(int x, int y)
    {
        super("Rosemary" , x, y, char(1), Color.yellow);

        //_remembered["pilt"] = false;
        remember("wasd");
        //remember("stuck");

        //remember("sideui");

        //import item_maxe;
        //_inventory ~= new ItemMaxe;

        _events =
        [
            //timeEvent(0,
            //{
            //    _remembered["blank"] = true;
            //    _remembered["stuck"] = true;
            //    //remember("wasd");
            //    _events ~= timeEvent(4, {
            //        _remembered["blank"] = false;
            //    });
            //    _events ~= timeEvent(8,
            //    {
            //        addThought("You sit in a field that stretches infinitely, filled with yellow flowers. As you pick a flower the petals blow up in the wind, you hear your mother laughing.");
            //    });

            //    _events ~= timeEvent(16,
            //    {
            //        _remembered["wasd"] = false;
            //    });
            //    _events ~= timeEvent(18,
            //    {
            //        _remembered["stuck"] = false;
            //        clearInputs();
            //        remember("sideui");
            //    });

            //    _events ~= timeEvent(22,
            //    {
            //        remember("wasd");
            //    });
            //}),

            //timeEvent(minute,
            //{
            //    _remembered["stuck"] = true;

            //    _events ~= timeEvent(eventStartTime + 1,
            //    {
            //        addThought("You are hiding behind a large tree trunk. You don't want to be found. As that thought crosses your mind you can hear your fathers voice. You were found.");
            //    });

            //    _events ~= timeEvent(eventStartTime + 9,
            //    {
            //        _remembered["stuck"] = false;
            //    });
            //}),

            //timeEvent(minute * 2,
            //{
            //    _remembered["stuck"] = true;
            //    _events ~= timeEvent(eventStartTime,
            //    {
            //        addThought("The sand beneath your feet is coarse and rough and it is everywhere. You start playing with your ball. You kick it and you cry as the ball sinks into the water.");
            //    });

            //    _events ~= timeEvent(eventStartTime + 11,
            //    {
            //        _remembered["stuck"] = false;
            //    });
            //}),

            //timeEvent(minute * 5,
            //{
            //    _remembered["stuck"] = true;
            //    _events ~= timeEvent(eventStartTime,
            //    {
            //        addThought("Riding on your father’s shoulders you can see all over the creek, you feel the wind blowing against your face, running through the field. You jump and you can hear your father jumping after you");
            //    });

            //    _events ~= timeEvent(eventStartTime + 8,
            //    {
            //        _remembered["stuck"] = false;
            //    });
            //}),

            //timeEvent(minute * 9,
            //{
            //    _remembered["stuck"] = true;
            //    _events ~= timeEvent(eventStartTime,
            //    {
            //        addThought("You hide under your blanket tears running down your cheeks. Screams from downstairs, everywhere, have gone on forever. There is always more, you are terrified.");
            //    });

            //    _events ~= timeEvent(eventStartTime + 6,
            //    {
            //        _remembered["stuck"] = false;
            //    });
            //}),


            //timeEvent(minute * 15,
            //{
            //    _remembered["stuck"] = true;
            //    _events ~= timeEvent(eventStartTime,
            //    {
            //        addThought("Summer tunes. Dancing under a starry night. You are being carried by your father, as you look up sleepily you can see him smiling back.");
            //    });

            //    _events ~= timeEvent(eventStartTime + 6,
            //    {
            //        _remembered["stuck"] = false;
            //    });
            //}),

            //timeEvent(minute * 18,
            //{
            //    _remembered["stuck"] = true;
            //    _events ~= timeEvent(eventStartTime,
            //    {
            //        addThought("The smoke fills the air, everywhere around you is fire. The world is burning and you can only stand still and watch. You lean over one of the flames and warm your hands.");
            //    });

            //    _events ~= timeEvent(eventStartTime + 9,
            //    {
            //        _remembered["stuck"] = false;
            //    });
            //}),

            //timeEvent(minute * 20,
            //{
            //    _remembered["stuck"] = true;
            //    _events ~= timeEvent(eventStartTime,
            //    {
            //        addThought("You are lying down in a hidden world. Staring up into the clear sky you feel at peace, they can't get to you here. You are safe behind a wall of thorns.");
            //    });

            //    _events ~= timeEvent(eventStartTime + 7,
            //    {
            //        _remembered["stuck"] = false;
            //    });
            //}),

            //timeEvent(minute * 23,
            //{
            //    _remembered["stuck"] = true;
            //    _events ~= timeEvent(eventStartTime,
            //    {
            //        addThought("You are taking big strides forwards trying to reach the top as fast as possible, you fall. You can hear a voice behind you, ‘slow down, baby steps climb the mountain’");
            //    });

            //    _events ~= timeEvent(eventStartTime + 7,
            //    {
            //        _remembered["stuck"] = false;
            //    });
            //}),

            //timeEvent(minute * 25,
            //{
            //    _remembered["stuck"] = true;
            //    _thoughts = null;
            //    _events ~= timeEvent(eventStartTime,
            //    {
            //        addThought("The screams are everywhere, you start running. You decide to flee as far away as you can, never looking back. No matter for how long you are gone, you are never going back.");
            //    });

            //    _events ~= timeEvent(eventStartTime + 12,
            //    {
            //        _remembered["blank"] = true;
            //    });
            //    _events ~= timeEvent(eventStartTime + 16,
            //    {
            //        Game.running = false;
            //    });
            //}),


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
            stopQuesting();
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
            if(input.pressed)
            {
                //>>Special code for exiting
                if(!_crafting && !questing && input.key == SK.escape)
                {
                    _menu = !menu;
                    _selectedMenuMenu = 0;
                    continue;
                }
                //<<

                if(hasRemembered("stuck"))
                {
                    return;
                }

                if(_menu)
                {
                    if(input.key == SK.up || input.key == SK.down)
                    {
                        _selectedMenuMenu = !_selectedMenuMenu;
                    }

                    if(input.key == SK.enter || input.key == SK.space)
                    {
                        if(!_selectedMenuMenu)
                        {
                            _menu = false;
                            _selectedMenuMenu = false;
                        }
                        else
                        {
                            Game.running = false;
                            Game.forceQuit = true;
                        }
                    }

                }
                else if(questing)
                {
                    if(input.key == SK.escape)
                    {
                        stopQuesting();
                    }

                    if(input.key == SK.right)
                    {
                        _selectedQuestMenu = (_selectedQuestMenu + 1) % 3;
                    }

                    if(input.key == SK.left)
                    {
                        _selectedQuestMenu = (_selectedQuestMenu + 3 - 1) % 3;
                    }

                    if(input.key == SK.enter || input.key == SK.space)
                    {
                        switch(_selectedQuestMenu)
                        {
                            case 0:
                            addThought(_currentQuest.talk(), '"');
                            break;
                            case 1:
                            if(_currentQuest.quests.length)
                            {
                                addThought('"' ~ _currentQuest.quest() ~ '"');
                            }
                            break;
                            case 2:
                            stopQuesting();
                            break;
                            default:
                            break;
                        }
                    }
                }
                else if(_crafting)
                {
                    if(input.key == SK.escape || input.key == SK.c)
                    {
                        _crafting = false;
                    }

                    if(input.key == SK.up)
                    {
                        _selectedCraftItem = (_selectedCraftItem + CraftList.length - 1) % CraftList.length;
                    }

                    if(input.key == SK.down)
                    {
                        _selectedCraftItem = (_selectedCraftItem + 1) % CraftList.length;
                    }

                    if(input.key == SK.enter || input.key == SK.space)
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
                else
                {
                    if(input.key == SK.e)
                    {
                        if(Game.world.getTileAt(cast(int) _gx, cast(int) _gy).items.length)
                        {
                            if(_inventory.length < maxItems)
                            {
                                addItem(Game.world.getTileAt(cast(int) _gx, cast(int) _gy).grabItem());
                                updateInventory();
                            }
                            else
                            {
                                addThought("I can't carry more.");
                            }
                        }

                        //>>Special code for berries
                        else if(typeid(Game.world.getTileAt(cast(int) _gx, cast(int) _gy)) == typeid(TileBerry))
                        {
                            Game.world.getTileAt(cast(int) _gx, cast(int) _gy).interact(this);
                        }
                        //<<
                    }

                    if(input.key == SK.f)
                    {
                        if(!Game.world.getTileAt(cast(int) _gx, cast(int) _gy).interact(this))
                        {
                            int nx = cast(int) _gx, ny = cast(int) _gy;
                            if(_lookingDirection == Direction.up)
                            {
                                --ny;
                            }
                            if(_lookingDirection == Direction.down)
                            {
                                ++ny;
                            }
                            if(_lookingDirection == Direction.left)
                            {
                                --nx;
                            }
                            if(_lookingDirection == Direction.right)
                            {
                                ++nx;
                            }

                            if(withinWorldBorder(nx, ny))
                            {
                                if(Game.world.getEntityAt(nx, ny) !is null && typeid(Game.world.getEntityAt(nx, ny)).base == typeid(EntityAnimal))
                                {
                                    (cast(EntityAnimal)Game.world.getEntityAt(nx, ny)).interact(this);
                                }
                                else
                                {
                                    Game.world.getTileAt(nx, ny).interact(this);
                                }
                            }
                        }
                    }

                    if(input.key == SK.c)
                    {
                        remember("crafting");
                        _crafting = !crafting;
                    }

                    if(inventory.length)
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
                            _inventory[_selectedListItem].inspect(this, true);
                        }
                        else if(input.key == SK.q)
                        {

                            if(!Game.world.getTileAt(cast(int) _gx + (_lookingDirection == Direction.right ? 1 : 0) +(_lookingDirection == Direction.left ? -1 : 0),
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
                }
            }

            if(hasRemembered("stuck"))
            {
                return;
            }

            if(!_crafting && !questing && !_menu)
            {
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
            }
        }

        foreach(ref e; _events)
        {
            e.check();
        }

        for(int i = 0; i < _events.length; ++i)
        {
            if(_events.length && _events[i].completed)
            {
                _events = _events.remove(i);
                i -= 1;
            }
        }

        super.update();
    }

    void addThought(string s)
    {
        if(s != "")
        {
            addThought([s]);
        }
    }

    private int lastThoughtN = 0;
    void addThought(string[] thoughts, char surround = 0)
    {
        int n = min(random(thoughts.length), random(thoughts.length));

        if(lastThoughtN == n && thoughts.length > 1)
        {
            n = (n + 1) % thoughts.length;
        }

        if(thoughts[n] != "")
        {
            lastThoughtN = n;

            if(surround != 0)
            {
                _thoughts = split((surround ~ thoughts[n] ~ surround).wrap(wSidebar - 4), '\n') ~ _thoughts;
            }
            else
            {
                _thoughts = split(thoughts[n].wrap(wSidebar - 4), '\n') ~ _thoughts;
            }
        }
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

    void addItem(Item item, bool insp = true)
    {
        if(!inventoryFull)
        {
            if(insp)
            {
                item.inspect(this);
                item.picked = true;
            }

            if((typeid(item) in _counter) is null)
            {
                _counter[typeid(item)] = 1;
            }
            else
            {
                _counter[typeid(item)] += 1;
            }

            _inventory ~= item;
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

    void removeItem(TypeInfo_Class itemType)
    {
        foreach(n, item; _inventory)
        {
            if(typeid(item) == itemType)
            {
                _inventory = _inventory.remove(n);
                updateInventory();
                return;
            }
        }
    }

    void stopQuesting()
    {
        _currentQuest = null;
        _movingDirection = Direction.none;
        _selectedQuestMenu = 0;
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

    void setQuest(Quest q)
    {
        if(!questing)
        {
            _crafting = false;
            _currentQuest = q;
        }
    }

    Quest currentQuest() @property
    {
        return _currentQuest;
    }

    bool questing() const @property
    {
        return _currentQuest !is null;
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

    uint selectedQuestMenu() @property const
    {
        return _selectedQuestMenu;
    }

    bool selectedMenuMenu() const @property
    {
        return _selectedMenuMenu;
    }

    bool menu() const @property
    {
        return _menu;
    }

    private float _distanceMoved = 0;
    private float _warmth = 6;
    private string[] _thoughts;
    private bool[string] _remembered;
    private int[TypeInfo_Class] _counter;
    private Personality _personality;
    private Item[] _inventory;
    /*private*/ Event[] _events;
    private bool _running, _firstMove, _crafting, _menu;

    private Quest _currentQuest;

    private uint _memory = 0;
    private uint _selectedListItem = 0;
    private uint _selectedCraftItem = 0;
    private uint _selectedQuestMenu = 0;
    private bool _selectedMenuMenu = false;

    immutable int maxItems = 14;
}
