module game;

import scone;
import world;
import enums;
import std.stdio;
import std.conv : to;
import core.time;

alias game = Game.game;

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
        foreach(sy, ref row; m_world.m_tiles)
        {
            foreach(sx, ref slot; row)
            {
                m_frame.write(sx,sy, slot.color, slot.background, slot.sprite);
            }
        }

        m_frame.print();
    }

    //>>Singleton
    //David Simcha
    static Game game() @property
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
private:
    bool m_running;

    Frame m_frame;
    World m_world;
}

void main()
{
    game.start();
}
