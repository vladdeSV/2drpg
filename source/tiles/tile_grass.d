import tile;
import enums;
import slump;
import entity_player;
import item_grass;

class TileGrass : Tile
{
    this()
    {
        bool probabilityOfGrass = probabilityOf(4);

        if(probabilityOfGrass)
        {
            _items ~= new ItemGrass(coin() ? '.' : ',');
        }

        super(' ', Color.green, Color.green_dark);
    }
}
