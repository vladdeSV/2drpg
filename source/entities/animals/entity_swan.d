import entity_animal;
import enums;
import quest;
import game;

import item_grass;

class EntitySwag : EntityAnimal
{
    this(int x, int y)
    {
        super("Sven Gnasta", x, y, '@', Color.white, new Quest
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
                        "yo, get me some weed man. i heard its really good. sven' of grass!",
                        "yeah, get me seven grass.",
                        "ey, this is what i needed.",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid(ItemGrass), 7);
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid(ItemGrass), 7);
                    }
                ),
                QuestPart
                (
                    [
                        "hey, i could really use a place to stay, maybe you could make a pretty high house for me?",
                        "yeh a house.",
                        "thank man.",
                    ],
                    {
                        //Check
                        return nearHome();
                    },
                    {
                        //Action
                    }
                ),
            ],
            "so dank, my man."
        ));
    }
}
