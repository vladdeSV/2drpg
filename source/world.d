module world;

import game;
import tile;

class World
{
    this()
    {
        auto tile = new Tile('.');

        m_tiles.length = 20;
        foreach(ref row; m_tiles)
        {
            row.length = 50;
            row[] = tile;
        }
    }

    auto getTile(in uint x, in uint y)
    {
        return m_tiles[y][x];
    }

//private:
    int m_cw, m_ch;
    Tile[][] m_tiles;
    //Chunk[][] m_chunks;
}

//class Chunk
//{
//    this()
//    {
//        auto tile = new Tile('.');

//        m_tiles.length = h;
//        foreach(ref row; m_tiles)
//        {
//            row[] = tile;
//        }
//    }

//private:
//    Tile[][] m_tiles;
//    Direction m_openDirections;
//}

