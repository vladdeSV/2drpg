import entity;

import enums;

class EntityLiving : Entity
{
    this(int x, int y, char sprite, string name, int[Attributes] stats)
    {
        super(x, y, sprite);
        m_name = name;
        m_stats = stats;
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
    int[Attributes] m_stats;
}
