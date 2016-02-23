import item;
import enums;

class ItemConsumable : Item
{
    this(string name, int healing, int value)
    {
        super(name, value);
        m_healing = healing;
    }

    auto healing() const @property
    {
        return m_healing;
    }

private:
    int m_healing;
}
