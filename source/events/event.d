import game;
import misc;

public import event_time;
public import event_distance;
public import event_check;

abstract class Event
{
    this(void delegate() event, int repeatDelay = 0)
    {
        _event = event;
        if(repeatDelay > 0)
        {
            _repeatDelay = repeatDelay;
        }
    }

    void check()
    {
        if(_repeatDelay > 0 && _completed && secondsFromTicks(Game.ticks) >= _timeUntilActive)
        {
            _completed = false;
            _timeUntilActive = _repeatDelay + secondsFromTicks(Game.ticks);
        }

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

    private int _timeUntilActive, _repeatDelay;
    private bool _completed = false;
    private void delegate() _event;
}
