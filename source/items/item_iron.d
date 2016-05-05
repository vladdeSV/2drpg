import item;
import enums;
import slump;

class ItemIron : Item
{
    this()
    {
        auto i =
        [
            "Oh so metal.",
            "Fe, number 26.",
            "How IRONic, right? Anybody? Okay I'll show myself out then.",
        ];

        super("Lump of iron", '.', Color.red, random(i));
    }
}
