import scone;

import enums;
import game;
import perlin;
import updater;
import world;
import tile;
import tile_err;

import std.experimental.logger;
import std.random;

void main()
{
    sconeInit();

    std.experimental.logger.log("Staring");
    Game.running = true;
    Game.frame = new Frame();
    Game.frame.print();

    //TODO: set at menu
    Game.seed = 5;

    Game.gen = Random(Game.seed);

    std.experimental.logger.log("Creating world");
    Game.world = new World();
    std.experimental.logger.log("Created world");

    Updater updater = Updater(updateInterval);

    int vx, vy;

    updater.resetUpdates();
    while(Game.running)
    {

        //Maximum of `enum UPS` ticks per second.
        foreach(i; 0 .. updater.getUpdates())
        {
            //Game.world.update();
            foreach(input; getInputs())
            {
                if(input.key == SK.escape)
                {
                    Game.running = false;
                }
                //else if(input.pressed)
                //{
                //    if(input.key == SK.up)
                //    {
                //        --vy;
                //    }
                //    else if(input.key == SK.down)
                //    {
                //        ++vy;
                //    }
                //    else if(input.key == SK.left)
                //    {
                //        --vx;
                //    }
                //    else if(input.key == SK.right)
                //    {
                //        ++vx;
                //    }
                //}
            }
        }


        Game.frame.clear();
        foreach(int y; 0 .. Game.frame.h)
        {
            foreach(int x; 0 .. Game.frame.w)
            {
                Tile tile;
                try
                {
                    tile = Game.world.getChunk((vx * Game.frame.w + x) / chunkSize, (vy * Game.frame.h + y) / chunkSize).getTile((vx * Game.frame.w + x) % chunkSize, (vy * Game.frame.h + y) % chunkSize);
                    Game.frame.write(x,y, cast(fg) tile.color, cast(bg) tile.backgroundColor, tile.sprite);
                }
                catch
                {
                    tile = new TileError;
                    Game.frame.write(x,y, cast(fg) tile.color, cast(bg) tile.backgroundColor, tile.sprite);
                }

            }
        }
        Game.frame.print();
    }

    Game.frame.clear();
    Game.frame.print();

    sconeClose();
}
