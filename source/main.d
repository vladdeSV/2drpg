import scone;

import enums;
import game;
import perlin;
import updater;
import world;
import tile;

import std.experimental.logger;
import std.random;

import std.stdio;
import std.conv;

void main()
{
    sconeInit();

    Game.running = true;
    Game.frame = new Frame();
    Game.frame.print();

    //>>TODO: set at menu
    Game.seed = 1;
    Game.gen = Random(Game.seed);
    //<<

    Game.world = new World();

    Updater updater = Updater(updateInterval);
    Camera cam = Camera(0, 0, 80, 24);

    updater.resetUpdates();
    while(Game.running)
    {
        //Maximum of `enum UPS` ticks per second.
        foreach(i; 0 .. updater.getUpdates())
        {
            Game.world.update();
        }

        cam.vx = cast(int)(Game.world.player.globalLocation[0] / cam.vw) * cam.vw;
        cam.vy = cast(int)(Game.world.player.globalLocation[1] / cam.vh) * cam.vh;

        Game.frame.clear();
        foreach(int y; 0 .. cam.vh)
        {
            foreach(int x; 0 .. cam.vw)
            {
                Tile tile;
                try
                {
                    tile = Game.world
                    .getChunkAtLocation(cam.vx  + x, cam.vy + y)
                    .getTile((cam.vx + x) % chunkSize, (cam.vy + y) % chunkSize);

                    Game.frame.write(x,y, cast(fg) tile.color, cast(bg) tile.backgroundColor, tile.sprite);
                }
                catch
                {
                    Game.frame.write(x,y, cast(fg) Color.red, cast(bg) Color.white, 'X');
                }
            }
        }


        //TODO: Do some sort of check in each chunk
        foreach(o; Game.world.getChunkAtLocation(Game.world.player.globalLocation[0], Game.world.player.globalLocation[1])._entities)
        {
            int ex = o.globalLocation[0], ey = o.globalLocation[1];
            if(ex >= cam.vx && ex < cam.vx + cam.vw && ey >= cam.vy && ey < cam.vy + cam.vh)
            {
                Game.frame.write(ex - cam.vx, ey - cam.vy, cast(fg) o.color, o.sprite);
            }
        }

        Game.frame.print();
    }

    Game.frame.clear();
    Game.frame.print();

    sconeClose();
}

struct Camera
{
    int vx, vy, vw, vh;
}
