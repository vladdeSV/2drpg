import game;
import event;
import entity_player;

class EventDistance : Event
{
    this(EntityPlayer player, float distanceAfterCurrentDistance, void delegate() event, int delay)
    {
        _player = player;

        if(Game.running)
        {
            _distance = distanceAfterCurrentDistance + player.distanceMoved;
        }
        else
        {
            _distance = distanceAfterCurrentDistance;
        }
        super(event, delay);
    }

    override bool finalCheck()
    {
        return _player.distanceMoved >= _distance;
    }

    private EntityPlayer _player;
    private float _distance;
}

auto distanceEvent(EntityPlayer player, float distance, void delegate() event, int delay = 0)
{
    return new EventDistance(player, distance, event, delay);
}
