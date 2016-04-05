import game;
import event;
import misc : secondsFromTicks;

class EventTime : Event
{
    this(int secondsSinceInit, void delegate() event)
    {
        _seconds = secondsSinceInit + secondsFromTicks(Game.ticks);
        super(event);
    }

    override bool finalCheck()
    {
        return secondsFromTicks(Game.ticks) >= _seconds;
    }

    private int _seconds;
}

auto timeEvent(int time, void delegate() del = null)
{
    return new EventTime(time, del);
}

