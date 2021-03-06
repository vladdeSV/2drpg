import tile;
import enums;
import game;

import entity_player;

import item_wood;
import item_axe;
import item_niceaxe;
import item_maxe;
import item_stone;

import std.random;

class TileTree : Tile
{
    this(float val)
    {
        if(val - 4 < 3)
        {
            super('Y', Color.red_dark, Color.green_dark, true);
        }
        else
        {
            super('I', Color.red_dark, Color.green_dark, true);
        }

        _used = false;
    }

    override bool interact(EntityPlayer p)
    {
        if(used)
        {
            return false;
        }

        ubyte damage = 0;

        if(p.equipped() == typeid(ItemStone))
        {
            damage = 1;
        }
        else if(p.equipped() == typeid(ItemAxe))
        {
            damage = 2;
        }
        else if(p.equipped() == typeid(ItemNiceAxe))
        {
            damage = 3;
        }
        else if(p.equipped() == typeid(ItemMaxe))
        {
            damage = 5;
        }

        if(damage)
        {
            p.addThought([
                "Hit.",
                "Ungh.",
                "Uhhg.",
                "Oomph.",
                "Ugh.",
                "Hack.",
                "Boff.",
            ]);

            _health -= damage;
        }
        else
        {
            p.addThought([
                "Hitting with my hands hurt. Maybe I could use a tool?",
                "I fight the three. The tree fights back.",
                "My hands hurt.",
            ]);
        }

        if(_firstUse)
        {
            p.remember("pickupstone");
            _firstUse = false;
        }

        if(_health <= 0)
        {
            _sprite = ' ';
            _solid = false;
            _used = true;
            p.addItem(new ItemWood);
        }

        return true;
    }

    private bool _firstUse = true;
    private int _health = 5;
}
