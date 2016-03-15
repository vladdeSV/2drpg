import tile;
import enums;
import game;

import std.random;

class TileMountain : Tile
{
    this(MountainLevel type)
    {
        if(type == MountainLevel.low)
        {
            super(uniform(0, 2, Game.gen) == 0 ? '.' : ' ', Color.gray, Color.gray_dark);
        }
        else if(type == MountainLevel.mid)
        {
            super('*', Color.gray, Color.gray_dark);
        }
        else if(type == MountainLevel.high)
        {
            super('^', Color.white, Color.gray_dark);
        }
        else
        {
            super();
        }
    }
}

enum MountainLevel
{
    low,
    mid,
    high,
}
