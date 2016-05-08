import entity_animal;
import enums;
import game;
import quest;

import item_supremeblock;
import item_niceaxe;

class EntityMoose : EntityAnimal
{
    this(int x, int y)
    {
        super("Gustaf Carlsen the 13th", x, y, '@', Color.red_dark, new Quest
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
                        "Hello, minion. You are in front of the king of these forests. I have a request for you, feeble one. I need three supreme blocks as quickly as possible.",
                        //Repeated, more descriptive phrase
                        "",
                        //Finished phrase
                        "",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemSupremeBlock), 2);
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemSupremeBlock), 2);
                    }
                ),
                QuestPart
                (
                    [
                        //Initial phrase
                        "Minion! I need weapons for my army, bring me three nice axes to give to my guards!",
                        //Repeated, more descriptive phrase
                        "",
                        //Finished phrase
                        "",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemNiceAxe), 3);
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemNiceAxe), 3);
                    }
                ),
                //QuestPart
                //(
                //    [
                //        //Initial phrase
                //        "There is a dire need for housing in the kingdom, I need your help to solve this. Place three houses to fix the housing problems!",
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
            "The kingdom is grateful of your service."
        ));
    }
}
