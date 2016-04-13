import tile;
import enums;
import game;

import std.random;

class TileMountain : Tile
{
    this(float val)
    {
        if(val < 8.5)
        {
            super(TileType.rock, uniform(0, 2, Game.gen) == 0 ? '.' : ' ', Color.white_dark, Color.black, true);
        }
        else if(val < 9.1)
        {
            super(TileType.rock, '*', Color.white_dark, Color.black, true);
        }
        else
        {
            super(TileType.rock, '^', Color.white, Color.black, true);
        }
    }
}
