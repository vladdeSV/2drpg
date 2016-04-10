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

    int health() const @property
    {
        return _health;
    }

    int maxHealth() const @property
    {
        return _maxHealth;
    }

    private string _name;
}
