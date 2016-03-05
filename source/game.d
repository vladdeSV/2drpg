import scone;
import world;
import enums;
import updater;

struct Game
{
    static void render()
    {
        Game.frame.clear();

        //foreach(int sy, ref row; Game.world._tiles)
        //{
        //    foreach(int sx, ref tile; row)
        //    {
        //        Game.frame.write(sx,sy, tile.color, tile.backgroundColor, tile.sprite);
        //    }
        //}

        //foreach(entity; Game.world._entities)
        //{
        //    Game.frame.write(entity.position[0], entity.position[1], cast(fg) entity.color, entity.sprite);
        //}

        Game.frame.print();
    }

    static bool running;

    static Updater updater = Updater(updateInterval);
    static Updater frameUpdater = Updater(frameInterval);
    static Frame frame;
    static World world;
}
