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
            super('Y', Color.red_dark, Color.green_dark);
        }
        else if(type == TreeType.dedwood)
        {
            super('I', Color.red_dark, Color.green_dark);
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
