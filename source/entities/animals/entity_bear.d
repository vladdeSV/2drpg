import game;
import enums;
import quest;

import entity_animal;

import item_wood;
import item_berry;
import item_stone;
import item_axe;
import item_beartreat;

import std.algorithm.mutation : remove;

class EntityBear : EntityAnimal
{
    this(int x, int y)
    {
        super("Baer Grills", x, y, '@', Color.red, new Quest
        (
            [
                "Most people tell me I'm nice, but I am actually un-bear-able.",
                "There are many others out around here. Tell them hello from me!",
                "I've heard that there is a limit, and after comes the void.",
                "Did you know you can drop items with [Q].",
                "Interact with [F].",
                "Pick up items with [E].",
            ],
            this,
            [
                QuestPart
                (
                    [
                        "Help a pal out? Could I have a berry? Pick one with [E] or [F].",
                        "Pick up a berry with [E] or [F]",
                        "Mmm, thanks a lot, buddy!"
                    ],
                    {
                        return Game.player.hasItem(typeid(ItemBerry));
                    },
                    {
                        Game.player.removeItem(typeid(ItemBerry));
                    }
                ),
                QuestPart
                (
                    [
                        "Could you pick a rock for me from the sand?",
                        "Pick one the same way you did with the berries, press [E].",
                        "Hmm... Keep the rock, I know something else you can do."
                    ],
                    {
                        return Game.player.hasItem(typeid(ItemStone));
                    },
                    {}
                ),
                QuestPart
                (
                    [
                        "Could you help me to cut down a tree? Look at the tree and press [F] a couple of times with the rock equipped.",
                        "Make sure you are holding the stone, and press [F].",
                        "Wohoo! You sure are nice pal."
                    ],
                    {
                        return Game.player.hasItem(typeid(ItemWood));
                    },
                    {
                        Game.player.removeItem(typeid(ItemWood));
                    }
                ),
                QuestPart
                (
                    [
                        "Did you know you could bring up your crafting by pressing [C].",
                        "Press [C] to bring up the crafting menu.",
                        "Super!"
                    ],
                    {
                        return Game.player.hasRemembered("crafting");
                    },
                    {}
                ),
                QuestPart
                (
                    [
                        "One last thing, craft me an bear treat. Make sure you have enough materials, then press [ENTER] in the crafting menu.",
                        "Press [C], then [ENTER] when you have the appropriate materials.",
                        "Thanks bud'."
                    ],
                    {
                        return Game.player.hasItem(typeid(ItemBearTreat));
                    },
                    {
                        Game.player.removeItem(typeid(ItemBearTreat));
                    }
                ),
            ],
            "Thanks for the help, bud'!"
        ));
    }
}

/+ Quest skeleton
, new Quest
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
                        "",
                        //Repeated, more descriptive phrase
                        "",
                        //Finished phrase
                        "",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid());
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid());
                    }
                ),
                QuestPart
                (
                    [
                        //Initial phrase
                        "",
                        //Repeated, more descriptive phrase
                        "",
                        //Finished phrase
                        "",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid());
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid());
                    }
                ),
                QuestPart
                (
                    [
                        //Initial phrase
                        "",
                        //Repeated, more descriptive phrase
                        "",
                        //Finished phrase
                        "",
                    ],
                    {
                        //Check
                        return Game.player.hasItem(typeid());
                    },
                    {
                        //Action
                        Game.player.removeItem(typeid());
                    }
                ),
            ],
            ""
        )
+/
