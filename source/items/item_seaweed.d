import item;
import enums;
import slump;

class ItemSeaWeed : Item
{
    this()
    {
        auto itemNameList =
        [
            "Weed for fishes.",
            "I Japan they eat this stuff, maybe I should try?",
            "Grass from the sea.",
            "Underwater grass."
        ];
        super("Sea weed", '}', Color.green, random(itemNameList));
    }
}
