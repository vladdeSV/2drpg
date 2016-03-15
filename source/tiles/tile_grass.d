import tile;
import enums;
import game;

import std.random;

class TileGrass : Tile
{
    this()
    {
        int grassType = uniform(0, 5, Game.gen);
        char grassSprite = ' ';

        if(grassType < 2)
        {
            //grassType is either 0 or 1
            grassSprite = grassType ? '.' : ',';
        }

        super(grassSprite, Color.green, Color.green_dark);
    }
}
