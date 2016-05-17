import item;
import enums;
import slump;

import item_wood;

import entity_player;

class ItemBerryStick : Item
{
    this()
    {
        auto i =
        [
            "A berry on a stick, as simple as that.",
            "I don't know what this is for, but it's pretty neat",
            "Ooh look a twig and two berries.",
        ];

        super("Berry stick", 'k', Color.magenta, random(i), true);
    }

    override void use(EntityPlayer p)
    {
        p.addThought
        ([
            "Now a stick.",
            "CAUTION: Do not eat stick.",
            "The berries are gone.",
        ]);
        p.addItem(new ItemWood, false);
    }
}
