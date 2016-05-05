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

        string[] inspects =
        [
            "This one's rotten, yuck!",
            "Eew, worms! Ah well, at least there is protein in it.",
            "A bumble berry! Oh wait it's just some " ~ name.toLower() ~ ".",
            "Going to drop some berries are we? Remember kids, drugs are for losers!",
            "Fondling berries? How dirty of me.",
            "These berries look good!",
            "What!? These ", name.toLower(), " aren't pink.",
        ];

        super(name, sprite, color, inspects[random($)], true);
    }

    override void use(EntityPlayer p)
    {
        p.addThought
        ([
            name ~ " are the best.",
            "Sweeter than the store's.",
            "I like " ~ name.toLower() ~ ".",
            "Much tastier than bought " ~ name.toLower() ~ ".",
        ]);
    }
}
