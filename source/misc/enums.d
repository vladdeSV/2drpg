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

enum ItemType
{
    consumable,
    misc,
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
