import tile;
import enums;
import items;
import entity_player;
import misc;

class TileBush : Tile
{
    this()
    {
        super(TileType.tree, char(5), Color.magenta, Color.green_dark);
    }

    override bool interact(EntityPlayer p)
    {
        if(!_picked)
        {
            int berriesGot = random(2) + 2;

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

            p.berries += berriesGot;

            _picked = true;
            _sprite = '1';
            _color = Color.yellow_dark;
            return true;
        }
        return false;
    }
}
