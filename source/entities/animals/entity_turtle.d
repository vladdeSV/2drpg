import entity_animal;
import enums;
import game;
import quest;

import item_seaweed;
import item_seasalad;
import item_sweetsalad;
import item_axe;

class EntityTurtle : EntityAnimal
{
    this(int x, int y)
    {
        super("Ol' Man Bent", x, y, '@', Color.green, new Quest
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
                        "Back in my day we knew how to make really good salad, the best! Now that I talk about it I remember that I need some more seaweed, could you get me some young one?",
                        //Repeated, more descriptive phrase
                        "My Seaweed storage is still empty.",
                        //Finished phrase
                        "Thank you, young one, I needed that for my storage.",
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
                        "MY GOD WHY CAN NOBODY MAKE GOOD SALAD ANYMORE? What did you say young one? Can you make salad? If you could make some for me I would be so happy.",
                        //Repeated, more descriptive phrase
                        "Do you have the Sea Salad, whippersnapper?",
                        //Finished phrase
                        "It was a long time since I had a good Sea Salad.",
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
                        "I heard of some sort of new sort of Salad, Salad with Berry in it. Can you believe what youngsters come up with these days. To be honest I once tried it when I was young but I don't remember the taste, could you get me some so I can taste it again?",
                        //Repeated, more descriptive phrase
                        "Have you made the Berry Salad for me?",
                        //Finished phrase
                        "Thank you, this really tastes different from normal salad.",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemSweetSalad));
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemSweetSalad));
                    }
                ),
                QuestPart
                (
                    [
                        //Initial phrase
                        "I could really use a tool to take care of all the bushes in my garden. Could you make me an Axe so I can chop down some of them?",
                        //Repeated, more descriptive phrase
                        "Have you come to give me the Axe?",
                        //Finished phrase
                        "I will finally be able to get rid of those weeds.",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemAxe));
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemAxe));
                    }
                ),
                QuestPart
                (
                    [
                        //Initial phrase
                        "I am a lonely, old Turtle. I have lived here for so long I think it would do me good with a change of scenery. Could you make a house for me to live in?",
                        //Repeated, more descriptive phrase
                        "Have you finished the House, child?",
                        //Finished phrase
                        "Thank you, you truly have made this old turtle happy.",
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
            "Thank you, this reminds me of when I was young."
        ));
    }
}
