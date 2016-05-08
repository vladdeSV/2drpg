public import scone.color;

enum UPS = 60;

enum worldSize = 2;
enum chunkSize = 100;

bool withinWorldBorder(float x, float y)
{
    return (x >= 0 && x < chunkSize * worldSize && y >= 0 && y < chunkSize * worldSize);
}

int wView;
int hView;
int wSidebar;
int xoffset;
int yoffset;

enum Direction
{
    none  = 0,
    up    = 1,
    down  = 2,
    left  = 4,
    right = 8,
}

enum Personality
{
    aggressive,
    calm,
    neutral,
}

import craft_part;
import item_grass;
import item_berry;
import item_fiber;
import item_stone;
import item_wood;
import item_greatwood;
import item_fishingpole;
import item_seasalad;
import item_seaweed;
import item_sweetsalad;
import item_beartreat;
import item_cornerstone;
import item_axe;
import item_niceaxe;
import item_maxe;
import item_iron;
import item_berrystick;
import item_supremeblock;

Craft[] CraftList =
[
    Craft("Axe",              typeid(ItemAxe),         [CraftPart(typeid(ItemWood),   2),
                                                        CraftPart(typeid(ItemStone),       3)]),

    Craft("Bear Treat",       typeid(ItemBearTreat),   [CraftPart(typeid(ItemBerry),       8)]),

    //Craft("Firepit", typeid(Item), [CraftPart(typeid(), )]),

    Craft("Great wood",       typeid(ItemGreatWood),   [CraftPart(typeid(ItemWood),        8)]),

    Craft("Corner stone",     typeid(ItemCornerstone), [CraftPart(typeid(ItemStone),       8)]),

    Craft("Fiber",            typeid(ItemFiber),       [CraftPart(typeid(ItemGrass),       8)]),

    Craft("Fishing Pole",     typeid(ItemFishingPole), [CraftPart(typeid(ItemWood),        2),
                                                        CraftPart(typeid(ItemStone),       1),
                                                        CraftPart(typeid(ItemFiber),       2)]),

    //Craft("House", typeid(Item), [CraftPart(typeid(), )]),

    Craft("Sea Salad",        typeid(ItemSeaSalad),    [CraftPart(typeid(ItemSeaWeed),     3)]),

    Craft("Sweet Salad",      typeid(ItemSweetSalad),  [CraftPart(typeid(ItemSeaWeed),     3),
                                                        CraftPart(typeid(ItemBerry),       3)]),

    Craft("Berry Stick",      typeid(ItemBerryStick),  [CraftPart(typeid(ItemBerry),       1),
                                                        CraftPart(typeid(ItemWood),        1)]),

    Craft("Nice Axe",         typeid(ItemNiceAxe),     [CraftPart(typeid(ItemAxe),         1),
                                                        CraftPart(typeid(ItemGreatWood),   2),
                                                        CraftPart(typeid(ItemCornerstone), 3)]),

    Craft("MAXe",             typeid(ItemMaxe),        [CraftPart(typeid(ItemNiceAxe),     1),
                                                        CraftPart(typeid(ItemIron),        3),
                                                        CraftPart(typeid(ItemCornerstone), 7)]),
];


