import game;
import enums;
import entity_animal;
import quest;
import std.algorithm.mutation : remove;
import item_grass;

class EntityBear : EntityAnimal
{
    this(int x, int y)
    {
        super("Baer Grills", x, y, '@', Color.red, new Quest
        (
            "I am un-bear-able",
            "I'm hungry, give a pal some food?",
            "Thank you very much! Yum yum.",
            {
                auto itemType = typeid(ItemGrass);
                bool completed = Game.player.hasItem(itemType);

                if(completed)
                {
                    foreach(n, item; Game.player.inventory)
                    {
                        if(typeid(item) == itemType)
                        {
                            Game.player.inventory.remove(n);
                        }
                    }
                }

                return completed;
            },
            this,
        ));
    }
}
