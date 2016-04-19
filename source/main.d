/**
 * So far, I would like to change:
 * * Chunk's `Entity[] entities` is public, which should be private
 */
import scone;

import enums;
import slump;
import time;
import updater;
import game;
import flags;

import world;

import tile;
import tile_sand;
import tile_berry;
import item_stone;

import std.algorithm : max, min;
import std.algorithm.searching : findSplitAfter;

void main()
{
    sconeInit();

    auto frame = new Frame();
    Game.frame = frame;
    auto updater = Updater(1000/UPS);
    wSidebar = max(30, cast(int)(frame.w / 4));
    wView = frame.w - wSidebar;
    hView = frame.h;
    auto cam = Rect(0, 0,wView, max(24, hView));

    Game.world = new World();
    frame.print();
    updater.resetUpdates();

    Game.running = true;

    //Force update of player;
    Game.player.update();
    while(Game.running)
    {
        frame.clear();

        foreach(i; 0 .. updater.getUpdates())
        {
            Game.world.update();
            Game.ticks += 1;
        }

        int px = Game.player.globalLocation[0];
        int py = Game.player.globalLocation[1];

        cam.x = cast(int)(px / cam.w) * cam.w/* + cast(int)(((chunkSize * worldSize) % cam.w) / 2)*/;
        cam.y = cast(int)(py / cam.h) * cam.h/* + cast(int)(((chunkSize * worldSize) % cam.h) / 2)*/;

        if(!Game.player.hasRemembered("stuck"))
        {
            foreach(int y; 0 .. cam.h)
            {
                foreach(int x; 0 .. cam.w)
                {
                    Tile tile;
                    if(cam.x + x >= 0 && cam.x + x < chunkSize * worldSize && cam.y + y >= 0 && cam.y + y < chunkSize * worldSize)
                    {
                        tile = Game.world.getTileAt(cam.x + x, cam.y + y);

                        frame.write(x,y, fg(!tile.items.length ? tile.color : (tile.items.length > 1 ? Color.red_dark : (tile.items[$-1].color))), bg(tile.backgroundColor), !tile.items.length ? tile.sprite : (tile.items.length > 1 ? char(30) : tile.items[$-1].sprite));
                        //frame.write(x,y, fg(tile.color), bg(tile.backgroundColor), tile.sprite);
                    }
                    else
                    {
                        frame.write(x,y, fg(Color.magenta_dark), bg(Color.black_dark), chance(2000) ? (coin() ? ',' : '.') : ' ');
                    }
                }
            }
        }

        //TODO: Do some sort of check in each chunk that is visible

        if(Game.player.hasRemembered("stuck"))
        {
            auto e = Game.player;
            frame.write(e.globalLocation[0] - cam.x, e.globalLocation[1] - cam.y, fg(e.color), bg(Color.black_dark), e.sprite);
        }
        else
        {
            foreach(e; Game.world.getChunkAtLocation(px, py).entities)
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
        }

        immutable sidebarStart = wView + 2;

        if(Game.player.hasRemembered("sideui"))
        {
            foreach(int y; 0 .. hView)
            {
                foreach(int x; wView .. wView + wSidebar)
                {
                    if(!y || y == cam.h - 1 || y == cam.h - 7 || x == cam.w)
                    {
                        frame.write(x, y, fg(Color.black), bg(Color.black_dark), '#');
                    }
                    else
                    {
                        frame.write(x, y, bg(Color.black_dark));
                    }
                }
            }

            frame.write(sidebarStart + Game.player.maxItems * 2, frame.h - 3, '|');
        }

        int eventsStart = 2;
        foreach(n, s; Game.player.thoughts)
        {
            int position = eventsStart + n;
            if(position < cam.h - 8)
            {
                frame.write(sidebarStart, position, s);
            }
            else
            {
                break;
            }
        }

        if(Game.player.inventory.length)
        {
            if(Game.player.inventory.length > 1)
            {
                frame.write(sidebarStart - 1 + Game.player.selectedListItem * 2, frame.h - 2, char(27), ' ', char(26));
            }

            frame.write(sidebarStart, frame.h - 4, Game.player.inventory[Game.player.selectedListItem].name);

            foreach(n, ref item; Game.player.inventory)
            {
                frame.write(sidebarStart + n * 2, frame.h - 3, fg(item.color), item.sprite, ' ');
            }

            if(Game.player.inventory[Game.player.selectedListItem].usable)
            {
                frame.write(frame.w - 4, frame.h - 3, fg(Color.yellow), '[', fg(Color.white), 'U', fg(Color.yellow), ']');
            }

            frame.write(sidebarStart + Game.player.selectedListItem * 2 - 1, frame.h - 3, '[');
            frame.write(sidebarStart + Game.player.selectedListItem * 2 + 1, frame.h - 3, ']');
        }

        //>>CRAFTING SYSTEM
        if(Game.player.crafting)
        {
            immutable sideSpacing = 2;

            foreach(y; 0 .. hView - sideSpacing*2)
            {
                foreach(x; 0 .. 45)
                {
                    if(!x || !y || x == 44 || y == hView - sideSpacing*2-1)
                    {
                        Game.frame.write(sideSpacing + x, sideSpacing + y, fg(Color.white_dark), bg(Color.black_dark), char(4));
                    }
                    else
                    {
                        Game.frame.write(sideSpacing + x, sideSpacing + y, bg(Color.black_dark), ' ');
                    }
                }
            }

            int yaxis;
            import std.traits;
            foreach(craftNumber, craft; CraftList)
            {
                int[] itemCount = new int[](craft.parts.length);

                foreach(item; Game.player.inventory)
                {
                    foreach(m, part; craft.parts)
                    {
                        if(typeid(item) == part[0])
                        {
                            itemCount[m] += 1;
                        }
                    }
                }

                string craftName = ' ' ~ craft.desc;
                if(craftNumber == Game.player.selectedCraftItem)
                {
                    craftName = text(char(16), craftName);
                    //frame.write(sideSpacing + 2, sideSpacing + 1 + yaxis, char(24));
                    //frame.write(sideSpacing + 2, sideSpacing + 3 + yaxis, char(25));
                }

                frame.write(sideSpacing + 1, sideSpacing + 2 + yaxis, ' ', craftName);

                foreach(aaa, part; craft.parts)
                {
                    string req = text(findSplitAfter(std.conv.to!string(part[0]), "Item")[1], " [", itemCount[aaa], '/', part[1], "] ");
                    frame.write(sideSpacing + 45 - req.length - 1, sideSpacing + 2 + yaxis, fg((itemCount[aaa] >= part[1]) ? Color.green : Color.red), req);
                    ++yaxis;
                }
                ++yaxis;
            }
        }

        if(!Game.player.hasRemembered("wasd") || secondsFromTicks(Game.ticks) > 18 && Game.player.distanceMoved == 0)
        {
            Game.frame.write((px - 4) % cam.w, (py + 1) % cam.h, fg(Color.yellow), '[', fg(Color.white), 'A', fg(Color.yellow), ']');
            Game.frame.write((px + 2) % cam.w, (py + 1) % cam.h, fg(Color.yellow), '[', fg(Color.white), 'D', fg(Color.yellow), ']');
            Game.frame.write((px - 1) % cam.w, (py - 1) % cam.h, fg(Color.yellow), '[', fg(Color.white), 'W', fg(Color.yellow), ']');
            Game.frame.write((px - 1) % cam.w, (py + 1) % cam.h, fg(Color.yellow), '[', fg(Color.white), 'S', fg(Color.yellow), ']');
        }

        if
        (
            Game.player.counter(typeid(ItemStone)) <= 3 &&
            typeid(Game.world.getTileAt(px, py)) == typeid(TileSand) &&
            Game.world.getTileAt(px, py).items.length
        )
        {
            Game.frame.write((px + 2) % cam.w, (py - 1) % cam.h, fg(Color.yellow), '[', fg(Color.white), 'E', fg(Color.yellow), ']');
        }
        //else if(Game.player.hasRemembered("pilt"))
        //{
        //    if(flags.hasFlag(Game.player.lookingDirection, Direction.left))
        //    {
        //        Game.frame.write((px - 1) % cam.w, (py) % cam.h, fg(Color.white), bg((Game.player.hasRemembered("stuck")) ? Color.black_dark : Game.world.getTileAt(px - 1, py).backgroundColor), 'A');
        //    }
        //    if(flags.hasFlag(Game.player.lookingDirection, Direction.right))
        //    {
        //        Game.frame.write((px + 1) % cam.w, (py) % cam.h, fg(Color.white), bg((Game.player.hasRemembered("stuck")) ? Color.black_dark : Game.world.getTileAt(px + 1, py).backgroundColor), 'D');
        //    }
        //    if(flags.hasFlag(Game.player.lookingDirection, Direction.up))
        //    {
        //        Game.frame.write(px % cam.w, (py - 1) % cam.h,   fg(Color.white), bg((Game.player.hasRemembered("stuck")) ? Color.black_dark : Game.world.getTileAt(px, py - 1).backgroundColor), 'W');
        //    }
        //    if(flags.hasFlag(Game.player.lookingDirection, Direction.down))
        //    {
        //        Game.frame.write(px % cam.w, (py + 1) % cam.h,   fg(Color.white), bg((Game.player.hasRemembered("stuck")) ? Color.black_dark : Game.world.getTileAt(px, py + 1).backgroundColor), 'S');
        //    }
        //}

        if
        (
            typeid(Game.world.getTileAt(px, py)) == typeid(TileBerry) &&
           !Game.world.getTileAt(px, py).used &&
            Game.player.counter(typeid(TileBerry)) < 3
        )
        {
            Game.frame.write((px + 5) % cam.w, (py + 1) % cam.h, fg(Color.yellow), '[', fg(Color.white), 'F', fg(Color.yellow), ']');
        }

        frame.print();
    }

    sconeClose();
}

struct Rect
{
    int x, y, w, h;
}
