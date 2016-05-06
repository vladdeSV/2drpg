import world;
import scone;
import entity_player;

import std.random : Random;

struct Game
{
    static real ticks = 0;
    static bool running;
    static bool forceQuit;

    static World world;
    static EntityPlayer player;
    static Frame frame;

    static Random gen;
    static int seed = 0;
}
