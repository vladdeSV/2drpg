import tile;
import enums;
import items;
import item;
import entity_player;

class TileBush : Tile
{
    this()
    {
        super(TileType.tree, char(5), Color.magenta, Color.green_dark);
    }

    override void interact(EntityPlayer p)
    {
        if(!_picked)
        {
            p.addThought("Berries");
            p.items ~= cast(Item)ListItemConsumable["strawberries"];
            _picked = true;
            _sprite = '1';
            _color = Color.yellow_dark;
        }
    }

    private bool _picked;
}
