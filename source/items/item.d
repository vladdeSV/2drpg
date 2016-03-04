import enums;

abstract class Item
{
    this(string name, int value)
    {
        _name = name;
        _value = value;
    }

    auto name() const @property
    {
        return _name;
    }

    auto value() const @property
    {
        return _value;
    }

private:
    string _name;
    int _value;
}
