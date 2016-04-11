import tile;
import enums;
import slump;

class TileGrass : Tile
{
    this()
    {
        bool chanceGrass = chance(4);
        char s = ' ';

        if(chanceGrass)
        {
            s = chance(2) ? '.' : ',';
        }

        super(TileType.grass, s, Color.green, Color.green_dark);
    }
}
