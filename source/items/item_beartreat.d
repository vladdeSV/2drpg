import item;
import enums;
import slump;

class ItemBearTreat : Item
{
    this()
    {
        string[] itemNameList =
        [
            "A treat for quadrupedal mammals of the ursidae family.",
            "Bears love this stuff!",
            "TTT, the Teddy Taming Treat.",
        ];
        super("Bear treat", '$', Color.magenta, random(itemNameList));
    }
}
