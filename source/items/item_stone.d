import item;
import enums;
import slump;

import entity_player;

class ItemStone : Item
{
    this()
    {
        if(chance(5))
        {
            super("Brown Stone", ',', Color.yellow_dark);
        }
        else
        {
            super("Stone", ',', Color.black);
        }
    }

    override void inspect(EntityPlayer p)
    {
        p.addThought
        ([
            "It's a sharp stone.",
            "The edges of this stone are sharp.",
        ]);
    }
}
