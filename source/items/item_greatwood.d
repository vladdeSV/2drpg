import item;
import enums;
import slump;

class ItemGreatWood : Item
{
    this()
    {
        auto i =
        [
            "The opposite of bad wood.",
            "Sonofabitch, this is some great wood!",
            "Almost-supreme Wood.",
            "The Greatest Wood. I have the best words. Make wood great again!",
        ];

        super("Great wood", '|', Color.red_dark, random(i));
    }
}
