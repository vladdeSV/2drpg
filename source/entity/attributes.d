module entity.attributes;

import entity.entity;
import std.conv : to;


enum Race
{
    Human = 1,
    Orc = 2,
    Fishman = 4,
    Elf = 8,
    Dwarf = 16,
}

enum Occupation
{
    Villager,
    Fisher,
    Farmer
}

abstract class Attribute {}

class AttributeHealth : Attribute
{
    int health;
}

class AttributeMana : Attribute
{
    int mana;
}

class AttributeRace : Attribute
{
    Race race;
}

class AttributeOccupation : Attribute
{
    Occupation occupation;
}

class AttributeName : Attribute
{
    this(Args...)(Args args)
    {
        foreach(arg; args)
        {
            name ~= to!string(arg);
        }
    }

    string[] name;
}
