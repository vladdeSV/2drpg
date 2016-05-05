import slump;
import entity_living;

class Quest
{
    this(string[] textTalk, string textFinished, EntityLiving sender, QuestPart[] quests)
    {
        _talks = textTalk;
        _finishedTalk = textFinished;
        _sender = sender;
        _quests = quests;
    }

    string[] talk()
    {
        return _talks;
    }

    string quest()
    {
        if(!_quests.length)
        {
            return _finishedTalk;
        }

        if(!_quests[0].started)
        {
            _quests[0].started = true;
            return _quests[0].texts[0];
        }

        if(!_quests[0].check())
        {
            return _quests[0].texts[1];
        }
        else
        {
            scope(exit)
            {
                _quests = _quests[1 .. $];
            }

            _quests[0].action();
            return _quests[0].texts[2];
        }
    }

    bool active() const @property
    {
        return _quests.length && _quests[0].started;
    }

    EntityLiving sender() @property
    {
        return _sender;
    }

    QuestPart[] quests() @property
    {
        return _quests;
    }

    private string[] _talks;
    private string _finishedTalk;
    private EntityLiving _sender;
    private QuestPart[] _quests;

    private bool _completed;
}

struct QuestPart
{
    this(string[3] txts, bool delegate() chk, void delegate() actn)
    {
        texts = txts;
        check = chk;
        action = actn;
    }

    string[3] texts;
    bool delegate() check;
    void delegate() action;

    bool started;
}
