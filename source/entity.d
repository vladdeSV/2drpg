module entity;

import enums;
import list.name;
import std.random;
import std.traits;

class Entity
{
    this(int x, int y, string name, int[Attributes] stats)
    {
        m_x = x;
        m_y = y;
        m_name = name;
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

    auto attributes() const @property
    {
        return m_stats;
    }

    ///Returns: int[y, x]
    auto position() const @property
    {
        return [m_y, m_x];
    }

private:
    int m_x, m_y;
    string m_name;
    bool m_living;
    int[Attributes] m_stats;
}
