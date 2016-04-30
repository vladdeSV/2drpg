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

    string[] talk()
    {
        return _textTalk[];
    }

    string[] quest()
    {
        if(!_completed && _quest())
        {
            _completed = true;
        }

        if(_completed)
        {
            return _textQuestCompleted[];
        }
        else
        {
            return _textQuest[];
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
