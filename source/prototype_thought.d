import game;
import std.array : split;
import std.string : wrap;
import misc;

struct MessageThought
{
    this(string thought)
    {
        lines = split(thought.wrap(28), '\n');
    }

    string[] lines;
}

abstract class Thought
{
    final bool check()
    {
        if(_completed)
        {
            return false;
        }
        else if(aaa())
        {
            return _completed = true;
        }
        else
        {
            return false;
        }
    }

    final string thought() @property
    {
        return _thought;
    }

    private bool _completed = false;
    protected string _thought;

    bool aaa();
}

class ThoughtDistance : Thought
{
    this(float afterDistance, string thought)
    {
        _distance = afterDistance;
        _thought = thought;
    }

    override bool aaa()
    {
        return Game.world.player.distanceMoved >= _distance;
    }

    private float _distance;
}

class ThoughtTime : Thought
{
    this(int secondsAfterStart, string thought)
    {
        _seconds = secondsAfterStart;
        _thought = thought;
    }

    override bool aaa()
    {
        return secondsFromTicks(Game.ticks) >= _seconds;
    }

    private int _seconds;
}

//Thought[] thoughts =
//[
//    new ThoughtDistance(10, "Where am I?"),
//    new ThoughtDistance(30, "...")
//]

//foreach(h; handlers)
//{
//    if (distance == h.getDistance())
//    {
//        h.doSomething();
//        handlers.remove(h);
//        break;
//    }
//}
