module game;

import scone;
import world;
import enums;
import item;
import std.stdio;
import std.conv : to;
import core.time;

static Game getGame() @property
{
    return Game.instance;
}

class Game
{
    void start()
    {
        sconeInit();

        m_running = true;
        m_frame = new Frame;
        m_world = new World;

        resetUpdates();
        while(m_running)
        {
            foreach(i; 0 .. getUpdates())
            {
                tick();
            }
            render();
        }

        sconeClose();
    }

    void tick()
    {
        foreach(input; getInputs())
        {
            if(input.key == SK.ESCAPE)
            {
                m_running = false;
            }
        }
    }

    void render()
    {
        foreach(int sy, ref row; m_world.m_tiles)
        {
            foreach(int sx, ref tile; row)
            {
                m_frame.write(sx,sy, /*tile.foreground, tile.background,*/ tile.sprite);
            }
        }

        m_frame.print();
    }

    //>>Singleton
    //David Simcha
    static Game instance() @property
    {
        if (!instantiated_)
        {
            synchronized
            {
                if (instance_ is null)
                {
                  instance_ = new Game;
                }
                instantiated_ = true;
            }
        }
        return instance_;
    }

    private this() {}
    private static bool instantiated_;  // Thread local
    private __gshared Game instance_;
    //<<

    //>> Ticking mechanisms
    private MonoTime lasttime;
    private double ticks = 0;
    double getUpdates()
    {
        /* Kudos to Yepoleb who helped me with this */
        MonoTime newtime = MonoTime.currTime();
        Duration duration = newtime - lasttime;
        double durationmsec = duration.total!"nsecs" / (10.0 ^^ 6);

        lasttime = newtime;
        ticks += durationmsec;
        int updates = cast(int)(ticks / updateInterval);
        ticks -= updates * updateInterval;

        return updates;
    }
    void resetUpdates()
    {
        lasttime = MonoTime.currTime();
    }
    //<<
//private:
    bool m_running;

    Frame m_frame;
    World m_world;
}

void main()
{
    import std.stdio;
    writeln(getGame.m_running);
}
