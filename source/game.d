import scone;
import world;
import std.random;

struct Game
{
    static bool running;
    static Frame frame;
    static World world;

    static int seed;
    static Random gen;
}
