import game;
import event;

class EventDistance : Event
{
    this(float distanceAfterCurrentDistance, void delegate() event, int delay)
    {
        if(Game.running)
        {
            _distance = distanceAfterCurrentDistance + Game.player.distanceMoved;
        }
        else
        {
            _distance = distanceAfterCurrentDistance;
        }
        super(event, delay);
    }

    override bool finalCheck()
    {
        return Game.player.distanceMoved >= _distance;
    }

    private float _distance;
}

auto distanceEvent(float distance, void delegate() event, int delay = 0)
{
    return new EventDistance(distance, event, delay);
}
