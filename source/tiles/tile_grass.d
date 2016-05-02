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
        char s = ' ';

        if(probabilityOfGrass)
        {
            _items ~= new ItemGrass(coin() ? '.' : ',');
        }

        super(s, Color.green, Color.green_dark);
    }
}
