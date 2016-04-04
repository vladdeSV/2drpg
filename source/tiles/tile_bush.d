import tile;
import enums;

class TileBush : Tile
{
    this()
    {
        super(TileType.tree, char(5), Color.magenta, Color.green_dark);
    }
}
