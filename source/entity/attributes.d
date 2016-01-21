module entity.attributes;

import entity.entity;

enum EntityRace
{
    Human = 1,
    Orc = 2,
    Fishman = 4,
    Elf = 8,
    Dwarf = 16,
}

enum NpcOccupation
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

class AttributeSprite : Attribute
{
    char sprite;
}

class AttributeRace : Attribute
{
    EntityRace race;
}

class AttributeOccupation : Attribute
{
    NpcOccupation occupation;
}
