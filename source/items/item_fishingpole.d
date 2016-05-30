import item;
import enums;
import slump;

class ItemFishingPole : Item
{
    this()
    {
        auto itemNameList =
        [
            "A hook on a string on a pole, used for fishing.",
            "It's technically a rod, but oh well.",
            "A pole for fishing.",
            "Gotta catch them all!",
        ];
        super("Fishing pole", '?', Color.cyan_dark, random(i));
    }
}
