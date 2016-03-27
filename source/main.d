import scone;

import enums;
import game;
import perlin;
import updater;
import world;
import tile;

import std.random : Random;

//import std.stdio;
import std.conv : to;
import std.algorithm : min;

void main()
{
    sconeInit();

    Game.running = true;
    Game.frame = new Frame();
    Game.frame.print();

    //>>TODO: set at menu
    Game.gen = Random(Game.seed = 5);
    //<<

    Game.world = new World();

    Updater updater = Updater(updateInterval);
    //Camera cam = Camera(0, 0, min(Game.frame.w, chunkSize), min(Game.frame.h, chunkSize));
    Camera cam = Camera(0, 0, Game.frame.w, Game.frame.h);

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

        //TODO: Do some sort of check in each chunk that is visible
        foreach(e; Game.world.getChunkAtLocation(Game.world.player.globalLocation[0], Game.world.player.globalLocation[1]).entities)
        {
            int ex = e.globalLocation[0], ey = e.globalLocation[1];
            if(ex >= cam.vx && ex < cam.vx + cam.vw && ey >= cam.vy && ey < cam.vy + cam.vh)
            {
                Color tbg = Game.world.getChunkAtLocation(ex, ey).getTile(ex % chunkSize, ey % chunkSize).backgroundColor;
                if(e.color == tbg)
                {
                    tbg = Color.black;
                }

                Game.frame.write(ex - cam.vx, ey - cam.vy, cast(fg) e.color, cast(bg) tbg, e.sprite);
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
