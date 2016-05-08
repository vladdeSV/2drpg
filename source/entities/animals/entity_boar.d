import entity_animal;
import enums;
import quest;
import game;

import item_fishingpole;
import item_seaweed;

class EntityBoar : EntityAnimal
{
    this(int x, int y)
    {
        super("Captain Myrschester", x, y, '@', Color.yellow_dark, new Quest
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
                        "Hello, good day, bienvenue. I was formerly the captain of my own vessel, sadly now I am stuck on land. I still yearn for adventure, could you give me a fishing rod to remind me of past days?",
                        //Repeated, more descriptive phrase
                        "",
                        //Finished phrase
                        "",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemFishingPole));
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemFishingPole));
                    }
                ),
                QuestPart
                (
                    [
                        //Initial phrase
                        "Oh I remember how we would sail for weeks on end with no land in sight. When we were so far out we had to eat food from the sea, perhaps you could bring me some Seaweed salad to remind me of past days?",
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
                //QuestPart
                //(
                //    [
                //        //Initial phrase
                //        "A captain is nothing without his boat, sadly I no longer have a boat therefore I can no longer be a captain. Maybe I should get a home to live in, could you help me?",
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
            "Haha, thank you! This certainly makes me feel alive once again."
        ));
    }
}
