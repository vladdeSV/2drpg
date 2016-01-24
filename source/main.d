import scone;
import world;
import std.conv : to;
import core.time;

enum : int
{
    updateInterval = 1000/30
}

class DRPG
{
static:
    Game game;
    World world;
}

class Game
{
    bool running;
    int ticks;

    void start()
    {
        ////>> Test
        //Entity e = new Entity();
        //e.addAttribute!AttributeHealth;
        ////<<
        running = true;

        resetUpdates();
        while(running)
        {
            foreach(i; 0 .. getUpdates())
            {
                tick();
            }

            render();
        }
    }

    void tick()
    {

    }

    void render()
    {

    }

    //>> Ticking mechanisms
    private MonoTime lasttime;

    double getUpdates()
    {
        /* Kudos to Yepoleb who helped me with this */
        MonoTime newtime = MonoTime.currTime();
        Duration duration = newtime - lasttime;
        double durationmsec = duration.total!"nsecs" / (10.0 ^^ 6);
        lasttime = newtime;

        ticks += to!int(durationmsec);
        int updates = to!int(ticks / updateInterval);
        ticks -= updates * updateInterval;

        return updates;
    }

    void resetUpdates()
    {
        lasttime = MonoTime.currTime();
    }
    //<<
}

void main()
{

}
