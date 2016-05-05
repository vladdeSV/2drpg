import item;
import enums;
import slump;

class ItemNiceAxe : Item
{
    this()
    {
        auto i =
        [
            "A particularly nice axe.",
            "A great axe.",
        ];
        super("Nice axe", char(18), Color.cyan_dark, random(i));
    }
}
