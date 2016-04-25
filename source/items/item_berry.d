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
        string name;
        char sprite;
        Color color;

        if(type == 0)
        {
            name = "Raspberries";
            sprite = char(5);
            color = Color.red;
        }
        else if(type == 1)
        {
            name = "Straw berries";
            sprite = '|';
            color = Color.red;
        }
        else
        {
            name = "Bluberries";
            sprite = 'o';
            color = Color.blue;
        }

        super(name, sprite, color, "berryInspects!(name).inspects[random($)]", true);
    }

    override void use(EntityPlayer p)
    {
        //p.memory += 1;
        p.addThought
        ([
            (name ~ " are the best."),
            "Sweeter than the store's.",
            ("I like " ~ name.toLower() ~ "."),
            ("Much tastier than bought " ~ name.toLower() ~ "."),
        ]);
    }
}

template berryInspects(string berries)
{
    string[] inspect =
    [
        berries ~ " are yummy.",
        "I really like " ~ berries,
        ":)"
    ];
}
