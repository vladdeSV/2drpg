import entity_animal;
import enums;
import quest;
import game;

import item_fishingpole;
import item_seasalad;

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
                        "Have you manufactured a fishing rod for me?",
                        //Finished phrase
                        "Thank you, hopefully this will go swimmingly.",
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
                        "Have you come to bring me the Sea Salad?",
                        //Finished phrase
                        "So long and thanks for the salad.",
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
                        "A captain is nothing without his boat, sadly I no longer have a boat therefore I can no longer be a captain. Maybe I should get a home to live in, could you help me?",
                        //Repeated, more descriptive phrase
                        "Have you made the house yet?",
                        //Finished phrase
                        "Thank you, thank you",
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
            "Haha, thank you! This certainly makes me feel alive once again."
        ));
    }
}
