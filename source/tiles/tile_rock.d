import tile;
import enums;

class TileRock : Tile
{
    this(RockType type)
    {
        if(type == RockType.mountainLow)
        {
            super('.', Color.gray, Color.gray_dark);
        }
        else if(type == RockType.mountainMid)
        {
            super('*', Color.gray, Color.gray_dark);
        }
        else if(type == RockType.mountainHigh)
        {
            super('^', Color.white, Color.gray_dark);
        }
        else if(type == RockType.mountainHigh)
        {
            super(' ', Color.init, Color.gray_dark);
        }
        else
        {
            super('?', Color.red, Color.white);
        }
    }
}

enum RockType
{
    rock,
    mountainLow,
    mountainMid,
    mountainHigh,
}
