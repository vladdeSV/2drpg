import scone;

import entity;
import entity_living;
import entity_object;
import enums;
import game;
import perlin;
import tile;

import std.random;

class World
{
    this()
    {
        foreach(int cx, ref row; _chunks)
        {
            foreach(int cy, ref chunk; row)
            {
                chunk = new Chunk(cx, cy);
            }
        }
    }

    void update()
    {
        import std.experimental.logger;
        foreach(input; getInputs())
        {
            if(input.pressed)
            {
                log("Input: ", input.key);
            }

            if(input.key == SK.escape)
            {
                Game.running = false;
            }
        }
    }

    ref auto getChunk(int cx, int cy)
    {
        return _chunks[cx][cy];
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
    float octaves = 1, persistence = 1, frequency = 0.03;
    int seed = 5;

    this(int cx, int cy)
    {
        auto gen = Random(0);
        foreach(int ty, ref row; _tiles)
        {
            foreach(int tx, ref t; row)
            {
                //Return a value between 0 and 10
                float val = (octave_noise_2d(octaves, persistence, frequency, (chunkSize*cx) + tx, (chunkSize*cy) + ty, seed) + 1) * 5;

                if(val < 2)
                {
                    t = new Tile(' ', Color.blue, Color.blue_dark, true);
                }
                else if(val < 3)
                {
                    t = new Tile('~', Color.blue_dark, Color.blue);
                }
                else if(val < 8)
                {
                    char sp = [',', '.', ' '][uniform(0, $,gen)];
                    t = new Tile(sp, Color.green, Color.green_dark);
                }
                else if(val < 9.5)
                {
                    t = new Tile('*', Color.gray_dark, Color.gray);
                }
                else
                {
                    t = new Tile('^', Color.gray_dark, Color.gray);
                }
            }
        }
    }

    auto getTiles()
    {
        return _tiles;
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
