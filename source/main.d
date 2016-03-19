import scone;

import enums;
import game;
import perlin;
import updater;
import world;
import tile;

import std.experimental.logger;
import std.random;

void main()
{
    sconeInit();

    Game.running = true;
    Game.frame = new Frame();
    Game.frame.print();

    //>>TODO: set at menu
    Game.seed = 5;
    Game.gen = Random(Game.seed);
    //<<

    Game.world = new World();

    Updater updater = Updater(updateInterval);
    Camera cam = Camera(0, 0, 50, Game.frame.h);

    updater.resetUpdates();
    while(Game.running)
    {
        //Maximum of `enum UPS` ticks per second.
        foreach(i; 0 .. updater.getUpdates())
        {
            //Game.world.update();

            /+
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
            +/
        }

        cam.vx = cast(int)(Game.world.player.globalLocation[0] / cam.vw);
        cam.vy = cast(int)(Game.world.player.globalLocation[1] / cam.vh);

        Game.frame.clear();
        foreach(int y; 0 .. cam.vh)
        {
            foreach(int x; 0 .. cam.vw)
            {
                Tile tile;
                try
                {
                    tile = Game.world
                    .getChunk((cam.vx * Game.frame.w + x) / chunkSize, (cam.vy * Game.frame.h + y) / chunkSize)
                    .getTile ((cam.vx * Game.frame.w + x) % chunkSize, (cam.vy * Game.frame.h + y) % chunkSize);

                    Game.frame.write(x,y, cast(fg) tile.color, cast(bg) tile.backgroundColor, tile.sprite);
                }
                catch
                {
                    Game.frame.write(x,y, cast(fg) Color.red, cast(bg) Color.white, 'X');
                }
            }
        }
        Game.frame.print();
    }

    Game.frame.clear();
    Game.frame.print();

    sconeClose();
}

Camera
{
    int vx, vy, vw, vh;
}
