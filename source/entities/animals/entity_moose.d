import entity_animal;
import enums;
import game;
import quest;

import item_cornerstone;
import item_axe;
import item_house;

class EntityMoose : EntityAnimal
{
    this(int x, int y)
    {
        super("Gustaf Carlsen the 13th", x, y, '@', Color.red_dark, new Quest
        (
            [
                //Talk messages
                "KNEEL! For it is I, the king.",
                "There is no one more mighty than I.",
                "I, me, mine, not-yours.",
            ],
            this,
            [
                QuestPart
                (
                    [
                        //Initial phrase
                        "Hello, minion. You are in front of the king of these forests. I have a request for you, feeble one. I need three Cornerstones as quickly as possible.",
                        //Repeated, more descriptive phrase
                        "Have you come to bring the three Cornerstones?",
                        //Finished phrase
                        "Thank you, minion!",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemCornerstone), 2);
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemCornerstone), 2);
                    }
                ),
                QuestPart
                (
                    [
                        //Initial phrase
                        "Minion! I need weapons for my army, bring me three axes to give to my guards!",
                        //Repeated, more descriptive phrase
                        "Have you managed to acquire the three Axes I required?",
                        //Finished phrase
                        "Thank you minion, my guards are finally properly armed.",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemAxe), 3);
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemAxe), 3);
                    }
                ),
                QuestPart
                (
                    [
                        //Initial phrase
                        "There is a dire need for housing in the kingdom, I need your help to solve this. Make me three houses to fix the housing problems!",
                        //Repeated, more descriptive phrase
                        "Can you give me the houses anytime soon?",
                        //Finished phrase
                        "Thank you, my subjects finally can have someplace to live",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemHouse), 3);
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemHouse), 3);
                    }
                ),
            ],
            "The kingdom is grateful of your service."
        ));
    }
}
