import slump;
import entity;

class Quest
{
    this
    (
        string[] textTalk,
        string[] textQuest,
        string[] textQuestCompleted,
        bool delegate() quest,
        Entity sender
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
        if(!_completed && quest())
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

    /*private*/ bool delegate() _quest;
    /*private*/ string[] _textTalk, _textQuest, _textQuestCompleted;
    /*private*/ Entity _sender;
    /*private*/ bool _completed;
}
