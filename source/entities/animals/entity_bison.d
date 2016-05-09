import entity_animal;
import enums;
import quest;
import game;

import item_grass;
import item_fiber;

class EntityBison : EntityAnimal
{
    this(int x, int y)
    {
        super("Byser Michaels", x, y, '@', Color.yellow, new Quest
        (
            [
                //Talk messages
                "",
            ],
            this,
            [
                QuestPart
                (
                    [
                        //Initial phrase
                        "Small one, I have need of your help in gathering some food for me, please bring me some grass to eat.",
                        //Repeated, more descriptive phrase
                        "Have you come to give me the five grass I asked for?",
                        //Finished phrase
                        "Thank you this will taste gooooood!",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemGrass), 5);
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemGrass), 5);
                    }
                ),
                QuestPart
                (
                    [
                        //Initial phrase
                        "Small one, sadly my food supplies are once again running low, I have heard about this different sort of food called fiber, could you get me some?",
                        //Repeated, more descriptive phrase
                        "Have you found the fiber I asked for?",
                        //Finished phrase
                        "Thanks, this was surprisingly good.",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemFiber));
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemFiber));
                    }
                ),
                QuestPart
                (
                    [
                        //Initial phrase
                        "Small one, I have changed my diet to the FiBR now, therefore I need more of it. I would be very happy if you could get me some.",
                        //Repeated, more descriptive phrase
                        "I need more fiber in my storage, please bring me the five Fiber you promised.",
                        //Finished phrase
                        "Thank you, this will last for long!",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemFiber), 5);
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemFiber), 5);
                    }
                ),
            ],
            "Small one, I thank you for your help, I will think of you when I eat this."
        ));
    }
}

/+ Quest skelle
, new Quest
        (
            [
                "",
                "",
                "",
                "",
            ],
            this,
            [
                QuestPart
                (
                    [
                        "",
                        "",
                        ""
                    ],
                    {
                        return
                    },
                    {

                    }
                ),
            ],
        ));
+/
