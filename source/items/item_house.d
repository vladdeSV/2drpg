import item;
import enums;
import slump;

class ItemHouse : Item
{
    this()
    {
        auto a =
        [
            "A house, a home.",
            "House sweet house.",
            "A good place for friends to live.",
            "Four walls and a roof, it's all you need!",
            "The house of the rising sun.",
            "The house always wins, don't gamble kids!",
        ];

        super("House", char(127), Color.yellow_dark, random(a));
    }
}
