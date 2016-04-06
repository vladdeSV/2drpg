import enums;
import event;

class EventCheck : Event
{
    this(bool delegate() check, void delegate() event, int repeatDelay = 0)
    {
        _check = check;
        super(event, repeatDelay);
    }

    override void check()
    {
        if(_check())
        {
            super.check();
        }
    }

    private bool delegate() _check;
}

auto checkEvent(bool delegate() check, void delegate() event, int repeatDelay = 0)
{
    return new EventCheck(check, event, repeatDelay);
}
