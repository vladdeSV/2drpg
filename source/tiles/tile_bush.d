import tile;
import enums;
import items;
import entity_player;
import random;
import items;

class TileBush : Tile
{
    this()
    {
        super(TileType.tree, char(5), Color.magenta, Color.green_dark);
    }

    override void interact(EntityPlayer p)
    {
        if(!_picked && !p.inventoryFull())
        {
            int berriesGot = random(2) + 1;

            string berryName;

            switch(random(3))
            {
                default:
                case 0:
                berryName = "strawberries";
                break;
                case 1:
                berryName = "blueberries";
                break;
                case 2:
                berryName = "raspberries";
                break;
            }

            if(!p.remember("berries"))
            {
                p.addThought("These looks like edible berries.");
            }
            else
            {
                p.addThought([
                    "Look, more berries.",
                    "Oh, berries.",
                    "I like berries.",
                    "Berries are yummy.",
                ]);
            }

            p.addItem(ListItemConsumable[berryName]);

            _picked = true;
            _sprite = '1';
            _color = Color.yellow_dark;
        }
        else
        {
            p.addThought("My pockets do not fit more berries.");
        }
    }
}
