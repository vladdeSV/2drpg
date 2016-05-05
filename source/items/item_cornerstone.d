import item;
import enums;
import slump;

class ItemCornerstone : Item
{
    this()
    {
        auto i =
        [
            "A corner shaped stone.",
            "Cornerstone, it consists of a corner and a stone.",
            "Useful for corners.",
            "One does simply not cut corners.",
        ];
        super("Cornerstone", char(4), Color.black, random(i));
    }
}
