import game;
import misc;

import event_time;
import event_distance;

class Event
{
    this(void delegate() event)
    {
        _event = event;
    }

    void check()
    {
        if(!_completed && finalCheck())
        {
            _event();
            _completed = true;
        }
    }

    bool completed() @property
    {
        return _completed;
    }

    bool finalCheck()
    {
        return true;
    }

    bool disabled = false;

    private bool _completed = false;
    private void delegate() _event;
}

auto createEvent(void delegate() event)
{
    return new Event(event);
}
