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

enum TileType
{
    none,
    grass,
    rock,
    berry,
    sand,
    tree,
    water,
}

//enum ItemType
//{
//    beartreat,
//    bed,
//    berrystick,
//    berry,
//    bettertool,
//    cornerstone,
//    fiber,
//    firepit,
//    fishingpole,
//    grass,
//    great,
//    greatwood,
//    house,
//    iron,
//    multitool,
//    seasalad,
//    seaweed,
//    statue,
//    stone,
//    stool,
//    supremeblock,
//    supremetool,
//    sweetsalad,
//    wood,
//}

import craft_part;
import item_grass;
enum CraftList : CraftPart
{
    fiber = CraftPart(typeid(ItemGrass), 2)/*, CraftPart(typeid(ItemBerry), 1)]*/
}
