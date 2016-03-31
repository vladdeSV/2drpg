import tile;
import enums;
import game;
import misc;

import std.random;

class TileGrass : Tile
{
    GrassType type;

    this()
    {
        //bool cf = chance(50);
        bool cg = chance(2);
        Color c = Color.green;
        char s = ' ';

        /*if(cf)
        {
            type = GrassType.flower;
        }
        else */
        if(cg)
        {
            type = GrassType.grass;
        }
        else
        {
            type = GrassType.none;
        }

        if(type == GrassType.grass)
        {
            s = chance(2) ? '.' : ',';
            c = Color.green;
        }
        else if(type == GrassType.flower)
        {
            int ft = random(4);

            s = '*';

            if(ft == 0)
            {
                c = Color.magenta;
            }
            else if(ft == 1)
            {
                c = Color.yellow;
            }
            else if(ft == 2)
            {
                c = Color.blue;
            }
            else if(ft == 3)
            {
                c = Color.cyan;
            }
        }

        super(s,c,Color.green_dark);
        //int grassType = uniform(0, 5, Game.gen);
        //char grassSprite = ' ';
        //if(grassType < 2)
        //{
        //    //grassType is either 0 or 1
        //    grassSprite = grassType ? '.' : ',';
        //}
        //
        //super(grassSprite, Color.green, Color.green_dark);
    }
}

enum GrassType
{
    none,
    grass,
    flower,
}
