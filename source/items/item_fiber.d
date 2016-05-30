import item;
import enums;
import slump;

class ItemFiber : Item
{
    this()
    {
        auto itemNameList =
        [
            "Fibers, very useful for... something.",
            "You probably can bind stuff together with it.",
            "Good for the digestive system.",
            "A bundle of grass fibers.",
        ];
        super("Fiber", char(22), Color.green_dark, random(itemNameList));
    }
}
