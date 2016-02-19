module tile;
import scone;

class Tile
{
    char sprite = '?';
    bool solid = false;
    fg color = fg.init;
    bg background = bg.init;

    this(char sprite, fg color = fg.init, bg background = bg.init)
    {
        this.sprite = sprite;
        this.color = color;
        this.background = background;
    }
}
