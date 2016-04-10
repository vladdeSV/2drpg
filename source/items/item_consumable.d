import item;
import enums;

class ItemConsumable : Item
{
    this(string name, char sprite, Color color)
    {
        super(name, sprite, color);
        _healing = healing;
    }

    private int _healing;
}
