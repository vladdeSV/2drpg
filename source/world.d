import scone;
import game;

import tile;
import entity;
import entity_living;
import entity_object;
import enums;

class World
{
    this()
    {
        foreach(row; _chunks)
        {
            foreach(chunk; row)
            {
                chunk = new Chunk;
            }
        }
    }

    void update()
    {
        foreach(input; getInputs())
        {
            if(input.key == SK.ESCAPE)
            {
                Game.running = false;
            }
        }
    }

    auto getChunk(int cx, int cy)
    {
        return _chunks[cy][cx];
    }

    auto getChunkAtLocation(int tx, int ty)
    {
        return getChunk(tx / chunkSize, ty / chunkSize);
    }

private:
    Chunk[worldSize][worldSize] _chunks;
}

class Chunk
{
    this()
    {
        auto tile = new Tile('.', Color.init, Color.gray);

        foreach(ref row; _tiles)
        {
            row[] = tile;
        }
    }

    auto getTile(int tx, int ty)
    {
        return _tiles[ty][tx];
    }

private:
    int _cx, _cy;
    Tile[chunkSize][chunkSize] _tiles;
    Entity[] _entities;
}
