import item;
import enums;
import slump;

class ItemSeaSalad : Item
{
    this()
    {
        auto itemNameList =
        [
            "A salad made from stuff that resides in the sea.",
            "May or may not contain traces of Spongebob.",
            "Salty salad!",
            "Aargh, Mate! Sallad I tell you!",
        ];
        super("Sea salad", '*', Color.green_dark, random(i));
    }
}
