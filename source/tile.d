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

    char sprite() const @property
    {
        return m_sprite;
    }

    char solid() const @property
    {
        return m_solid;
    }

    fg color() const @property
    {
        return m_color;
    }

    bg background() const @property
    {
        return m_background;
    }

private:
    TileType m_type;

    char m_sprite;
    bool m_solid;
    fg m_color;
    bg m_background;
}
