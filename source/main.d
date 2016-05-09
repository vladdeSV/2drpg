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
import std.conv;

import scone;

void main()
{
    sconeInit();

    //>>Frame init
    auto frame = new Frame();
    Game.frame = frame;
    frame.print();
    //<<

    auto updater = Updater(1000/UPS);
    updater.resetUpdates();

    //>>Start menu
    string[] gamename =
    [
        " .d8888b. 8888888b. 8888888b. 8888888b.  .d8888b. ",
        "d88P  Y88b888  'Y88b888   Y88b888   Y88bd88P  Y88b",
        "       888888    888888    888888    888888    888",
        "     .d88P888    888888   d88P888   d88P888       ",
        " .od888P' 888    8888888888P' 8888888P' 888  88888",
        "d88P'     888    888888 T88b  888       888    888",
        "888'      888  .d88P888  T88b 888       Y88b  d88P",
        "888888888 8888888P' 888   T88b888        'Y8888P88",
        "",
        "LBS Game Awards 2016",
    ];
    string[3] menu = ["Start Game", "Options", "Exit"];

    int selectedMenuItem = 0;
    bool inOptionMenu;
    bool inStartMenu = true;

    while(inStartMenu)
    {
        //foreach(i; 0 .. updater.getUpdates())
        //{
        frame.clear();

        foreach(input; getInputs())
        {
            if(input.pressed)
            {
                if(inOptionMenu)
                {
                    if(input.key == SK.escape || input.key == SK.enter)
                    {
                        inOptionMenu = false;
                    }

                    if(input.key == SK.up)
                    {
                        Game.seed += 1;
                    }

                    if(input.key == SK.down)
                    {
                        Game.seed -= 1;
                    }
                }
                else
                {
                    if(input.key == SK.escape)
                    {
                        inStartMenu = false;
                        Game.forceQuit = true;
                    }

                    if(input.key == SK.up)
                    {
                        selectedMenuItem = (selectedMenuItem + menu.length - 1) % menu.length;
                    }

                    if(input.key == SK.down)
                    {
                        selectedMenuItem = (selectedMenuItem + 1) % menu.length;
                    }

                    if(input.key == SK.enter || input.key == SK.space)
                    {
                        if(selectedMenuItem == 0)
                        {
                            inStartMenu = false;
                            //frame.clear();
                        }

                        if(selectedMenuItem == 1)
                        {
                            inOptionMenu = true;
                            //
                        }

                        if(selectedMenuItem == 2)
                        {
                            inStartMenu = false;
                            Game.running = false;
                            Game.forceQuit = true;
                        }
                    }
                }
            }
        }

        if(inOptionMenu)
        {
            frame.write(13, 2, fg(Color.yellow), char(24));
            frame.write(2,  3, "Game seed: ", fg(Color.cyan), Game.seed);
            frame.write(13, 4, fg(Color.yellow), char(25));
            frame.write(2,  frame.h - 2, "Go back ", fg(Color.yellow), "[", fg(Color.white), "ESC", fg(Color.yellow), "]", fg(Color.white_dark), " or ", fg(Color.yellow), "[", fg(Color.white), "ENTER", fg(Color.white), fg(Color.yellow),"]");
        }
        else
        {
            foreach(n, row; gamename)
            {
                frame.write(cast(int)(frame.w / 2 - gamename[0].length/2), 4 + n, fg(Color.white), row);
            }

            foreach(n, m; menu)
            {
                string s;
                if(selectedMenuItem == n)
                {
                    frame.write(2, frame.h - 7 + 2*n, "> ", fg(Color.white), m);
                }
                else
                {
                    frame.write(2, frame.h - 7 + 2*n, "  ", m);
                }

            }

            frame.write(frame.w - 22, frame.h - 8, /*fg(Color.white),*/ " Gjort av: ");
            frame.write(frame.w - 23, frame.h - 4, /*fg(Color.white),*/ " Extra tack: ");
            frame.write(frame.w - 30, frame.h - 7, fg(Color.white), "Vladimirs '", fg(Color.yellow), "vladde",     fg(Color.white), "' Nordholm");
            frame.write(frame.w - 29, frame.h - 6, fg(Color.white), "Fredrik '",   fg(Color.yellow), "freddan",    fg(Color.white), "' Fernlund");
            frame.write(frame.w - 29, frame.h - 3, fg(Color.white), "Oskar '",     fg(Color.yellow), "afromannen", fg(Color.white), "' Malmrot");
            frame.write(frame.w - 31, frame.h - 2, fg(Color.white), "Beatrice '",  fg(Color.yellow), "vladdes gf", fg(Color.white), "' Svensson");
        }

        frame.print();
    }
    //<<

    //UI
    wSidebar = cast(int)(max(80, frame.w) / 2);
    wView = frame.w - wSidebar;
    hView = frame.h;
    xoffset = cast(int)((wView - ((chunkSize * worldSize) % wView)) / 2);
    yoffset = cast(int)((hView - ((chunkSize * worldSize) % hView)) / 2);
    auto cam = Rect(0, 0, wView, max(24, hView));
    //<<

    if(!Game.forceQuit)
    {
        Game.world = new World();

        //Force update of player;
        Game.player.update();

        Game.running = true;
        updater.resetUpdates();

        //float lentghToNearestEntityFromPlayer = 0;
        //Entity entityNearestPlayer;

        while(Game.running)
        {
            frame.clear();

            foreach(i; 0 .. updater.getUpdates())
            {
                Game.world.update();
                Game.ticks += 1;
            }

            if(Game.player.hasRemembered("blank"))
            {
                frame.print();
                continue;
            }

            int px = Game.player.globalLocation[0];
            int py = Game.player.globalLocation[1];

            int xoff = cast(int)((cam.w - ((chunkSize * worldSize) % cam.w)) / 2);
            int yoff = cast(int)((cam.h - ((chunkSize * worldSize) % cam.h)) / 2);

            cam.x = cast(int)((px + xoff) / cam.w) * cam.w - xoff;
            cam.y = cast(int)((py + yoff) / cam.h) * cam.h - yoff;

            if(!Game.player.hasRemembered("stuck"))
            {
                foreach(int y; 0 .. cam.h)
                {
                    foreach(int x; 0 .. cam.w)
                    {
                        Tile tile;
                        if(withinWorldBorder(cam.x + x, cam.y + y))
                        {
                            tile = Game.world.getTileAt(cam.x + x, cam.y + y);

                            frame.write(x,y, fg(!tile.items.length ? tile.color : (tile.items.length > 1 ? Color.red_dark : (tile.items[$-1].color))), bg(tile.backgroundColor), !tile.items.length ? tile.sprite : (tile.items.length > 1 ? char(30) : tile.items[$-1].sprite));
                        }
                        else
                        {
                            frame.write(x,y, fg(Color.magenta_dark), bg(Color.black_dark), probabilityOf(2000) ? (coin() ? ',' : '.') : ' ');
                        }
                    }
                }
                //Could I make this more effective?

                //lentghToNearestEntityFromPlayer = float.max;
                foreach(chunks; Game.world.chunks)
                {
                    foreach(chunk; chunks)
                    {
                        foreach(e; chunk.entities)
                        {
                            int ex = e.globalLocation[0], ey = e.globalLocation[1];

                            //if(lentghToNearestEntityFromPlayer > sqrt(cast(float)(pow(ex - px, 2) + pow(ey - py, 2))))
                            //{
                            //    entityNearestPlayer = e;
                            //}

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
                }
            }
            else
            {
                auto e = Game.player;
                frame.write(e.globalLocation[0] - cam.x, e.globalLocation[1] - cam.y, fg(e.color), bg(Color.black_dark), e.sprite);
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

                frame.write(sidebarStart + Game.player.maxItems * 2, frame.h - 3, fg(Color.black), '|');

                if(Game.player.inventory.length)
                {
                    frame.write(sidebarStart, frame.h - 4, "Equipped: ", fg(Game.player.inventory[Game.player.selectedListItem].color), Game.player.inventory[Game.player.selectedListItem].name);
                    foreach(n, ref item; Game.player.inventory)
                    {
                        frame.write(sidebarStart + n * 2, frame.h - 3, fg(item.color), item.sprite, ' ');
                    }

                    if(!Game.player.crafting && Game.player.inventory.length > 1)
                    {
                        frame.write(sidebarStart - 1 + Game.player.selectedListItem * 2, frame.h - 3, fg(Color.yellow), char(27));
                        frame.write(sidebarStart + 1 + Game.player.selectedListItem * 2, frame.h - 3, fg(Color.yellow), char(26));
                    }

                    if(Game.player.inventory[Game.player.selectedListItem].usable)
                    {
                        frame.write(frame.w - 4, frame.h - 3, fg(Color.yellow), '[', fg(Color.white), 'U', fg(Color.yellow), ']');
                    }

                    frame.write(sidebarStart + Game.player.selectedListItem * 2, frame.h - 2, /*fg(Color.yellow),*/ char(24));
                }
            }

            byte thoughtsStartPosition = 2;
            foreach(n, s; Game.player.thoughts)
            {
                int position = thoughtsStartPosition + n;
                if(position < cam.h - 8)
                {
                    frame.write(sidebarStart, position, s);
                }
                else
                {
                    break;
                }
            }

            if(!Game.player.hasRemembered("wasd") || secondsFromTicks(Game.ticks) > 18 && Game.player.distanceMoved == 0)
            {
                Game.frame.write((px - 4 + xoffset) % cam.w, (py + 1 + yoffset) % cam.h, fg(Color.yellow), '[', fg(Color.white), 'A', fg(Color.yellow), ']');
                Game.frame.write((px + 2 + xoffset) % cam.w, (py + 1 + yoffset) % cam.h, fg(Color.yellow), '[', fg(Color.white), 'D', fg(Color.yellow), ']');
                Game.frame.write((px - 1 + xoffset) % cam.w, (py - 1 + yoffset) % cam.h, fg(Color.yellow), '[', fg(Color.white), 'W', fg(Color.yellow), ']');
                Game.frame.write((px - 1 + xoffset) % cam.w, (py + 1 + yoffset) % cam.h, fg(Color.yellow), '[', fg(Color.white), 'S', fg(Color.yellow), ']');
            }

            //if
            //(
            //    Game.player.counter(typeid(ItemStone)) <= 3 &&
            //    typeid(Game.world.getTileAt(px, py)) == typeid(TileSand) &&
            //    Game.world.getTileAt(px, py).items.length
            //)
            //{
            //    Game.frame.write((px + 2) % cam.w, (py - 1) % cam.h, fg(Color.yellow), '[', fg(Color.white), 'E', fg(Color.yellow), ']');
            //}
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

            //if
            //(
            //    typeid(Game.world.getTileAt(px, py)) == typeid(TileBerry) &&
            //   !Game.world.getTileAt(px, py).used &&
            //    Game.player.counter(typeid(TileBerry)) < 3
            //)
            //{
            //    Game.frame.write((px + 5) % cam.w, (py + 1) % cam.h, fg(Color.yellow), '[', fg(Color.white), 'F', fg(Color.yellow), ']');
            //}
            immutable sideSpacing = 2;

            if(Game.player.menu)
            {
                drawRect(sideSpacing, sideSpacing, 15, 7, Slot(' '), Slot('#', fg(Color.black)));

                string[] menuitems = ["Continue", "Exit"];

                foreach(n, ref menuitem; menuitems)
                {
                    if(Game.player.selectedMenuMenu == n)
                    {
                        menuitem = "> " ~ menuitem;
                    }
                    else
                    {
                        menuitem = "  " ~ menuitem;
                    }
                }

                frame.write(sideSpacing + 2, sideSpacing + 2, menuitems[0]);
                frame.write(sideSpacing + 2, sideSpacing + 4, fg(Color.red), menuitems[1]);
            }

            else if(Game.player.questing)
            {
                auto q = Game.player.currentQuest;

                foreach(y; hView - 8 .. hView - 1)
                foreach(x; sideSpacing .. 35)
                {
                    if(x == sideSpacing || y == hView - 8 || x == 34 || y == hView - 2)
                    {
                        frame.write(x,y, fg(Color.black), bg(Color.black_dark), '#');
                    }
                    else
                    {
                        frame.write(x,y, bg(Color.black_dark), ' ');
                    }
                }

                frame.write(4, hView - 6, fg(q.sender.color), q.sender.sprite, fg(Color.white_dark), " - ", q.sender.name);

                string[3] texts = ["Talk", "Quest", "Leave"];

                foreach(n, ref t; texts)
                {
                    if(n == Game.player.selectedQuestMenu)
                    {
                        texts[n] = "> " ~ texts[n];
                    }
                    else
                    {
                        texts[n] = "  " ~ texts[n];
                    }
                }

                Color qcol;
                if(Game.player.currentQuest.quests.length)
                {
                    if(Game.player.currentQuest.quests[0].check())
                    {
                        qcol = Color.green;
                    }
                    else
                    {
                        qcol = Color.yellow;
                    }
                }
                else
                {
                    qcol = Color.black;
                }

                frame.write(sideSpacing + 2     , hView - 4, texts[0]);
                frame.write(sideSpacing + 2 + 10, hView - 4, fg(qcol), texts[1]);
                frame.write(sideSpacing + 2 + 20, hView - 4, texts[2]);

                q = null;
            }

            //>>CRAFTING SYSTEM
            else if(Game.player.crafting)
            {
                Slot border = Slot(char(4), fg(Color.white_dark), bg(Color.black_dark));
                Slot main = Slot(' ', fg(Color.white_dark), bg(Color.black_dark));

                int wCraft = cam.w - 2*sideSpacing, hCraft = cam.h - 2*sideSpacing;
                bool canBeCrafted = true;

                drawRect(sideSpacing, sideSpacing, wCraft, hCraft, main, border);

                auto craft = CraftList[Game.player.selectedCraftItem];

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
                foreach(n, part; craft.parts)
                {
                    bool enoughItems = itemCount[n] >= part[1];
                    canBeCrafted &= enoughItems;

                    int req = text
                    (
                        findSplitAfter(std.conv.to!string(part[0]), "Item")[1],
                        " [",
                        itemCount[n],
                        '/',
                        part[1],
                        "] "
                    ).length;

                    frame.write(cam.w - 2 * sideSpacing - (req - 1), sideSpacing + 2 + n, findSplitAfter(std.conv.to!string(part[0]), "Item")[1], " [", fg((enoughItems) ? Color.green : Color.red), itemCount[n], fg(Color.white_dark), '/', part[1], "] ");
                }

                //string[] craftNames = new string[](CraftList.length);
                foreach(n, c; CraftList)
                {
                    if(n == Game.player.selectedCraftItem)
                    {
                        frame.write(sideSpacing + 2, sideSpacing + 2 + n, text(char(16), ' ', c.desc));
                    }
                    else
                    {
                        frame.write(sideSpacing + 2, sideSpacing + 2 + n, fg(Color.black), "  " ~ c.desc);
                    }

                }
            }
            //else
            //{
            //    if(Game.player.hasRemembered("helpline"))
            //    {
            //        foreach(ref e)
            //    }
            //}

            frame.print();
        }
    }

    if(!Game.forceQuit)
    {
        int endticks = 13*UPS;
        updater.resetUpdates();

        endloop:
        while(secondsFromTicks(endticks) <= 63)
        {

            foreach(i; 0 .. updater.getUpdates())
            {
                int sec = secondsFromTicks(endticks);

                foreach(input; getInputs())
                {
                    if(sec >= 20 && input.pressed && input.key == SK.escape)
                    {
                        break endloop;
                    }
                }

                frame.clear();
                frame.write(2,2, text("07:", sec));
                if(sec >= 19)
                {
                    frame.write(2,4, "The end.");
                }
                frame.print();
                endticks += 1;
            }
        }
    }

    frame.clear();
    frame.print();

    sconeClose();
}

struct Rect
{
    int x, y, w, h;
}

void drawRect(int x, int y, int w, int h, Slot main, Slot border)
{
    foreach(row; 0 .. h)
    {
        foreach(col; 0 .. w)
        {
            if(!col || !row || col == w - 1 || row == h - 1)
            {
                Game.frame.write(x + col, y + row, border);
            }
            else
            {
                Game.frame.write(x + col, y + row, main);
            }
        }
    }
}

