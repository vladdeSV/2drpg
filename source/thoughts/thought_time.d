import game;
import thought;
import misc : secondsFromTicks;

class ThoughtTime : Thought
{
    this(int secondsSinceInit, string thought, void delegate() event = null)
    {
        _seconds = secondsSinceInit + secondsFromTicks(Game.ticks);
        super(thought, event);
    }

    override bool finalCheck()
    {
        return secondsFromTicks(Game.ticks) >= _seconds;
    }

    private int _seconds;
}
