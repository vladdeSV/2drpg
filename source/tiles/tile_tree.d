import tile;
import enums;

class TileTree : Tile
{
    this(TreeType type)
    {
        if(type == TreeType.oak)
        {
            super('T', Color.yellow_dark, Color.green_dark);
        }
        else if(type == TreeType.redwood)
        {
            super('Y', Color.red_dark, Color.green_dark);
        }
        else if(type == TreeType.fir)
        {
            super('A', Color.green, Color.green_dark);
        }
        else if(type == TreeType.deadwood)
        {
            super('I', Color.red_dark, Color.green_dark);
        }
        else
        {
            super('?', Color.red, Color.white);
        }
    }
}

enum TreeType
{
    oak,
    redwood,
    fir,
    deadwood,
}
