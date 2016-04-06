import enums;

abstract class Item
{
    this(string name)
    {
        _name = name;
    }

    auto name() const @property
    {
        return _name;
    }

private:
    string _name;
}
