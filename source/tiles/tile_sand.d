import tile;
import enums;

class TileSand : Tile
{
    this(int a)
    {
        super(a == 0 ? ',' : ' ', Color.yellow_dark, Color.yellow);
    }
}
