import tile;
import enums;
import game;

import entity_player;

import std.random;

class TileTree : Tile
{
    this(float val)
    {
        if(val - 4 < 3)
        {
            super(TileType.tree, 'Y', Color.red_dark, Color.green_dark, true);
        }
        else
        {
            super(TileType.tree, 'I', Color.red_dark, Color.green_dark, true);
        }
    }

    override bool interact(EntityPlayer p)
    {
        p.addThought([
            "Hitting with my hands hurt. Maybe I could use a stone from the sand?",
            "I fight the three. The tree fights back.",
            "My hands hurt.",
        ]);

        if(firstUse)
        {
            p.remember("pickupstone");
            firstUse = false;
        }

        return true;
    }

    private bool firstUse = true;
}
