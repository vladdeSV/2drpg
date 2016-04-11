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
        char s = ' ';

        if(chance(4))
        {
            s = coin() ? '.' : ',';
        }

        super(TileType.grass, s, Color.magenta_dark, Color.black_dark, true);
    }

    override bool interact(EntityPlayer p)
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
        return true;
    }
}
