import scone;

import entity;
import entity_living;
import entity_object;

import tile_sand;
import tile_water;
import tile_rock;
import tile_grass;
import tile_tree;

import enums;
import game;
import perlin;
import tile;

import std.random;
import std.algorithm;
import std.traits;

class World
{
    this()
    {
        //Init all chunks
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
        foreach(input; getInputs())
        {
            //if(input.pressed)
            //{
            //    log("Input: ", input.key);
            //}

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
    int seed = 5;

    //float octaves = 2, persistence = 1, frequency = 0.03;
    //int seed = 5;

    this(int cx, int cy)
    {
        //Random generator depending on seed
        auto gen = Random(seed);

        //Generate terrain
        foreach(int ty, ref row; _tiles)
        {
            foreach(int tx, ref t; row)
            {
                float val = scaled_octave_noise_2d(2, 1, 0.02,      0,10,  (chunkSize*cx) + tx, (chunkSize*cy) + ty, seed);
                float treeVal = scaled_octave_noise_2d(1, 1, 0.05,  0,10,  (chunkSize*cx) + tx, (chunkSize*cy) + ty, seed);
                float sandVal = scaled_octave_noise_2d(1, 1, 0.01,  0,10,  (chunkSize*cx) + tx, (chunkSize*cy) + ty, seed);

                if(val < 2)
                {
                    t = new TileWater(false);
                }
                else if(val < 2.5)
                {
                    t = new TileWater(true);
                }
                else if(val < 3)
                {
                    t = new TileSand(uniform(0, 5, gen));
                }
                else if(val < 7 && sandVal > 8)
                {
                    t = new TileSand(uniform(0, 5, gen));
                    continue;
                }
                else if(val < 8)
                {
                    if(val > 4 && treeVal > 5 && uniform(0, 2, gen) == 0)
                    {
                        TreeType tt;
                        float nv = val - 4;

                        if(nv < 3)
                        {
                            tt = TreeType.redwood;
                        }
                        else
                        {
                            tt = TreeType.dedwood;
                        }

                        t = new TileTree(tt);
                    }
                    else
                    {
                        t = new TileGrass(uniform(0, 8, gen));
                    }

                }
                else if(val < 8.5)
                {
                    t = new TileRock(RockType.mountainLow, uniform(0, 2, gen));
                }
                else if(val < 8.7)
                {
                    t = new TileRock(RockType.mountainMid);
                }
                else
                {
                    t = new TileRock(RockType.mountainHigh);
                }
            }
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

/**
 * A one out of `chance` to return true.
 */
private bool oneOutOf(int chance, Random generator = Random(unpredictableSeed))
{
    return uniform(0, chance, generator) == 0;
}
