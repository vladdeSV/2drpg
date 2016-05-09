import item;
import enums;
import slump;

class ItemFireplace : Item
{
    this()
    {
        auto a =
        [
            "A place for fire.",
            "A great source of heat.",
            "For outdoor use only! Safety first!",
            "A small contributor to climate change.",
            "IT'S ON FIRE!!!",
            "Fiery red.",
        ];

        super("Fireplace", char(15), Color.red, random(a));
    }
}
