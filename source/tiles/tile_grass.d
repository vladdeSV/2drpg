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
            item = new ItemGrass(coin() ? '.' : ',');
        }

        super(TileType.grass, s, Color.green, Color.green_dark);
    }

    //override bool interact(EntityPlayer p)
    //{
    //    if(!_used && !p.inventoryFull())
    //    {
    //        if(!p.hasRemembered("grass"))
    //        {
    //            p.remember("grass");
    //            p.addThought("Some plain grass.");
    //        }
    //        else
    //        {
    //            p.addThought
    //            ([
    //                "Neat grass.",
    //                "Some weeds laying around.",
    //                "Cow food.",
    //            ]);
    //        }

    //        _used = true;
    //        _sprite = ' ';
    //    }
    //    else if(p.inventoryFull())
    //    {
    //        p.addThought("I can't grasp more grass.");
    //    }
    //    else
    //    {
    //        return false;
    //    }

    //    return true;
    //}
}
