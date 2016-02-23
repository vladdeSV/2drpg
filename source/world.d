import tile;
import entity;
import enums;

class World
{
    this()
    {
        m_chunks = new Chunk[][](1,1);
        m_entities ~= new Entity(4,4, 'e');
    }

    auto getChunk(in int cx, in int cy)
    {
        return m_chunks[cy][cx];
    }

    auto getChunkAtLocation(in int x, in int y)
    {
        return m_chunks[y / chunkSize][x / chunkSize];
    }

//private:
    Entity[] m_entities;
    Chunk[][] m_chunks;
}

class Chunk
{
    this()
    {
        auto tile = new Tile('.');

        m_tiles.length = chunkSize;
        foreach(ref row; m_tiles)
        {
            row.length = chunkSize;
            row[] = tile;
        }
    }

    auto getTile(in int x, in int y)
    {
        return m_tiles[y][x];
    }

private:
    Tile[][] m_tiles;
}
