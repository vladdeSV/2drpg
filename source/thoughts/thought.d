import game;
import misc;

abstract class Thought
{
    this(string thought, void delegate() special)
    {
        _thought = thought;
        _special = special;
    }

    bool check()
    {
        if(!_completed && finalCheck())
        {
            if(_special !is null)
            {
                _special();
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

    bool completed() @property
    {
        return _completed;
    }

    bool finalCheck();

    private string _thought;
    private bool _completed = false;
    private void delegate() _special;
}
