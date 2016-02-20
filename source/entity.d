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

    auto attributes() const @property
    {
        return m_attributes;
    }

    auto getFullName() const
    {
        return m_name ~ " " ~ m_surename;
    }

private:
    string m_name;
    string m_surename;
    bool m_gender;
    int[Attributes] m_attributes;
}
