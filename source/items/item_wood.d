import item;
import enums;
import thought;
import entity_player;

class ItemWood : Item
{
    this()
    {
        super("Stick", '/', Color.red_dark);
    }

    override void inspect(EntityPlayer player)
    {
        player.addThought
        ([
            "This is a wooden stick.",
        ]);
    }
}
