import item;
import enums;
import entity_player;

class ItemGrass : Item
{
    this(char sprite)
    {
        super(/*ItemType.grass, */"Grass", sprite, Color.green);
    }
}
