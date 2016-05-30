import item;
import enums;
import slump;

class ItemSweetSalad : Item
{
    this()
    {
        auto itemNameList =
        [
            "Looks disgusting.",
            "Why did I even make this?",
            "It's not sweet.",
        ];
        super("Berry salad", '*', Color.magenta, random(itemNameList));
    }
}
