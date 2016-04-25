import item;
import enums;
import slump;

import entity_player;

class ItemStone : Item
{
    this()
    {
        string name = "Stone";
        Color color = Color.black;

        if(chance(5))
        {
            name = "Brown Stone";
            color = Color.yellow_dark;
        }

        super(name, ',', color, inspects[random($)]);
    }
}

string[] inspects =
[
    "This stone looks stoned.",
    "Sharp edged stone.",
    "Lollygag.",
    "Lollygag2.",
    "Lollygag3.",
    "Lollygag4.",
];
