import entity;
import enums;

class EntityLiving : Entity
{
    this(string name, int x, int y, char sprite, Color color)
    {
        super(x, y, sprite, color);
        _name = name;
    }

    string name() const @property
    {
        return _name;
    }

    private string _name;
}
