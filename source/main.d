import scone;

enum updateInterval = 1000/30;

class Varaibles
{
package static:
    Game game;
    World world;

    bool running;
}

class Game
{
    void start()
    {
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

        ticks += durationmsec;
        int updates = to!int(ticks / updateInterval);
        ticks = ticks - updates * updateInterval;
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
