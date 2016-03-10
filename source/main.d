import scone;

import enums;
import game;
import perlin;
import updater;
import world;
import tile;
import std.experimental.logger;
void main()
{
    sconeInit();

    std.experimental.logger.log("Staring");
    Game.running = true;
    Game.frame = new Frame();

    std.experimental.logger.log("Creating world");
    Game.world = new World();
    std.experimental.logger.log("Created world");

    Updater updater = Updater(updateInterval);
    //Updater frameUpdater = Updater(frameInterval);

    int vx, vy;

    updater.resetUpdates();
    //frameUpdater.resetUpdates();
    while(Game.running)
    {
        //Maximum of `enum UPS` ticks per second.
        foreach(i; 0 .. updater.getUpdates())
        {
            //Game.world.update();
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
                else if(input.pressed)
                {
                    if(input.key == SK.up)
                    {
                        --vy;
                    }
                    else if(input.key == SK.down)
                    {
                        ++vy;
                    }
                    else if(input.key == SK.left)
                    {
                        --vx;
                    }
                    else if(input.key == SK.right)
                    {
                        ++vx;
                    }
                }
            }
        }

        Game.frame.clear();
        Tile tErr = new Tile('?', Color.white, Color.red);
        foreach(int y; 0 .. Game.frame.h)
        {
            foreach(int x; 0 .. Game.frame.w)
            {
                Tile tile;
                try
                {
                    tile = Game.world.getChunk((vx + x) / chunkSize, (vy + y) / chunkSize).getTile((vx + x) % chunkSize, (vy + y) % chunkSize);
                }
                catch
                {
                    tile = tErr;
                }

                Game.frame.write(x,y, cast(fg) tile.color, cast(bg) tile.backgroundColor, tile.sprite);
            }
        }
        Game.frame.print();
    }

    sconeClose();
}
