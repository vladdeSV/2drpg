import std.conv : to;
import core.time;

struct Updater
{
    @disable this();
    @disable this(this);

    this(double interval)
    {
        _interval = interval;
    }

    double getUpdates()
    {
        /* Kudos to Yepoleb who helped me with this */
        MonoTime newtime = MonoTime.currTime();
        Duration duration = newtime - _lasttime;
        double durationmsec = duration.total!"nsecs" / (10.0 ^^ 6);

        _lasttime = newtime;
        _msecs += durationmsec;
        int updates = cast(int)(_msecs / _interval);
        _msecs -= updates * _interval;

        return updates;
    }

    void resetUpdates()
    {
        _lasttime = MonoTime.currTime();
    }

    private MonoTime _lasttime;
    private double _msecs = 0;
    private double _interval;
}
