import tile;
import enums;

class TileGrass : Tile
{
    this(int type)
    {
        super(['.', ',', ' '][type % $], Color.green, Color.green_dark);
    }
}
