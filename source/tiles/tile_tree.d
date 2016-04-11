import tile;
import enums;
import game;

import std.random;

class TileTree : Tile
{
    this(float val)
    {
        if(val - 4 < 3)
        {
            super(TileType.tree, 'Y', Color.red_dark, Color.green_dark, true);
        }
        else
        {
            super(TileType.tree, 'I', Color.red_dark, Color.green_dark, true);
        }
    }
}
