import scone;

import entity;
import entity_living;
import entity_object;
import entity_player;

import tile;
import tile_sand;
import tile_water;
import tile_mountain;
import tile_grass;
import tile_tree;
import tile_bush;

import event;
import event_time;
import event_distance;

import enums;
import game;
import perlin;
import misc;

import std.random;
import std.algorithm;
import std.traits;
import std.conv : to;

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

        player = new EntityPlayer(108, 150);

        addEntity(player);
        addEntity(new EntityLiving(23, 10, 'D', Color.yellow, "Afromannen", 10, [Attributes.strength : 1]));

        events =
        [
            timeEvent(2, {
                Game.world.player.addThought("Where am I?");
            }),
            timeEvent(8, {
                Game.world.player.addThought("lorem ipsum dolor sit amet swagbpys in the house");
            }),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
            //createEvent({
            //    Game.world.player.addThought("");
            //}),
        ];
    }

    void update()
    {
        foreach(ref e; events)
        {
            e.check();
        }

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

    auto addEntity(Entity e)
    {
        int ex = e.globalLocation[0], ey = e.globalLocation[1];
        getChunkAtLocation(ex, ey).entities ~= e;
    }

    EntityPlayer player;
    Event[] events;

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
                float val =     scaled_octave_noise_2d(2, 1, 0.02, 0,10, (chunkSize*cx) + tx, (chunkSize*cy) + ty, Game.seed);
                float treeVal = scaled_octave_noise_2d(1, 1, 0.05, 0,10, (chunkSize*cx) + tx, (chunkSize*cy) + ty, Game.seed);
                float sandVal = scaled_octave_noise_2d(1, 1, 0.01, 0,10, (chunkSize*cx) + tx, (chunkSize*cy) + ty, Game.seed);

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
                    if(val > 4 && treeVal > 5 && sandVal < 7.5 && chance(2))
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
                        if(chance(300))
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

    Entity[] entities;

private:
    int _cx, _cy;
    Tile[chunkSize][chunkSize] _tiles, _tilesPlaced;
}

