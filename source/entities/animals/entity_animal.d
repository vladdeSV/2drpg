import entity_living;
import entity_player;
import enums;
import quest;
import game;

import item_house;

class EntityAnimal : EntityLiving
{
    this(string name, int x, int y, char sprite, Color color, Quest quest = null)
    {
        super(name, x, y, sprite, color);
        _quest = quest;
    }

    void interact(EntityPlayer p)
    {
        p.setQuest(_quest);
    }

    void exit(EntityPlayer p)
    {
        p.setQuest(null); //FIXME: BAD CODE
    }

    Quest quest() @property
    {
        return _quest;
    }

    bool houseNear()
    {
        return Game.world.itemNear(cast(int) _wx, cast(int) _wy, typeid(ItemHouse), 5);
    }

    private Quest _quest;
}
