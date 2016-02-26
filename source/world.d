import tile;
import entity;
import entity_living;
import entity_object;
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
        m_entities ~= new EntityObject(15, 10, '*', Color.gray_dark);

        m_entities ~= new EntityLiving(20, 5, 'p', "Player", Color.green, 100, [Attributes.Strength : 20]);
    }

    auto getChunk(int cx, int cy)
    {
        return m_chunks[cy][cx];
    }

    auto getChunkAtLocation(int tx, int ty)
    {
        return getChunk(tx / chunkSize, ty / chunkSize);
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

    auto getTile(int tx, int ty)
    {
        return m_tiles[ty][tx];
    }

//private:
    Tile[chunkSize][chunkSize] m_tiles;
}
