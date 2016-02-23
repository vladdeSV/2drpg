import enums;
import names;

abstract class Entity
{
    this(int x, int y, char sprite, Color color)
    {
        m_x = x;
        m_y = y;
        m_sprite = sprite;
        m_color = color;
    }

    void update() {}

    ///Returns: int[x, y]
    auto position() const @property
    {
        return [m_x, m_y];
    }

    auto sprite() const @property
    {
        return m_sprite;
    }

    Color color() const @property
    {
        return m_color;
    }

//private:
    int m_x, m_y;
    char m_sprite;
    Color m_color;
}
