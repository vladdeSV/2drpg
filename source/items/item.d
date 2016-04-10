import enums;
import entity_player;

abstract class Item
{
    this(string name, char sprite, Color color)
    {
        _name = name;
        _sprite = sprite;
        _color = color;
    }

    void use(EntityPlayer player)
    {

    }

    void instpect(EntityPlayer player)
    {

    }

    private string _name;
    private char _sprite;
    private Color _color;
}
