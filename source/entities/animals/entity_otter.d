import entity_animal;
import enums;
import quest;
import game;

import item_seaweed;
import item_seasalad;

class EntityOtter : EntityAnimal
{
    this(int x, int y)
    {
        super("Otterly Tarrific", x, y, '@', Color.magenta_dark, new Quest
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
                        "Why if it isn't my bestest pal in the world, you know what I am totally starving could you grab me some Seaweed?",
                        //Repeated, more descriptive phrase
                        "",
                        //Finished phrase
                        "",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemSeaWeed));
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemSeaWeed));
                    }
                ),
                QuestPart
                (
                    [
                        //Initial phrase
                        "I have started a NOCRB diet so no more carbs for me, I guess it is time to start eating sallad, a Seaweed Salad! Could you make some for me?",
                        //Repeated, more descriptive phrase
                        "",
                        //Finished phrase
                        "",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemSeaSalad));
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemSeaSalad));
                    }
                ),
                //QuestPart
                //(
                //    [
                //        //Initial phrase
                //        "It gets mighty dark living under the water, could make me a firepit so I can see myself whilst underwater?",
                //        //Repeated, more descriptive phrase
                //        "",
                //        //Finished phrase
                //        "",
                //    ],
                //    {
                //        //Check
                //        return Game.player.hasItem(typeid());
                //    },
                //    {
                //        //Action
                //        Game.player.removeItem(typeid());
                //    }
                //),
                //QuestPart
                //(
                //    [
                //        //Initial phrase
                //        "I am so alone living alone underwater, could you make a house for me so I at least can be alone somewhere else?",
                //        //Repeated, more descriptive phrase
                //        "",
                //        //Finished phrase
                //        "",
                //    ],
                //    {
                //        //Check
                //        return Game.player.hasItem(typeid());
                //    },
                //    {
                //        //Action
                //        Game.player.removeItem(typeid());
                //    }
                //),
            ],
            "Thanks pal, you truly are the bestest!"
        ));
    }
}
