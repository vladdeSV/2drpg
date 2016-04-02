import game;
import std.array : split;
import std.string : wrap;
import enums : sidebarWidth;
import misc;

struct MessageThought
{


    this(string thought)
    {
        lines = split(thought.wrap(sidebarWidth - 2), '\n');
    }

    string[] lines;
}

void none()
{

}

abstract class Thought
{
    this(string thought, Thought t)
    {
        _thought = thought;
        _t = t;
    }

    bool check()
    {
        if(_completed)
        {
            return false;
        }
        else if(aaa())
        {
            if(_t !is null)
            {
                Game.world.player.thoughts ~= _t;
            }
            return _completed = true;
        }
        else
        {
            return false;
        }
    }

    string thought() @property
    {
        return _thought;
    }

    private bool _completed = false;
    private Thought _t;
    protected string _thought;

    bool aaa();
}

class ThoughtDistance : Thought
{
    this(float distanceSinceCurrentDistance, string thought, Thought t = null)
    {
        _distance = distanceSinceCurrentDistance + Game.world.player.distanceMoved;
        super(thought, t);
    }

    override bool aaa()
    {
        return Game.world.player.distanceMoved >= _distance;
    }

    private float _distance;
}

class ThoughtTime : Thought
{
    this(int secondsSinceInit, string thought, Thought t = null)
    {
        _seconds = secondsSinceInit + secondsFromTicks(Game.ticks);
        super(thought, t);
    }

    override bool aaa()
    {
        return secondsFromTicks(Game.ticks) >= _seconds;
    }

    private int _seconds;
}

ThoughtTime timeThought(int time, string thought, Thought t = null)
{
    return new ThoughtTime(time, thought, t);
}

ThoughtDistance distanceThought(float distance, string thought, Thought t = null)
{
    return new ThoughtDistance(distance, thought, t);
}
