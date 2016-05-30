import item;
import enums;
import slump;

class ItemAxe : Item
{
    this()
    {
        string[] itemNameList =
        [
            "A primitive axe.",
            "Useful for chopping down trees and massacring zombies.",
            "The weapon of choice for a viking.",
            "Heavy and sharp.",
        ];

        super("Small Axe", char(24), Color.cyan_dark, random(itemNameList));
    }
}
