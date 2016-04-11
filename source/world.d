import enums;
import perlin;
import game;
import slump;

import event;
import event_distance;
import event_time;

import entity;
import entity_player;

import tile;
import tile_barrier;
import tile_berry;
import tile_grass;
import tile_mountain;
import tile_sand;
import tile_tree;
import tile_water;

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

        EntityPlayer player = new EntityPlayer(108, 150);
        Game.player = player;

        addEntity(player);
        //addEntity(new EntityLiving(23, 10, 'D', Color.yellow, "Afromannen", 10));

        //gör en array av events, varpå du endast läseer av ID från Google Drive
        _events =
        [
            timeEvent(2, {
               player.addThought(player.name);
            }),
            checkEvent(
            {
                return player.warmth < 3;
            },
            {
                if(player.warmth < 1)
                {
                    player.addThought("I'm freezing...");
                }
                else
                {
                    player.addThought("It's very cold...");
                }
            }, 20),
            checkEvent(
            {
                return player.warmth > 9;
            },
            {
               player.addThought("It's hot!");
            }, 20),
            distanceEvent(1_000,
            {
               player.addThought("I've walked quite far.");
            }),
            distanceEvent(10_000,
            {
               player.addThought("Why do I keep on walking? Why do I keep on keeping on?");
            }),
            distanceEvent(100_000,
            {
               player.addThought("I have walked for so long but even now it doesn't matter.");
            }),
            distanceEvent(1_000_000,
            {
               player.addThought("[We never planned for someone to walk this much, congrats, I guess] //Vladde och Fredde");
            }),
            //checkEvent({
            //   player.addThought("");
            //}),
            //checkEvent({
            //   player.addThought("");
            //}),
            //checkEvent({
            //   player.addThought("");
            //}),
        ];
    }

    void update()
    {
        foreach(ref e; _events)
        {
            e.check();
        }

        Game.player.update();
    }

    auto getTileAt(int tx, int ty)
    {
        return getChunkAtLocation(tx, ty).getTile(tx % chunkSize, ty % chunkSize);
    }

    auto getChunk(int cx, int cy)
    {
        return _chunks[cx][cy];
    }

    auto getChunkAtLocation(int tx, int ty)
    {
        return getChunk(tx / chunkSize, ty / chunkSize);
    }

    auto addEntity(Entity e)
    {
        int ex = e.globalLocation[0], ey = e.globalLocation[1];
        getChunkAtLocation(ex, ey).entities ~= e;
    }

private:
    Chunk[worldSize][worldSize] _chunks;
    Event[] _events;
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
                if((!cx && !tx) || (!cy && !ty) || (cx == worldSize - 1 && tx == chunkSize - 1) || (cy == worldSize - 1 && ty == chunkSize - 1))
                {
                    t = new TileBarrier();
                    continue;
                }
                float val =     scaled_octave_noise_2d(2, 1, 0.02, 0,10, (chunkSize*cx) + tx, (chunkSize*cy) + ty, Game.seed);
                float treeVal = scaled_octave_noise_2d(1, 1, 0.05, 0,10, (chunkSize*cx) + tx, (chunkSize*cy) + ty, Game.seed);
                float sandVal = scaled_octave_noise_2d(1, 1, 0.01, 0,10, (chunkSize*cx) + tx, (chunkSize*cy) + ty, Game.seed);

                if(val < 2)
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

private:
    int _cx, _cy;
    Tile[chunkSize][chunkSize] _tiles, _tilesPlaced;
}


