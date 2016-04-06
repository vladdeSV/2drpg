import scone;

import enums;
import game;
import perlin;
import updater;
import world;
import tile;
import misc;

import event;
import event_time;
import event_distance;
import probar;

import std.conv : to;
import std.algorithm : min;
import std.random : Random;
import std.string : wrap;
import std.array : split;

import std.stdio;

void main()
{
    sconeInit();
    Game.running = true;

    Game.frame = new Frame(80,24);
    Game.world = new World();
    Game.gen = Random(Game.seed = 5);

    Updater updater = Updater(updateInterval);
    auto cam = Rect(0, 0, 50, 24);

    auto frame = Game.frame;
    auto player = Game.world.player;

    Game.frame.print();
    updater.resetUpdates();

    string[] mems;

    while(Game.running)
    {
        frame.clear();

        //>>Ticking
        //Maximum of `enum UPS` ticks per second.
        foreach(i; 0 .. updater.getUpdates())
        {
            Game.world.update();
            Game.ticks += 1;
        }
        //<<

        //>>View of world
        cam.x = cast(int)(player.globalLocation[0] / cam.w) * cam.w;
        cam.y = cast(int)(player.globalLocation[1] / cam.h) * cam.h;
        foreach(int y; 0 .. cam.h)
        {
            foreach(int x; 0 .. cam.w)
            {
                Tile tile;
                if(cam.x + x >= 0 && cam.x + x < chunkSize * worldSize && cam.y + y >= 0 && cam.y + y < chunkSize * worldSize)
                {
                    tile = Game.world.getChunkAtLocation(cam.x + x, cam.y + y).getTile((cam.x + x) % chunkSize, (cam.y + y) % chunkSize);
                    frame.write(x,y, fg(tile.color), bg(tile.backgroundColor), tile.sprite);
                }
                else
                {
                    frame.write(x,y, fg(Color.red), bg(Color.white), 'X');
                }
            }
        }

        //TODO: Do some sort of check in each chunk that is visible
        foreach(e; Game.world.getChunkAtLocation(player.globalLocation[0], player.globalLocation[1]).entities)
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

                frame.write(ex - cam.x, ey - cam.y, fg(col), bg(tbg), e.sprite);
            }
        }
        //<<

        //>>Side UI
        foreach(int y; 0 .. cam.h)
        {
            foreach(int x; cam.w .. cam.w + sidebarWidth)
            {
                if(!y || y == cam.h - 1)
                {
                    frame.write(x, y, fg(Color.black), bg(Color.black_dark), '#');
                }
                else
                {
                    frame.write(x, y, bg(Color.black_dark));
                }
            }
        }

        int eventsStart = 2;
        foreach(n, s; Game.world.player.thoughts)
        {
            int position = eventsStart + n;
            if(position < cam.h - 2)
            {
                frame.write(52, position, s);
            }
            else
            {
                break;
            }
        }
        //<<

        frame.print();
    }

    frame.clear();
    frame.print();
    sconeClose();
}
