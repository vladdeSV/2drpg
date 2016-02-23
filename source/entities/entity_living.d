import entity;
import enums;
import std.traits;

class EntityLiving : Entity
{
    this(int x, int y, char sprite, string name, Color color, int maxHealth, int[Attributes] stats)
    {
        super(x, y, sprite, color);
        m_name = name;
        m_maxHealth = m_health = maxHealth;
        m_stats = stats;
        foreach(a; [EnumMembers!Attributes])
        {
            if((a in m_stats) is null)
            {
                m_stats[a] = 0;
            }
        }
    }

    auto name() const @property
    {
        return m_name;
    }

    auto stats() const @property
    {
        return m_stats;
    }

private:
    string m_name;
    int m_maxHealth, m_health;
    int[Attributes] m_stats;
}
