import enums;

class Item
{
    this(string name, int value)
    {
        m_name = name;
        m_value = value;
    }

    auto name() const @property
    {
        return m_name;
    }

    auto value() const @property
    {
        return m_value;
    }

private:
    string m_name;
    int m_value;
}
