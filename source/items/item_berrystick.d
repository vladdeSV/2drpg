import item;
import enums;
import slump;

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

        super("Berry stick", 'k', Color.magenta, random(i));
    }
}
