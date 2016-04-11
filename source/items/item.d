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

    string name() const @property
    {
        return _name;
    }

    void use(EntityPlayer p)
    {

    }

    void inspect(EntityPlayer p)
    {
        p.addThought(name ~ ".");
    }

    char sprite() const @property
    {
        return _sprite;
    }
    Color color() const @property
    {
        return _color;
    }

    private string _name;
    private char _sprite;
    private Color _color;
}
