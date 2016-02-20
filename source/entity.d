module entity;

import enums;
import std.traits;

class Entity
{
    this()
    {
        //Iterate and init all attributes
        foreach(atr; [EnumMembers!Attributes])
        {
            m_attributes[atr] = 0;
        }
    }

    string getFullName()
    {
        return m_name ~ " " ~ m_surename;
    }

private:
    string m_name;
    string m_surename;
    int[Attributes] m_attributes;
}
