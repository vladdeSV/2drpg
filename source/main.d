import scone;
import world;
import game;

void main()
{
    sconeInit();

    Game.running = true;
    Game.frame = new Frame;
    Game.world = new World;

    Game.updater.resetUpdates();
    Game.frameUpdater.resetUpdates();
    while(Game.running)
    {
        foreach(i; 0 .. Game.updater.getUpdates())
        {
            Game.world.update();
        }

        foreach(i; 0 .. Game.frameUpdater.getUpdates())
        {
            Game.render();
        }
    }

    sconeClose();
}
