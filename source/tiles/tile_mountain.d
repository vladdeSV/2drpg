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
            super(TileType.rock, uniform(0, 2, Game.gen) == 0 ? '.' : ' ', Color.white_dark, Color.black, true);
        }
        else if(type == MountainLevel.mid)
        {
            super(TileType.rock, '*', Color.white_dark, Color.black, true);
        }
        else if(type == MountainLevel.high)
        {
            super(TileType.rock, '^', Color.white, Color.black, true);
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
