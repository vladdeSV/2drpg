import entity_living;
import entity_player;
import enums;
import quest;

class EntityAnimal : EntityLiving
{
    this(string name, int x, int y, char sprite, Color color, Quest quest = null)
    {
        super(name, x, y, sprite, color);
        _quest = quest;
    }

    void interact(EntityPlayer p)
    {
        p.addThought(name);

        p.setQuest(_quest);
    }

    void exit(EntityPlayer p)
    {
        p.setQuest(null); //FIXME: BAD CODE
    }

    private Quest _quest;
}
