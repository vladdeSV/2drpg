import entity;
import enums;
//import item;
import std.traits;

class EntityLiving : Entity
{
    this(int x, int y, char sprite, Color color, string name, int maxHealth/*, int[Attributes] stats*/)
    {
        super(x, y, sprite, color);
        _name = name;
        _maxHealth = _health = maxHealth;
        /*_stats = stats;
        foreach(a; [EnumMembers!Attributes])
        {
            if((a in _stats) is null)
            {
                _stats[a] = 0;
            }
        }*/
    }

    auto name() const @property
    {
        return _name;
    }

    auto health() const @property
    {
        return _health;
    }

    auto maxHealth() const @property
    {
        return _maxHealth;
    }

    /*auto stats() const @property
    {
        return _stats;
    }*/

    //Item[] items;

private:
    string _name;
    int _maxHealth, _health;
    //int[Attributes] _stats;
}
