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

string[] inspects =
[
    "This one's rotten, yuck!",
    "EEW , Worms!! Ah well, at least there is some more protein in it I guess.",
    "O lucky me! A bumble berry!",
    "Raspberries are my favorite!",
    "Cloudberries; the hidden gold of the swamplands.",
    "Going to drop some berries are we? Remember kids, drugs are for losers!",
    "Ooh look a twig and two berries.",
    "Fondling berries? How dirty of me.",
    "These berries look good!",
    "Ooh a pink blueberry.",
];
