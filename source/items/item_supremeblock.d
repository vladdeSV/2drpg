import item;
import enums;
import slump;

class ItemSupremeBlock : Item
{
    this()
    {
        auto itemNameList =
        [
            "The§ one true block.",
            "One block to rule them all, one block to find them, one block to bring them all and in shadows bind them.",
            "A simply superb block.",
        ];
        super("Supreme block", char(30), Color.black, random(i));
    }
}
