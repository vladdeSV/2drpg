import item;
import enums;
import slump;

class ItemMaxe : Item
{
    this()
    {
        auto itemNameList =
        [
            "The best axe, the MAXe! Get it? Oh I'm so terrifically funny.",
            "The. Ultimate. Axe.",
            "One axe to chop them all.",
        ];
        super("MAXe", char(23), Color.cyan_dark, random(itemNameList));
    }
}
