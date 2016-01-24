import scone;
import world;
import entity.entity;

enum updateInterval = 1000/30;

class DRPG
{
static:
    Game game;
    World world;

    bool running;
    double ticks;
}

class Game
{
    void start()
    {
        Entity e = new Entity();
        e.addAttribute!AttributeHealth;

        DRPG.running = true;

        resetUpdates();
        while(DRPG.running)
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

        DRPG.ticks += durationmsec;
        int updates = to!int(DRPG.ticks / updateInterval);
        DRPG.ticks -= updates * updateInterval;

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
