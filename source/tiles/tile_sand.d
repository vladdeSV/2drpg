import tile;
import enums;
import game;
import slump;

import item_wood;
import item_stone;

import std.random;

class TileSand : Tile
{
    this()
    {
        if(chance(5))
        {
            _items ~= new ItemStone();
        }

        super(' ', Color.yellow_dark, Color.yellow);
    }
}
