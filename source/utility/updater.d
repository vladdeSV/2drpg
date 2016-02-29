import std.conv : to;
import core.time;

struct Updater
{
    @disable this();
    @disable this(this);

    this(double interval)
    {
        m_interval = interval;
    }

    double getUpdates()
    {
        /* Kudos to Yepoleb who helped me with this */
        MonoTime newtime = MonoTime.currTime();
        Duration duration = newtime - m_lasttime;
        double durationmsec = duration.total!"nsecs" / (10.0 ^^ 6);

        m_lasttime = newtime;
        m_msecs += durationmsec;
        int updates = cast(int)(m_msecs / m_interval);
        m_msecs -= updates * m_interval;

        return updates;
    }

    void resetUpdates()
    {
        m_lasttime = MonoTime.currTime();
    }

    private MonoTime m_lasttime;
    private double m_msecs = 0;
    private double m_interval;
}
