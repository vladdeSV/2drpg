import slump;
import entity_living;

class Quest
{
    this(string[] textTalk, EntityLiving sender, QuestPart[] quests, string finished)
    {
        _talks = textTalk;
        _sender = sender;
        _quests = quests;
        _finished = finished;
    }

    string[] talk()
    {
        return _talks;
    }

    string quest()
    {
        if(!_quests.length)
        {
            return _finished;
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

    EntityLiving sender() @property
    {
        return _sender;
    }

    QuestPart[] quests() @property
    {
        return _quests;
    }

    private string[] _talks;
    private string _finished;
    private EntityLiving _sender;
    private QuestPart[] _quests;
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
