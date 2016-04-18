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
Craft[] CraftList =
[
    Craft("String of grass", typeid(ItemFiber), [CraftPart(typeid(ItemGrass), 2), CraftPart(typeid(ItemStone), 1)]),
    Craft("Stone rock", typeid(ItemStone), [CraftPart(typeid(ItemGrass), 2)]),
    Craft("S U P E R  W O O D", typeid(ItemWood), [CraftPart(typeid(ItemWood), 8)]),
];
