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
            ["I am un-bear-able", "Talk", "talky"],
            //["I'm hungry, give a pal some food?", "i have quest", "do this quest"],
            ["DEBUG: give grass"],
            ["Thank you very much! Yum yum.", "thinks quest done", "you are finifshed"],
            {
                auto itemType = typeid(ItemGrass);
                bool completed = Game.player.hasItem(itemType);

                if(completed)
                {
                    Game.player.removeItem(itemType);
                }

                return completed;
            },
            this,
        ));
    }
}
