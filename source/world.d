import enums;
import perlin;
import game;
import slump;

import event;
import event_distance;
import event_time;

import entity;
import entity_living;
import entity_player;
import entity_bear;

import tile;
import tile_berry;
import tile_grass;
import tile_mountain;
import tile_sand;
import tile_tree;
import tile_water;

import std.math : sqrt, abs, pow;

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

        int px = cast(int)((worldSize * chunkSize / wView) / 2 * wView + Game.frame.w / 2);
        int py = cast(int)((worldSize * chunkSize / hView) / 2 * hView + Game.frame.h / 2);

        immutable r = 3;
        foreach(y; py - r .. py + r)
        {
            foreach(x; px - r .. px + r)
            {
                int a = px - x;
                int b = py - y;

                int asq = pow(a, 2);
                int bsq = pow(b, 2);

                if(sqrt(cast(float)(asq + bsq)) <= r)
                {
                    getChunkAtLocation(x,y,).setTile(x, y, new TileGrass());
                }
            }
        }

        auto b = new EntityBear(px, py);
        addEntity(Game.player = new EntityPlayer(px, py));
        addEntity(b);
    }

    void update()
    {
        foreach(ref row; _chunks)
        {
            foreach(ref chunk; row)
            {
                foreach(ref e; chunk.entities)
                {
                    e.update();
                }
            }
        }
    }

    auto getTileAt(float tx, float ty)
    {
        int a = cast(int) tx;
        int b = cast(int) ty;

        return getChunkAtLocation(a, b).getTile(a % chunkSize, b % chunkSize);
    }

    auto getEntityAt(float ex, float ey)
    {
        int a = cast(int) ex;
        int b = cast(int) ey;

        foreach(e; getChunkAtLocation(a, b).entities)
        {
            if(e.globalLocation == [cast(int) ex, cast(int) ey])
            {
                return e;
            }
        }
        return null;
    }

    auto getChunk(int cx, int cy)
    {
        return _chunks[cx][cy];
    }

    auto getChunkAtLocation(int tx, int ty)
    {
        return getChunk(cast(int)(tx / chunkSize), cast(int)(ty / chunkSize));
    }

    auto addEntity(Entity e)
    {
        int ex = e.globalLocation[0], ey = e.globalLocation[1];
        getChunkAtLocation(ex, ey).entities ~= e;
    }

    private Chunk[worldSize][worldSize] _chunks;
}

class Chunk
{
    void setTile(int x, int y, Tile tile)
    {
        _tiles[y % chunkSize][x % chunkSize] = tile;
    }

    this(int cx, int cy)
    {
        //Generate terrain
        foreach(int ty, ref row; _tiles)
        {
            foreach(int tx, ref t; row)
            {
                float val =     scaled_octave_noise_2d(2, 1, 0.02, 0,10, (chunkSize*cx) + tx, (chunkSize*cy) + ty, Game.seed);
                float treeVal = scaled_octave_noise_2d(1, 1, 0.05, 0,10, (chunkSize*cx) + tx, (chunkSize*cy) + ty, Game.seed);
                float sandVal = scaled_octave_noise_2d(1, 1, 0.01, 0,10, (chunkSize*cx) + tx, (chunkSize*cy) + ty, Game.seed);

                if(val < 2.5)
                {
                    t = new TileWater(val);
                }
                else if(val < 3 || val < 7 && sandVal > 8)
                {
                    t = new TileSand();
                }
                else if(val < 8)
                {
                    if(val > 4 && treeVal > 5 && sandVal < 7.5 && chance(2))
                    {
                        t = new TileTree(val);
                    }
                    else
                    {
                        if(chance(300))
                        {
                            t = new TileBerry();
                        }
                        else
                        {
                            t = new TileGrass();
                        }
                    }
                }
                else
                {
                    t = new TileMountain(val);
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

    Entity[] entities;

    private int _cx, _cy;
    private Tile[chunkSize][chunkSize] _tiles, _tilesPlaced;
}


