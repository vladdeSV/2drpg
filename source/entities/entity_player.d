import entity_living;
import slump;
import enums;
import item;
import std.string : wrap, split;
import std.algorithm : min;


class EntityPlayer : EntityLiving
{
    this(int x, int y)
    {
        super(/*ListName[random($)]*/ "Hermando" , x, y, char(1), Color.yellow);
    }

    void addThought(string s)
    {
        addThought([s]);
    }

    int lastThoughtN = 0;
    void addThought(string[] thoughts)
    {
        int n = min(random(thoughts.length), random(thoughts.length));

        while(lastThoughtN == n && thoughts.length > 1)
        {
            n = min(random(thoughts.length), random(thoughts.length));
        }

        lastThoughtN = n;

        _thoughts ~= split(thoughts[n].wrap(wSidebar - 2), '\n') ~ _thoughts;
    }

    void remember(string s)
    {
        _remembered[s] = true;
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

    auto thoughts()
    {
        return _thoughts;
    }

    bool inventoryFull() const @property
    {
        return _inventory.length < maxItems;
    }

    float distanceMoved() const @property
    {
        return _distanceMoved;
    }

    float warmth() const @property
    {
        return _warmth;
    }

    private float _distanceMoved = 0;
    private float _warmth = 6;
    private string[] _thoughts;
    private bool[string] _remembered;
    private Personality _personality;
    private Item[] _inventory;

    private const int maxItems = 10;
}
