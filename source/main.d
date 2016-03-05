import scone;
import world;
import game;

void main()
{
    sconeInit();

    Game.running = false;
    Game.frame = new Frame;
    Game.world = new World;

    Game.updater.resetUpdates();
    Game.frameUpdater.resetUpdates();
    while(Game.running)
    {
        //Maximum of `enum UPS` ticks per second.
        foreach(i; 0 .. Game.updater.getUpdates())
        {
            Game.world.update();
        }

        //Make sure we don't print more than `enum FPS` per second.
        foreach(i; 0 .. Game.frameUpdater.getUpdates())
        {
            Game.render();
        }
    }

    sconeClose();
}
