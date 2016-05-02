import tile;
import enums;
import game;
import slump;

import item_iron;
import item_stone;

import std.random;

class TileSand : Tile
{
    this()
    {
        if(chance(5))
        {
            if(chance(69 /*HAHAHAHAHA I AM 12*/))
            {
                _items ~= new ItemIron();
            }
            else
            {
                _items ~= new ItemStone();
            }
        }

        super(' ', Color.yellow_dark, Color.yellow);
    }
}
