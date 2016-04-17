import tile;
import enums;

class TileWater : Tile
{
    this(float vlad)
    {
        if(vlad < 2)
        {
            super(' ', Color.blue, Color.blue_dark, true);
        }
        else
        {
            super('~', Color.blue_dark, Color.blue);
        }
    }
}
