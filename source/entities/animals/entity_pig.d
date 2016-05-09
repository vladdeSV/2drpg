import entity_animal;
import enums;
import quest;
import game;

import item_berry;
import item_sweetsalad;

class EntityPig : EntityAnimal
{
    this(int x, int y)
    {
        super("Willis Brukton", x, y, '@', Color.magenta, new Quest
        (
            [
                //Talk messages
                "Mud or berries, that is the question.",
                "What happens if you combine salad and mud. Or berries?",
                "I like berries, specifically the pink ones.",
                "Red and blue berries are not as tasty as the pink one.",
            ],
            this,
            [
                QuestPart
                (
                    [
                        //Initial phrase
                        "There is only thing that is better than berries, mud. However you can't collect mud so bring me some berries instead.",
                        //Repeated, more descriptive phrase
                        "Hey do you have the Berry?",
                        //Finished phrase
                        "Thanks.",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemBerry));
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemBerry));
                    }
                ),
                QuestPart
                (
                    [
                        //Initial phrase
                        "Hey you, yeah you. You just lost the game, The Game. Right bring me a Sweet Salad I am hungry.",
                        //Repeated, more descriptive phrase
                        "Do you have the Sweet Salad or are you still mad about losing the game?",
                        //Finished phrase
                        "Thanks again.",
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
                        "Our house, in the middle of our street. Except I don't own a house, get me one.",
                        //Repeated, more descriptive phrase
                        "House, house, house, place a house.",
                        //Finished phrase
                        "Oh, thanks!",
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
            "Thanks, I guess."
        ));
    }
}
