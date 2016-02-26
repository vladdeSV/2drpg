import scone;
import world;
import enums;
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
                //DEBUG: delte this
                m_world.m_entities[0].update;
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

            if(input.pressed)
            {
                if(input.key == SK.UP)
                {
                    m_world.m_entities[1].m_y -= 1;
                }
                else if(input.key == SK.DOWN)
                {
                    m_world.m_entities[1].m_y += 1;
                }
                else if(input.key == SK.RIGHT)
                {
                    m_world.m_entities[1].m_x += 1;
                }
                else if(input.key == SK.LEFT)
                {
                    m_world.m_entities[1].m_x -= 1;
                }
            }
        }
    }

    void render()
    {
        m_frame.clear();

        //foreach(int sy, ref row; m_world.m_tiles)
        //{
        //    foreach(int sx, ref tile; row)
        //    {
        //        m_frame.write(sx,sy, tile.color, tile.backgroundColor, tile.sprite);
        //    }
        //}

        foreach(entity; m_world.m_entities)
        {
            m_frame.write(entity.position[0], entity.position[1], cast(fg) entity.color, entity.sprite);
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
    private double msecs = 0;
    double getUpdates()
    {
        /* Kudos to Yepoleb who helped me with this */
        MonoTime newtime = MonoTime.currTime();
        Duration duration = newtime - lasttime;
        double durationmsec = duration.total!"nsecs" / (10.0 ^^ 6);

        lasttime = newtime;
        msecs += durationmsec;
        int updates = cast(int)(msecs / updateInterval);
        msecs -= updates * updateInterval;

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
    getGame.start();
}
