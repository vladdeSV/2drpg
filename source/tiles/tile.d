import enums;

class Tile
{
    this(char sprite, Color color, Color backgroundColor, bool solid = false)
    {
        m_sprite = sprite;
        m_solid = solid;
        m_color = color;
        m_backgroundColor = backgroundColor;
    }

    auto sprite() const @property
    {
        return m_sprite;
    }

    auto solid() const @property
    {
        return m_solid;
    }

    Color color() const @property
    {
        return m_color;
    }

    Color backgroundColor() const @property
    {
        return m_backgroundColor;
    }

private:
    char m_sprite;
    bool m_solid;
    Color m_color, m_backgroundColor;
}
