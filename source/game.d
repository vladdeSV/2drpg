import world;
import entity_player;

import std.random : Random;

struct Game
{
    static real ticks = 0;
    static bool running;

    static World world;
    static EntityPlayer player;

    static Random gen;
    static int seed;
}
