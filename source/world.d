import scone;

import entity;
import entity_living;
import entity_object;
import entity_player;

import tile_sand;
import tile_water;
import tile_mountain;
import tile_grass;
import tile_tree;
import tile_bush;

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

        player = new EntityPlayer(10, 10);

        _chunks[0][0]._entities ~= player;
        _chunks[0][0]._entities ~= new EntityLiving(100, 10, 'D', Color.yellow, "lol", 10, [Attributes.strength : 1]);
    }

    void update()
    {
        player.update();
    }

    auto getChunk(int cx, int cy)
    {
        return _chunks[cx][cy];
    }

    auto getChunkAtLocation(int tx, int ty)
    {
        return getChunk(tx / chunkSize, ty / chunkSize);
    }

    EntityPlayer player;

private:
    Chunk[worldSize][worldSize] _chunks;
}

class Chunk
{
    this(int cx, int cy)
    {
        //Generate terrain
        foreach(int ty, ref row; _tiles)
        {
            foreach(int tx, ref t; row)
            {
                float val = scaled_octave_noise_2d(2, 1, 0.02,      0,10,  (chunkSize*cx) + tx, (chunkSize*cy) + ty, Game.seed);
                float treeVal = scaled_octave_noise_2d(1, 1, 0.05,  0,10,  (chunkSize*cx) + tx, (chunkSize*cy) + ty, Game.seed);
                float sandVal = scaled_octave_noise_2d(1, 1, 0.01,  0,10,  (chunkSize*cx) + tx, (chunkSize*cy) + ty, Game.seed);

                if(val < 2)
                {
                    t = new TileWater(false);
                }
                else if(val < 2.5)
                {
                    t = new TileWater(true);
                }
                else if(val < 3 || val < 7 && sandVal > 8)
                {
                    t = new TileSand();
                }
                else if(val < 8)
                {
                    if(val > 4 && treeVal > 5 && uniform(0, 2, Game.gen) == 0)
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
                        if(uniform(0, 300, Game.gen) == 0)
                        {
                            t = new TileBush();
                        }
                        else
                        {
                            t = new TileGrass();
                        }
                    }
                }
                else if(val < 8.5)
                {
                    t = new TileMountain(MountainLevel.low);
                }
                else if(val < 8.7)
                {
                    t = new TileMountain(MountainLevel.mid);
                }
                else
                {
                    t = new TileMountain(MountainLevel.high);
                }
            }
        }
    }

    auto getTile(int tx, int ty)
    {
        if(_tilesPlaced[ty][tx] !is null)
        {
            return _tilesPlaced[ty][tx];
        }
        else
        {
            return _tiles[ty][tx];
        }
    }

    Entity[] _entities;
private:
    int _cx, _cy;
    Tile[chunkSize][chunkSize] _tiles, _tilesPlaced;
}
