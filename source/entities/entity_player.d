import entity_living;
import thought;
import enums;

class EntityPlayer : EntityLiving
{
    this(int x, int y)
    {
        super(ListName[random($)], x, y, char(1), Color.yellow);
    }

    void remember(string s)
    {
        _remembered[s] = true;
    }

    void addThought(Thought...)(Thought thoughts)
    {
        _thoughts ~= Thought[thoughts];
    }

    bool hasRemembered(string s)
    {
        if((s in _remembered) !is null)
        {
            return _remembered[s];
        }

        return false;
    }

    Personality personality() const @property
    {
        return _personality;
    }

    Thought[] thoughts() const @property
    {
        return _thoughts;
    }

    private Thought[] _thoughts;
    private bool[string] _remembered;
    private Personality _personality;
}
