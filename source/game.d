import scone;
import world;
import std.random;

struct Game
{
    static bool running;
    static Frame frame;
    static World world;

    static real ticks = 0;

    static int seed = 5;
    static Random gen;
}
