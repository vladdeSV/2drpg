module entity.entity;

public import entity.attributes;

class Entity
{
    void addAttribute(A, Args...)(Args args) if (is(typeof(A) == Attribute))
    {
        if(m_attribute.get(typeid(A).name, null) is null)
        {
            m_attribute[typeid(A).name] = new A(args);
        }
    }

    A getAttribute(A)()
    {
        return cast(A) m_attribute.get(typeid(A).name, null);
    }

    char sprite() @property
    {
        return m_sprite;
    }

    char sprite(char sprite) @property
    {
        return m_sprite = sprite;
    }

    private char m_sprite;

    private Attribute[string] m_attribute;
}
