module type;

import std.conv : to;

abstract class Attribute {}

///Type from where all objects (tiles, enemies, etc...) are created
class Type
{
    void addAttribute(A, Args...)(Args args)
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

    private Attribute[string] m_attribute;
}

/////////////////////////////
// au = attribute universal
// ae = attribute entity
// at = attribute tile

//>>Universal
class auSprite : Attribute
{
    char sprite;
}
//<<

//>>Entities
enum Race
{
    Human = 1,
    Orc = 2,
    Fishman = 4,
    Elf = 8,
    Dwarf = 16,
}

class aeHealth : Attribute
{
    int health;
}

class aeMana : Attribute
{
    int mana;
}

class aeRace : Attribute
{
    Race race;
}

class aeName : Attribute
{
    this(Args...)(Args args) if (args !is null)
    {
        foreach(arg; args)
        {
            name ~= to!string(arg);
        }
    }

    string[] name;
}
//<<

//>>Tiles
class atSolid : Attribute
{
    this(bool solid)
    {
        this.solid = solid;
    }

    bool solid = true;
}
//<<
