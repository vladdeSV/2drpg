import item;
import enums;
import slump;

import entity_player;

class ItemStone : Item
{
    this()
    {
        auto inspects =
        [
            "This stone is black and smooth with razor sharp edges. Flint perhaps?",
            "A flat sandstone, warmed by the sun.",
            "A heavy lump of gray rock.",
            "A DIAMOND!!! No, just kidding it's quartz.",
            "A lump of lava, luckily for me it has solidified.",
            "This has got to be the most ordinary rock in the universe; round and gray.",
            "Another rock! There might be many just like it, but this one, is mine <3",
            "The rock is a lie",
            "This stone might look innocent but you can sense the evil on the inside",
            "Small and covered with green moss, this stone seems friendly.",
            "This rock looks rather stoned",
            "A rolling stone, looks just like Keith",
            "This one is surprisingly light.",
            "Had to be fast catching this rock, it almost got away.",
            "At this pace I'll get stone rich!",
        ];
        super("Stone", ',', Color.black, inspects[random($)]);
    }
}
