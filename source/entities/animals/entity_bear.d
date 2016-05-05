import game;
import enums;
import quest;

import entity_animal;

import item_wood;
import item_berry;
import item_stone;
import item_axe;

import std.algorithm.mutation : remove;

class EntityBear : EntityAnimal
{
    this(int x, int y)
    {
        super("Baer Grills", x, y, '@', Color.red, new Quest
        (
            ["I am un-bear-able", "Talk", "talky"],
            "Thank you, now we've both helped each other.",
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
                        "Could you give me a rock from the desert?",
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
                        "Could you help me to cut down a tree? Look at the tree and press [F] with the rock equipped.",
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
                        "One last thing, craft me an axe. Make sure you have enough materials, then press [ENTER] in the crafting menu.",
                        "Press [C], then [ENTER] when you have the appropriate materials.",
                        "Aw well, keep the axe too. I don't really mind."
                    ],
                    {
                        return Game.player.hasItem(typeid(ItemAxe));
                    },
                    {}
                ),

            ]
        ));
    }
}

/+ Quest skeleton
QuestPart
(
    [
        "",
        "",
        ""
    ],
    {
        return
    },
    {

    }
),
+/
