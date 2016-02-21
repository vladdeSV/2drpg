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
        //foreach(atr; [EnumMembers!Attributes])
        //{
        //    m_stats[atr] = 0;
        //}
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
    int[Attributes] m_stats;
}
