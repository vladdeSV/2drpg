import tile;
import enums;
import slump;

import entity_player;

import item_berry;

class TileBerry : Tile
{
    this()
    {
        super(char(5), Color.magenta, Color.green_dark);
        _used = false;
    }

    override bool interact(EntityPlayer p)
    {
        if(_used)
        {
            return false;
        }

        if(!_used && !p.inventoryFull())
        {
            if(!p.hasRemembered("berries"))
            {
                p.remember("berries");
                p.addThought("These looks like edible berries.");
                p.addItem(new ItemBerry(), false);
            }
            else
            {
                p.addItem(new ItemBerry());
            }

            _used = true;
            _sprite = '1';
            _color = Color.yellow_dark;
        }
        else if(p.inventoryFull())
        {
            p.addThought("I can't stuff more berries.");
        }

        return true;
    }
}
