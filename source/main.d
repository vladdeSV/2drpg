import scone;

import enums;
import game;
import perlin;
import updater;
import world;
import tile;
import misc;

import probar;


//import std.stdio;
import std.conv : to;
import std.algorithm : min;
import std.random : Random;
import std.string : wrap;

void main()
{
    sconeInit();

    Game.running = true;
    Game.frame = new Frame(80,24);
    Game.frame.print();

    //>>TODO: set at menu
    Game.gen = Random(Game.seed = 5);
    //<<

    Game.world = new World();

    Updater updater = Updater(updateInterval);
    auto cam = Rect(0, 0, 50, 24);
    //Rect cam = Rect(0, 0, Game.frame.w, Game.frame.h);

    auto memory = Probar(19, 100);

    updater.resetUpdates();
    while(Game.running)
    {
        //Game.frame.clear();

        //>>Ticking
        //Maximum of `enum UPS` ticks per second.
        foreach(i; 0 .. updater.getUpdates())
        {
            Game.world.update();
        }
        //<<

        //>>View of world
        cam.x = cast(int)(Game.world.player.globalLocation[0] / cam.w) * cam.w;
        cam.y = cast(int)(Game.world.player.globalLocation[1] / cam.h) * cam.h;
        foreach(int y; 0 .. cam.h)
        {
            foreach(int x; 0 .. cam.w)
            {
                Tile tile;
                if(cam.x + x >= 0 && cam.x + x < chunkSize * worldSize && cam.y + y >= 0 && cam.y + y < chunkSize * worldSize)
                {
                    tile = Game.world.getChunkAtLocation(cam.x + x, cam.y + y).getTile((cam.x + x) % chunkSize, (cam.y + y) % chunkSize);
                    Game.frame.write(x,y, fg(tile.color), bg(tile.backgroundColor), tile.sprite);
                }
                else
                {
                    Game.frame.write(x,y, fg(Color.red), bg(Color.white), 'X');
                }
            }
        }

        //TODO: Do some sort of check in each chunk that is visible
        foreach(e; Game.world.getChunkAtLocation(Game.world.player.globalLocation[0], Game.world.player.globalLocation[1]).entities)
        {
            int ex = e.globalLocation[0], ey = e.globalLocation[1];
            if(ex >= cam.x && ex < cam.x + cam.w && ey >= cam.y && ey < cam.y + cam.h)
            {
                Color col = e.color;
                Color tbg = Game.world.getChunkAtLocation(ex, ey).getTile(ex % chunkSize, ey % chunkSize).backgroundColor;
                if(e.color == tbg)
                {
                     col = colorIsDark(col) ? lightColorFromColor(col) : darkColorFromColor(col);
                }

                Game.frame.write(ex - cam.x, ey - cam.y, fg(col), bg(tbg), e.sprite);
            }
        }
        //<<

        //>>Side UI
        memory.value = Game.world.player.memory;

        foreach(int y; 0 .. 24)
        {
            foreach(int x; 0 .. 30)
            {
                if(!x || !y || x == 29 || y == 23)
                {
                    Game.frame.write(50 + x, y, fg(Color.black), bg(Color.black_dark), '#');
                }
                else
                {
                    Game.frame.write(50 + x, y, bg(Color.black_dark));
                }
            }
        }

        string mems;
        foreach_reverse(s; Game.world.player.memories)
        {
            mems ~= (wrap(s, 30 - 2) ~ '\n');
        }
        Game.frame.write(51, 4, mems);
        //<<

        Game.frame.write(52, 2, Game.world.player.distanceMoved);

        Game.frame.print();
    }

    Game.frame.clear();
    Game.frame.print();
    sconeClose();
}
