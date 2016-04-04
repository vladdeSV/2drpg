import tile;
import enums;
import game;

import std.random;

class TileTree : Tile
{
    this(TreeType type)
    {
        if(type == TreeType.redwood)
        {
            super(TileType.tree, 'Y', Color.red_dark, Color.green_dark, true);
        }
        else if(type == TreeType.dedwood)
        {
            super(TileType.tree, 'I', Color.red_dark, Color.green_dark, true);
        }
        else
        {
            super();
        }
    }
}

enum TreeType
{
    //oak,
    redwood,
    //fir,
    dedwood,
}
