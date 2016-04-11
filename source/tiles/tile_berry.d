import tile;
import enums;
import slump;

import entity_player;

import item_berry;

class TileBerry : Tile
{
    this()
    {
        super(TileType.tree, char(5), Color.magenta, Color.green_dark);
    }

    override bool interact(EntityPlayer p)
    {
        if(!_used && !p.inventoryFull())
        {
            int berriesGot = random(2) + 1;

            if(!p.hasRemembered("berries"))
            {
                p.remember("berries");
                p.addThought("These looks like edible berries.");
            }
            else
            {
                p.addThought
                ([
                    "Look, more berries.",
                    "Oh, berries.",
                    "I like berries.",
                    "Berries are yummy.",
                ]);
            }

            p.addItem(new ItemBerry());

            _used = true;
            _sprite = '1';
            _color = Color.yellow_dark;
        }
        else
        {
            p.addThought("My pockets do not fit more berries.");
        }

        return true;
    }
}
