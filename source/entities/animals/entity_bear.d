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
            ["Hello", "Swag", "Yo", "Breh"],
            ["Do this", "slacker"],
            ["Thank you!", "mmmm", "yess"],
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
