import tile;
import enums;

class TileWater : Tile
{
    this(bool shallow)
    {
        if(shallow)
        {
            super('~', Color.blue_dark, Color.blue);
        }
        else
        {
            super(' ', Color.blue, Color.blue_dark, true);
        }
    }
}
