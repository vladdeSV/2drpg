import tile;
import enums;
import misc;

import std.random;

class TileBarrier : Tile
{
    this()
    {
        bool c = chance(4);
        char s = ' ';

        if(c)
        {
            s = chance(2) ? '.' : ',';
        }

        super(TileType.grass, s, Color.magenta_dark, Color.black_dark, true);
    }
}
