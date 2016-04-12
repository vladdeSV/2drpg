import tile;
import enums;
import slump;
import entity_player;
import item_grass;

class TileGrass : Tile
{
    this()
    {
        bool chanceGrass = chance(4);
        char s = ' ';

        if(chanceGrass)
        {
            s = chance(2) ? '.' : ',';
        }
        else
        {
            _used = true;
        }

        super(TileType.grass, s, Color.green, Color.green_dark);
    }

    override bool interact(EntityPlayer p)
    {
        if(!_used && !p.inventoryFull())
        {
            if(!p.hasRemembered("grass"))
            {
                p.remember("grass");
                p.addThought("Some plain grass.");
            }
            else
            {
                p.addThought
                ([
                    "asd.",
                    "lorem itpis.",
                    "gsdfkjd.",
                    "hello yellow",
                ]);
            }

            p.addItem(new ItemGrass());

            _used = true;
            _sprite = ' ';
        }
        else if(p.inventoryFull())
        {
            p.addThought("I can't take more grass.");
        }

        return true;
    }
}
