import enums;
import names;
import std.random;
import std.traits;

class Entity
{
    this(int x, int y, char sprite)
    {
        m_x = x;
        m_y = y;
        m_sprite = sprite;

        foreach(a; [EnumMembers!Attributes])
        {
            if((a in m_stats) is null)
            {
                m_stats[a] = 0;
            }
        }
    }

    ///Returns: int[y, x]
    auto position() const @property
    {
        return [m_y, m_x];
    }

    auto sprite() const @property
    {
        return m_sprite;
    }

private:
    int m_x, m_y;
    char m_sprite;
    int[Attributes] m_stats;
}
