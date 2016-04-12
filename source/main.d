/**
 * So far, I would like to change:
 * * Chunk's `Entity[] entities` is public, which should be private
 */

import scone;

import enums;
import updater;
import game;

import world;
import tile;

void main()
{
    sconeInit();

    auto frame = new Frame(80, 24);
    auto updater = Updater(1000/UPS);
    auto cam = Rect(0, 0, wView, frame.h);

    Game.world = new World();
    frame.print();
    updater.resetUpdates();

    Game.running = true;
    while(Game.running)
    {
        frame.clear();

        foreach(i; 0 .. updater.getUpdates())
        {
            Game.world.update();
            //Game.player.update();
            Game.ticks += 1;
        }

        cam.x = cast(int)(Game.player.globalLocation[0] / cam.w) * cam.w;
        cam.y = cast(int)(Game.player.globalLocation[1] / cam.h) * cam.h;
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
        foreach(e; Game.world.getChunkAtLocation(Game.player.globalLocation[0], Game.player.globalLocation[1]).entities)
        {
            int ex = e.globalLocation[0], ey = e.globalLocation[1];
            if(ex >= cam.x && ex < cam.x + cam.w && ey >= cam.y && ey < cam.y + cam.h)
            {
                Color col = e.color;
                Color tbg = Game.world.getTileAt(ex, ey).backgroundColor;
                if(e.color == tbg)
                {
                     col = colorIsDark(col) ? lightColorFromColor(col) : darkColorFromColor(col);
                }

                frame.write(ex - cam.x, ey - cam.y, fg(col), bg(tbg), e.sprite);
            }
        }

        foreach(int y; 0 .. cam.h)
        {
            foreach(int x; cam.w .. cam.w + wSidebar)
            {
                if(!y || y == cam.h - 1 || y == cam.h - 7)
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
        foreach(n, s; Game.player.thoughts)
        {
            int position = eventsStart + n;
            if(position < cam.h - 8)
            {
                frame.write(51, position, s);
            }
            else
            {
                break;
            }
        }

        foreach(n, ref item; Game.player.inventory)
        {
            frame.write(51 + n*2, frame.h - 4, fg(item.color), item.sprite, ' ');
        }

        frame.print();
    }

    sconeClose();
}

struct Rect
{
    int x, y, w, h;
}
