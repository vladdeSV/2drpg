import entity_animal;
import enums;
import game;
import quest;

import item_axe;
import item_niceaxe;
import item_maxe;

class EntityWolf : EntityAnimal
{
    this(int x, int y)
    {
        super("Marcus Baltimer", x, y, '@', Color.white_dark, new Quest
        (
            [
                //Talk messages
                "Young one, what do you wish to speak of?",
                "Silence is patience.",
                "Travel safe, young one.",
            ],
            this,
            [
                QuestPart
                (
                    [
                        //Initial phrase
                        "Hello child, I have need of your assistance. I am currently in search of an Axe. I would be most grateful if you could bring me one.",
                        //Repeated, more descriptive phrase
                        "Have you brought me the Axe, young one?",
                        //Finished phrase
                        "Pleased.",
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
                        "Hello once again young one, I find that I could use an upgrade of my old axe, could you make me a better one?",
                        //Repeated, more descriptive phrase
                        "Young one, please bring me the Nice axe.",
                        //Finished phrase
                        "So nice of you.",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemNiceAxe));
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemNiceAxe));
                    }
                ),
                QuestPart
                (
                    [
                        //Initial phrase
                        "Young one I have need for your services! On my last hunt for trees I found my axe broken down so I concluded that I need the best of axes, bring me this mythical axe!",
                        //Repeated, more descriptive phrase
                        "I still have need of the Maxe, young one.",
                        //Finished phrase
                        "All's well.",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemMaxe));
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemMaxe));
                    }
                ),
            ],
            "My thanks, to you."
        ));
    }
}
