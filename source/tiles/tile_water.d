import tile;
import enums;

class TileWater : Tile
{
    this(float vlad)
    {
        if(vlad < 2)
        {
            super(TileType.water, ' ', Color.blue, Color.blue_dark, true);
        }
        else
        {
            super(TileType.water, '~', Color.blue_dark, Color.blue);
        }
    }
}
