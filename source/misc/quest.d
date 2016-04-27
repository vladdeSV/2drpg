import slump;
import entity_living;

class Quest
{
    this
    (
        string[] textTalk,
        string[] textQuest,
        string[] textQuestCompleted,
        bool delegate() quest,
        EntityLiving sender
    )
    {
        _textTalk = textTalk;
        _textQuest = textQuest;
        _textQuestCompleted = textQuestCompleted;
        _quest = quest;
        _sender = sender;
    }

    string talk()
    {
        return _textTalk[random($)];
    }

    string quest()
    {
        if(!_completed && _quest())
        {
            _completed = true;
        }

        if(_completed)
        {
            return _textQuestCompleted[random($)];
        }
        else
        {
            return _textQuest[random($)];
        }
    }

    EntityLiving sender() @property
    {
        return _sender;
    }

    private bool delegate() _quest;
    private string[] _textTalk, _textQuest, _textQuestCompleted;
    private EntityLiving _sender;
    private bool _completed;
}
