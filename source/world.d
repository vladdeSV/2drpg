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
        foreach(row; m_chunks)
        {
            foreach(chunk; row)
            {
                chunk = new Chunk;
            }
        }

        m_entities ~= new EntityLiving(4,4, 'e', "Enemy", Color.gray_dark, 10, [Attributes.Strength : 14]);
        m_entities ~= new EntityLiving(6,10, 'e', "Enemy", Color.gray_dark, 10, [Attributes.Strength : 14]);
        m_entities ~= new EntityLiving(20,2, 'e', "Enemy", Color.gray_dark, 10, [Attributes.Strength : 14]);

        m_entities ~= new EntityLiving(20, 5, 'p', "Player", Color.white, 100, [Attributes.Strength : 20]);
    }

    void update()
    {
        foreach(input; getInputs())
        {
            if(input.key == SK.ESCAPE)
            {
                Game.running = false;
            }

            if(input.pressed)
            {
                if(input.key == SK.UP)
                {
                    m_entities[$ - 1].m_y -= 1;
                }
                else if(input.key == SK.DOWN)
                {
                    m_entities[$ - 1].m_y += 1;
                }
                else if(input.key == SK.RIGHT)
                {
                    m_entities[$ - 1].m_x += 1;
                }
                else if(input.key == SK.LEFT)
                {
                    m_entities[$ - 1].m_x -= 1;
                }
            }
        }
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

private:
    int m_cx, m_cy;
    Tile[chunkSize][chunkSize] m_tiles;
}
