import game;
import event;
import misc : secondsFromTicks;

class EventTime : Event
{
    this(int secondsSinceInit, void delegate() event, int delay)
    {
        _seconds = secondsSinceInit + secondsFromTicks(Game.ticks);
        super(event, delay);
    }

    override bool finalCheck()
    {
        return secondsFromTicks(Game.ticks) >= _seconds;
    }

    private int _seconds;
}

auto timeEvent(int time, void delegate() event = null, int delay = 0)
{
    return new EventTime(time, event, delay);
}

