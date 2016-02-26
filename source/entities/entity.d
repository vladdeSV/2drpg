import enums;
import names;
import enums;

import std.random;

abstract class Entity
{
    this(int x, int y, char sprite, Color color)
    {
        m_x = x;
        m_y = y;
        m_sprite = sprite;
        m_color = color;

        m_lookingDirection = cast(Direction) uniform(1, 5);
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

    Direction m_lookingDirection;
}
