import tile;
import enums;
import game;

import std.random;

class TileSand : Tile
{
    this()
    {
        super(TileType.sand, uniform(0, 5, Game.gen) == 0 ? ',' : ' ', Color.yellow_dark, Color.yellow);
    }
}
