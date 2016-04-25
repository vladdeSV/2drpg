import tile;
import enums;
import slump;

import item_fishingpole;
import item_seaweed;

class TileWater : Tile
{
    this(float vlad)
    {
        if(vlad < 2)
        {
            super(' ', Color.blue, Color.blue_dark, true);
        }
        else
        {
            super('~', Color.blue_dark, Color.blue);
        }

        _used = false;
    }

    override bool interact(EntityPlayer p)
    {
        if(_used)
        {
            return false;
        }

        if(p.equipped == (typeid(ItemFishingPole)))
        {
            if(chance(5))
            {
                p.addThought([
                    "Lucky!",
                    "Yes!",
                    "Wohoo!",
                    ":)",
                ]);

                p.addItem(new ItemSeaWeed);

                return _used = true;
            }

            return true;
        }

        return false;
    }
}
