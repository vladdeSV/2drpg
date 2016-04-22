public import scone.color;

enum UPS = 60;

enum worldSize = 4;
enum chunkSize = 100;

int wView;
int hView;
int wSidebar;

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
Craft[] CraftList =
[
    //Craft("Stone rock", typeid(ItemStone), [CraftPart(typeid(ItemGrass), 2)]),
    Craft("String of grass",  typeid(ItemFiber),       [CraftPart(typeid(ItemGrass),   8)]),

    Craft("Stock",            typeid(ItemGreatWood),   [CraftPart(typeid(ItemWood),    8)]),

    Craft("Big rock",         typeid(ItemCornerStone), [CraftPart(typeid(ItemStone),   8)]),

    Craft("Seaweed grabber",  typeid(ItemFishingPole), [CraftPart(typeid(ItemWood),    2),
                                                        CraftPart(typeid(ItemStone),   1),
                                                        CraftPart(typeid(ItemFiber),   2)]),

    Craft("Green food",       typeid(ItemSeaSalad),    [CraftPart(typeid(ItemSeaWeed), 3)]),

    Craft("Other color food", typeid(ItemSweetSalad),  [CraftPart(typeid(ItemSeaWeed), 3),
                                                        CraftPart(typeid(ItemBerry),   3)]),

    Craft("Friend food",      typeid(ItemBearTreat),   [CraftPart(typeid(ItemBerry),   8)]),

    Craft("Seaweed grabber",  typeid(ItemFishingPole), [CraftPart(typeid(ItemWood),    2),
                                                        CraftPart(typeid(ItemStone),   1),
                                                        CraftPart(typeid(ItemFiber),   2)]),

];


