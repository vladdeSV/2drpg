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
            Game.world.update();
        }

        cam.vx = cast(int)(Game.world.player.globalLocation[0]/* / cam.vw*/);
        cam.vy = cast(int)(Game.world.player.globalLocation[1]/* / cam.vh*/);

        Game.frame.clear();
        foreach(int y; 0 .. cam.vh)
        {
            foreach(int x; 0 .. cam.vw)
            {
                Tile tile;
                try
                {
                    tile = Game.world
                    .getChunk((cam.vx * Game.frame.w) / chunkSize, (cam.vy * Game.frame.h) / chunkSize)
                    .getTile ((cam.vx * Game.frame.w + x) % chunkSize, (cam.vy * Game.frame.h + y) % chunkSize);

                    Game.frame.write(x,y, cast(fg) tile.color, cast(bg) tile.backgroundColor, tile.sprite);
                }
                catch
                {
                    Game.frame.write(x,y, cast(fg) Color.red, cast(bg) Color.white, 'X');
                }
            }
        }
        auto o = Game.world.player;
        Game.frame.write(o.globalLocation[0] % cam.vw, o.globalLocation[1] % cam.vh, cast(fg) o.color, o.sprite);

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
