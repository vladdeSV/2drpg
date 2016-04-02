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
    this(string thought, void delegate() exec)
    {
        _thought = thought;
        _exec = exec;
    }

    bool check()
    {
        if(_completed)
        {
            return false;
        }
        else if(aaa())
        {
            if(_exec !is null)
            {
                _exec();
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
    private void delegate() _exec;
    protected string _thought;

    bool aaa();
}

class ThoughtDistance : Thought
{
    this(float afterDistance, string thought, void delegate() exec = null)
    {
        _distance = afterDistance;
        super(thought, exec);
    }

    override bool aaa()
    {
        return Game.world.player.distanceMoved >= _distance;
    }

    private float _distance;
}

class ThoughtTime : Thought
{
    this(int secondsSinceInit, string thought, void delegate() exec = null)
    {
        _seconds = secondsSinceInit + secondsFromTicks(Game.ticks);
        super(thought, exec);
    }

    override bool aaa()
    {
        return secondsFromTicks(Game.ticks) >= _seconds;
    }

    private int _seconds;
}
