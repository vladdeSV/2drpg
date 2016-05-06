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
import entity_bison;
import entity_boar;
import entity_moose;
import entity_otter;
import entity_pig;
import entity_racoon;
import entity_sparrow;
import entity_swan;
import entity_turtle;
import entity_wolf;

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
        foreach(ty; 0 .. chunkSize * worldSize)
        {
            foreach(tx; 0 .. chunkSize * worldSize)
            {
                mainVal[ty][tx] = scaled_octave_noise_2d(2, 1, 0.02, 0,10, tx, ty, Game.seed);
                treeVal[ty][tx] = scaled_octave_noise_2d(1, 1, 0.05, 0,10, tx, ty, Game.seed);
                sandVal[ty][tx] = scaled_octave_noise_2d(1, 1, 0.01, 0,10, tx, ty, Game.seed);
            }
        }

        int px = cast(int)((chunkSize * worldSize / 2 + xoffset) / wView) * wView - xoffset + cast(int)((wView + wSidebar) / 2);
        int py = cast(int)((chunkSize * worldSize / 2 + yoffset) / hView) * hView - yoffset + cast(int)(hView / 2);

        //int px = cast(int)((worldSize * chunkSize / wView) / 2 * wView /*+ Game.frame.w / 2*/);
        //int py = cast(int)((worldSize * chunkSize / hView) / 2 * hView /*+ Game.frame.h / 2*/);

        Entity[] animals =
        [
            new EntityWolf(random(chunkSize*worldSize), random(chunkSize*worldSize)),
            new EntityBison(random(chunkSize*worldSize), random(chunkSize*worldSize)),
            new EntityBoar(random(chunkSize*worldSize), random(chunkSize*worldSize)),
            new EntityMoose(random(chunkSize*worldSize), random(chunkSize*worldSize)),
            new EntityOtter(random(chunkSize*worldSize), random(chunkSize*worldSize)),
            new EntityBear(px - 5, py - 3),
            new EntityPig(random(chunkSize*worldSize), random(chunkSize*worldSize)),
            new EntityRacoon(random(chunkSize*worldSize), random(chunkSize*worldSize)),
            new EntitySparrow(random(chunkSize*worldSize), random(chunkSize*worldSize)),
            new EntitySwag(random(chunkSize*worldSize), random(chunkSize*worldSize)),
            new EntityTurtle(random(chunkSize*worldSize), random(chunkSize*worldSize)),
        ];

        softenPoint(px, py, 10);

        foreach(e; animals)
        {
            softenPoint(e.globalLocation[0], e.globalLocation[1], 10);
        }

        //Init all chunks
        foreach(int cx, ref row; _chunks)
        {
            foreach(int cy, ref chunk; row)
            {
                chunk = new Chunk(cx, cy);
            }
        }

        addEntity(Game.player = new EntityPlayer(px, py));

        foreach(e; animals)
        {
            addEntity(e);
        }
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
        foreach(e; getChunkAtLocation(cast(int) ex, cast(int) ey).entities)
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

    auto chunks() @property
    {
        return _chunks;
    }

    private Chunk[worldSize][worldSize] _chunks;

}

private float[chunkSize * worldSize][chunkSize * worldSize] mainVal, treeVal, sandVal;

private void softenPoint(int tx, int ty, int r)
{
    foreach(y; ty - r .. ty + r)
    {
        foreach(x; tx - r .. tx + r)
        {
            int a = tx - x;
            int b = ty - y;

            int asq = pow(a, 2);
            int bsq = pow(b, 2);

            float c = sqrt(cast(float)(asq + bsq));

            if(c <= r)
            {
                if(x >= 0 && y >= 0 && x < chunkSize*worldSize && y < chunkSize*worldSize)
                {
                    mainVal[y][x] = (mainVal[y][x] - 5) * c / r + 5;
                    treeVal[y][x] = treeVal[y][x] - (r - c);
                }
            }
        }
    }
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
                float val  = mainVal[cy * chunkSize + ty][cx * chunkSize + tx];
                float sand = sandVal[cy * chunkSize + ty][cx * chunkSize + tx];
                float tree = treeVal[cy * chunkSize + ty][cx * chunkSize + tx];

                if(val < 2.5)
                {
                    t = new TileWater(val);
                }
                else if(val < 3 || val < 7 && sand > 8)
                {

                    t = new TileSand();
                }
                else if(val < 8)
                {
                    if(val > 4 && tree > 5 && sand < 7.5 && probabilityOf(2))
                    {
                        t = new TileTree(val);
                    }
                    else
                    {
                        if(probabilityOf(300))
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
