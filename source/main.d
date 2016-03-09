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

    Game.running = true;
    std.experimental.logger.log("Start");

    Game.frame = new Frame();

    std.experimental.logger.log("Creating world");
    Game.world = new World();
    std.experimental.logger.log("Done");

    Updater updater = Updater(updateInterval);
    Updater frameUpdater = Updater(frameInterval);

    updater.resetUpdates();
    frameUpdater.resetUpdates();
    while(Game.running)
    {
        //Maximum of `enum UPS` ticks per second.
        foreach(i; 0 .. updater.getUpdates())
        {
            Game.world.update();
        }

        Game.frame.clear();
        foreach(int y; 0 .. Game.frame.h)
        {
            foreach(int x; 0 .. Game.frame.w)
            {
                Tile tile = Game.world.getChunk(x / chunkSize, y / chunkSize).getTile(x % chunkSize, y % chunkSize);

                Game.frame.write(x,y, cast(fg) tile.color, cast(bg) tile.backgroundColor, tile.sprite);
            }
        }
        Game.frame.print();
    }

    sconeClose();
}
