import game;
import thought;
import misc : secondsFromTicks;

class ThoughtTime : Thought
{
    this(int secondsSinceInit, string thought, void delegate() special = null)
    {
        _seconds = secondsSinceInit + secondsFromTicks(Game.ticks);
        super(thought, special);
    }

    override bool finalCheck()
    {
        return secondsFromTicks(Game.ticks) >= _seconds;
    }

    private int _seconds;
}

//auto timeThoughts(Args...)(Args args) if (TTimeThought!Args)
//{
//    ThoughtTime[] tt;
//    int val;
//    string str;
//    foreach(n, arg; args)
//    {
//        if(n % 2 == 0)
//        {
//            val = arg;
//        }
//        else
//        {
//            str = arg;
//            tt ~ new ThoughtTime(time, thought);
//        }
//    }
//}

//bool TTimeThought(T...)()
//{
//    if (!(T.length % 2 == 0))
//    {
//        return false;
//    }

//    foreach(i, U; T)
//    {
//        if(!(i % 2 == 0 && is(U == int) || i % 2 == 1 && is(U == string)))
//        {
//            return false;
//        }
//    }

//    return true;
//}
