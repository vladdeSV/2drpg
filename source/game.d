import world;
import entity_player;

import std.random : Random;

struct Game
{
    static real ticks;
    static bool running;

    static World world;
    static EntityPlayer player;

    static Random gen;
    static int seed;
}
