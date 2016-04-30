import item;
import enums;
import thought;
import entity_player;
import slump;

class ItemWood : Item
{
    this()
    {
        super("Stick", '/', Color.red_dark, inspects[random($)]);
    }
}

string[] inspects =
[
    "This thick branch looks useful.",
    "Hazel, slender and bendable.",
    "Oak, hard and strong.",
    "Birch, soft and flexible.",
    "Ash, I wish there was a Pikachu tree...",
    "Elm, it has tons of leaves.",
    "Maple, maybe I'm in Canada?",
    "Woody, I wonder where Buzz is.",
    "A branch from an enormous redwood tree.",
    "A twiggy branch.",
    "Evergreen, it has tons of little green sharp things on it.",
    "Hmm, this would make a great fishing rod.",
    "A strong piece of wood.",
    "A mighty sword! That is at least what pretended it was when I was, like, six.",
];
