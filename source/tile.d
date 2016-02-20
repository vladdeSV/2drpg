module tile;

import scone;
import enums;

class Tile
{
    this(char sprite, bool solid = false, fg color = fg.init, bg background = bg.init)
    {
        m_sprite = sprite;
        m_solid = solid;
        m_color = color;
        m_background = background;
    }

    auto sprite() const @property
    {
        return m_sprite;
    }

    auto solid() const @property
    {
        return m_solid;
    }

    auto color() const @property
    {
        return m_color;
    }

    auto background() const @property
    {
        return m_background;
    }

private:
    char m_sprite;
    bool m_solid;
    fg m_color;
    bg m_background;
}
