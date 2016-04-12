import tile;
import enums;
import game;
import slump;

import item_wood;
import item_stone;

import std.random;

class TileSand : Tile
{
    this()
    {
        auto sprite = ' ';
        _used = true;
        if(chance(5))
        {
            sprite = ',';
            _used = false;
        }
        super(TileType.sand, sprite, Color.yellow_dark, Color.yellow);
    }

    override bool interact(EntityPlayer p)
    {
        if(!_used && !p.inventoryFull())
        {
            if(!p.hasRemembered("stone"))
            {
                p.remember("stone");
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

            p.addItem(new ItemStone());

            _sprite = ' ';
            _used = true;
        }
        else if(p.inventoryFull())
        {
            p.addThought("My pockets do not fit more stones.");
        }
        return true;
    }
}
