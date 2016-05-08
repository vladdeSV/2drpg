import entity_animal;
import enums;
import quest;
import game;

import item_berry;
import item_sweetsalad;

class EntityRacoon : EntityAnimal
{
    this(int x, int y)
    {
        super("Coop Slyman", x, y, '@', Color.black, new Quest
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
                        "Do you know what a Raccoon like me really loves? Berries, a lot of berries. It would be awesome if you could get me some, lets say three!",
                        //Repeated, more descriptive phrase
                        "",
                        //Finished phrase
                        "",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemBerry), 3);
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemBerry), 3);
                    }
                ),
                QuestPart
                (
                    [
                        //Initial phrase
                        "My friend was once on a quiz show and he couldn't figure out what could possibly be better than berries. I know the answer. More berries, give me as many as you can carry!",
                        //Repeated, more descriptive phrase
                        "I think 8 berries will do.",
                        //Finished phrase
                        "",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemBerry), 8);
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemBerry), 8);
                    }
                ),
                //QuestPart
                //(
                //    [
                //        //Initial phrase
                //        "",
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
                QuestPart
                (
                    [
                        //Initial phrase
                        "My mother always said that I had a berry addiction, I told her to give me more berries! But she always gave me salad instead, so I put my berries in the salad. Could you get me some of that please?",
                        //Repeated, more descriptive phrase
                        "",
                        //Finished phrase
                        "",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemSweetSalad), 3);
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemSweetSalad), 3);
                    }
                ),
                //QuestPart
                //(
                //    [
                //        //Initial phrase
                //        "Hey! You know what, I need somewhere to store more berries, could you make me a house where so that I could put them somewhere?",
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
            "I love berries, berries, berries, berries..."
        ));
    }
}
