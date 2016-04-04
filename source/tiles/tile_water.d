import tile;
import enums;

class TileWater : Tile
{
    this(bool shallow)
    {
        if(shallow)
        {
            super(TileType.water, '~', Color.blue_dark, Color.blue);
        }
        else
        {
            super(TileType.water, ' ', Color.blue, Color.blue_dark, true);
        }
    }
}
