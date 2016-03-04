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

        _entities ~= new EntityLiving(4,4, 'e', "Enemy", Color.gray_dark, 10, [Attributes.Strength : 14]);
        _entities ~= new EntityLiving(6,10, 'e', "Enemy", Color.gray_dark, 10, [Attributes.Strength : 14]);
        _entities ~= new EntityLiving(20,2, 'e', "Enemy", Color.gray_dark, 10, [Attributes.Strength : 14]);

        _entities ~= new EntityLiving(20, 5, 'p', "Player", Color.white, 100, [Attributes.Strength : 20]);
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
                    _entities[$ - 1]._y -= 1;
                }
                else if(input.key == SK.DOWN)
                {
                    _entities[$ - 1]._y += 1;
                }
                else if(input.key == SK.RIGHT)
                {
                    _entities[$ - 1]._x += 1;
                }
                else if(input.key == SK.LEFT)
                {
                    _entities[$ - 1]._x -= 1;
                }
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

//private:
    Entity[] _entities;
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
}
