import tile;
import enums;
import game;
import slump;

import std.random;

class TileMountain : Tile
{
    this(float val)
    {
        if(val < 8.5)
        {
            super(coin() ? '.' : ' ', Color.white_dark, Color.black, true);
        }
        else if(val < 9.1)
        {
            super('*', Color.white_dark, Color.black, true);
        }
        else
        {
            super('^', Color.white, Color.black, true);
        }
    }
}
