import enums;
import entity_player;

abstract class Item
{
    this(string name, char sprite, Color color, string inspect, bool usable = false)
    {
        _name = name;
        _sprite = sprite;
        _color = color;
        _usable = usable;
        _inspectString = inspect;
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

    bool usable() const @property
    {
        return _usable;
    }

    bool picked() const @property
    {
        return _picked;
    }

    bool picked(bool p) @property
    {
        return _picked = p;
    }

    void inspect(EntityPlayer p, bool force = false)
    {
        if(!_picked || force)
        {
            p.addThought(_inspectString);
        }
    }

    private string _name;
    private char _sprite;
    private Color _color;
    private bool _usable;
    private bool _picked;
    private string _inspectString;
}
