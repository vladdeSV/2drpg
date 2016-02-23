import tile;
import entity;
import entity_living;
import enums;

class World
{
    this()
    {
        foreach(row; m_chunks)
        {
            foreach(chunk; row)
            {
                chunk = new Chunk;
            }
        }

        m_entities ~= new EntityLiving(4,4, 'e', "Enemy", Color.green_dark, 10, [Attributes.Strength : 14]);
    }

    auto getChunk(int cx, int cy)
    {
        return m_chunks[cy][cx];
    }

    auto getChunkAtLocation(in int x, in int y)
    {
        return getChunk(x / chunkSize, y / chunkSize);
    }

//private:
    Entity[] m_entities;
    Chunk[worldSize][worldSize] m_chunks;
}

class Chunk
{
    this()
    {
        auto tile = new Tile('.', Color.init, Color.gray);

        foreach(ref row; m_tiles)
        {
            row[] = tile;
        }
    }

    auto getTile(in int x, in int y)
    {
        return m_tiles[y][x];
    }

//private:
    Tile[chunkSize][chunkSize] m_tiles;
}
