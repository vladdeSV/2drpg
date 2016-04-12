import item;
import enums;

import entity_player;

class ItemStone : Item
{
    this()
    {
        super("Stone", char(4), Color.black);
    }

    override void use(EntityPlayer p)
    {

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
