import tile;
import enums;
import game;
import random;
import items;

import std.random;

class TileSand : Tile
{
    this()
    {
        auto sprite = ' ';
        _picked = true;
        if(chance(5))
        {
            sprite = ',';
            _picked = false;
        }
        super(TileType.sand, sprite, Color.yellow_dark, Color.yellow);
    }

    override bool interact(EntityPlayer p)
    {
        if(!_picked && !p.inventoryFull())
        {
            if(!p.remember("stone"))
            {
                p.addThought("This stone looks like it could be used as a tool.");
            }
            else
            {
                p.addThought([
                    "Another stone.",
                    "A stone.",
                    "Small stone.",
                    "Look! It's a stone.",
                    "One out of many stones.",
                    "This stone looks prettier than all the others.",
                ]);
            }

            p.addItem(ListItemMisc["stone"]);

            _sprite = ' ';
            _picked = true;
        }
    }
}
