import enums;
import entity_player;

abstract class Item
{
    this(string name, char sprite, Color color, bool useable = false)
    {
        _name = name;
        _sprite = sprite;
        _color = color;
        _useable = useable;
    }

    string name() const @property
    {
        return _name;
    }

    char sprite() const @property
    {
        return _sprite;
    }

    Color color() const @property
    {
        return _color;
    }

    void use(EntityPlayer p)
    {

    }

    bool useable() const @property
    {
        return _useable;
    }

    void inspect(EntityPlayer p)
    {
        p.addThought(name ~ ".");
    }

    private string _name;
    private char _sprite;
    private Color _color;
    private bool _useable;
}
