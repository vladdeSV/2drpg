module entity.entity;

class Entity
{
    void addAttribute(A, Args...)(Args args)
    {
        if(m_components.get(typeid(A).name, null) is null)
        {
            m_components[typeid(A).name] = new A(args);
        }
    }

    A getAttribute(A)()
    {
        assert(m_components.get(typeid(A).name, null) is null, format("Is no %s in components list", typeid(A).name));
        return cast(A) m_components.get(typeid(A).name, null);
    }

    private Attribute[string] m_components;
}
