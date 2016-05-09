import entity_animal;
import enums;
import quest;
import game;

import item_seaweed;
import item_seasalad;
import item_fireplace;

class EntityOtter : EntityAnimal
{
    this(int x, int y)
    {
        super("Otterly Tarrific", x, y, '@', Color.magenta_dark, new Quest
        (
            [
                //Talk messages
                "I am utterly terrific.",
            ],
            this,
            [
                QuestPart
                (
                    [
                        //Initial phrase
                        "Why if it isn't my bestest pal in the world, you know what I am totally starving could you grab me some Seaweed?",
                        //Repeated, more descriptive phrase
                        "I am really hungry, don't think you could get me some seaweed?",
                        //Finished phrase
                        "Thanks Seaweed is good for me, even though it is slimy.",
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
                        "Have you made the Seaweed Salad yet? My dietist is getting mad that I'm not eating salad yet.",
                        //Finished phrase
                        "Thank you, this is exactly what my dietist wanted me to eat! Eww, it's yucky.",
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
                QuestPart
                (
                    [
                        //Initial phrase
                        "It gets mighty dark living under the water, could make me a firepit so I can see myself whilst underwater?",
                        //Repeated, more descriptive phrase
                        "Have you made a fireplace yet? I am still in the dark.",
                        //Finished phrase
                        "Thank you, this will help me explore the depths of this pond.",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemFireplace));
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemFireplace));
                    }
                ),
                QuestPart
                (
                    [
                        //Initial phrase
                        "I am so alone living alone underwater, could you make a house for me so I at least can be alone somewhere else?",
                        //Repeated, more descriptive phrase
                        "´Could you put a house somewhere near me?",
                        //Finished phrase
                        "Thank you I can finally be alone, in a house.",
                    ],
                    {
                        //Check
                        return houseNear();
                    },
                    {
                        //Action
                    }
                ),
            ],
            "Thanks pal, you truly are the bestest!"
        ));
    }
}
