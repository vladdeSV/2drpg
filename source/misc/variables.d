module variables;

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
import item_house;
import item_fireplace;

Craft[] CraftList =
[
    Craft(typeid(ItemAxe),         [CraftPart(typeid(ItemWood),        2),
                                    CraftPart(typeid(ItemStone),       3)]),

    Craft(typeid(ItemBearTreat),   [CraftPart(typeid(ItemBerry),       3)]),

    Craft(typeid(ItemGreatWood),   [CraftPart(typeid(ItemWood),        4)]),

    Craft(typeid(ItemCornerstone), [CraftPart(typeid(ItemStone),       3)]),

    Craft(typeid(ItemFiber),       [CraftPart(typeid(ItemGrass),       4)]),

    Craft(typeid(ItemFishingPole), [CraftPart(typeid(ItemWood),        2),
                                    CraftPart(typeid(ItemStone),       1),
                                    CraftPart(typeid(ItemFiber),       2)]),

    Craft(typeid(ItemSeaSalad),    [CraftPart(typeid(ItemSeaWeed),     3)]),

    Craft(typeid(ItemSweetSalad),  [CraftPart(typeid(ItemSeaWeed),     3),
                                    CraftPart(typeid(ItemBerry),       3)]),

    Craft(typeid(ItemBerryStick),  [CraftPart(typeid(ItemBerry),       1),
                                    CraftPart(typeid(ItemWood),        1)]),

    Craft(typeid(ItemFireplace),   [CraftPart(typeid(ItemStone),       5),
                                    CraftPart(typeid(ItemGrass),       2),
                                    CraftPart(typeid(ItemWood),        1),
                                    CraftPart(typeid(ItemIron),        1)]),

    Craft(typeid(ItemNiceAxe),     [CraftPart(typeid(ItemAxe),         1),
                                    CraftPart(typeid(ItemGreatWood),   2),
                                    CraftPart(typeid(ItemCornerstone), 3)]),

    Craft(typeid(ItemMaxe),        [CraftPart(typeid(ItemNiceAxe),     1),
                                    CraftPart(typeid(ItemIron),        3),
                                    CraftPart(typeid(ItemCornerstone), 2)]),

    Craft(typeid(ItemHouse),       [CraftPart(typeid(ItemGreatWood),   3),
                                    CraftPart(typeid(ItemCornerstone), 2),
                                    CraftPart(typeid(ItemFireplace),   1),
                                    CraftPart(typeid(ItemFiber),       1)]),
];

int wView;
int hView;
int wSidebar;
int xoffset;
int yoffset;

string[] gamename =
[
    " .d8888b. 8888888b. 8888888b. 8888888b.  .d8888b. ",
    "d88P  Y88b888  'Y88b888   Y88b888   Y88bd88P  Y88b",
    "       888888    888888    888888    888888    888",
    "     .d88P888    888888   d88P888   d88P888       ",
    " .od888P' 888    8888888888P' 8888888P' 888  88888",
    "d88P'     888    888888 T88b  888       888    888",
    "888'      888  .d88P888  T88b 888       Y88b  d88P",
    "888888888 8888888P' 888   T88b888        'Y8888P88",
    "",
    "LBS Game Awards 2016",
];
