import item;
import enums;
import slump;

import std.string;

import entity_player;

class ItemBerry : Item
{
    this()
    {
        int type = random(3);

        if(type == 0)
        {
            super(/*ItemType.berry, */"Raspberries", char(5), Color.red, true);
        }
        else if(type == 1)
        {
            super(/*ItemType.berry, */"Straw berries", '|', Color.red, true);
        }
        else
        {
            super(/*ItemType.berry, */"Bluberries", 'o', Color.blue, true);
        }
    }

    override void use(EntityPlayer p)
    {
        p.memory += 1;
        p.addThought
        ([
            (name ~ " are the best."),
            "Sweeter than the store's.",
            ("I like " ~ name.toLower() ~ "."),
            ("Much tastier than bought " ~ name.toLower() ~ "."),
        ]);
    }

    override void inspect(EntityPlayer p)
    {
        p.addThought("Some " ~ name.toLower() ~ ".");
    }
}
