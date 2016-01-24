module world;

import type;

class World
{

    this(int cw, int ch)
    {
        m_chunkWidth = cw;
        m_chunkHeight = ch;
    }

    const int m_chunkWidth, m_chunkHeight;
    Chunk[] m_chunks;
}

class Chunk
{
    this(int w, int h)
    {

        auto defTile = new Type();
        defTile.addAttribute!auSprite;
        defTile.addAttribute!atSolid(false);

        m_tiles.length = h;
        foreach(ref row; m_tiles)
        {
            row[] = defTile;
        }
    }

private:
    Type[][] m_tiles;
    ChunkOpenDirection m_chunkOpenDirections;
}

enum ChunkOpenDirection
{
    Up = 1,
    Right = 2,
    Down = 4,
    Left = 8
}
