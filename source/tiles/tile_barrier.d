import tile;
import enums;
import slump;
import entity_player;
import thought;

import std.random;

class TileBarrier : Tile
{
    this()
    {
        bool c = chance(4);
        char s = ' ';

        if(c)
        {
            s = chance(2) ? '.' : ',';
        }

        super(TileType.grass, s, Color.magenta_dark, Color.black_dark, true);
    }

    override void interact(EntityPlayer p)
    {
        p.addThought
        ([
            "It's the end.",
            "I can't go any further.",
            "There is nothing more.",
            "It's dark.",
            "I can't see further.",
            "I know I can't pass.",
            "I don't want to leave",
        ]);
    }
}
