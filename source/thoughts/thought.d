import game;
import misc;

import thought_time;
import thought_distance;

abstract class Thought
{
    this(string thought, void delegate() event)
    {
        _thought = thought;
        _event = event;
    }

    bool check()
    {
        if(!_completed && finalCheck())
        {
            if(_event !is null)
            {
                _event();
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
        return _completed && !_disabled;
    }

    void disable()
    {
        _disabled = true;
    }

    bool finalCheck();

    private string _thought;
    private bool _completed = false;
    private bool _disabled = false;
    private void delegate() _event;
}

//gö en array av events, varpå du ändast läseer av id:S från gdrive.
