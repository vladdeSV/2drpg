import game;
import event;

class EventDistance : Event
{
    this(float distanceAfterCurrentDistance, void delegate() event)
    {
        _distance = distanceAfterCurrentDistance + Game.world.player.distanceMoved;
        super(event);
    }

    override bool finalCheck()
    {
        return Game.world.player.distanceMoved >= _distance;
    }

    private float _distance;
}

auto distanceEvent(float distance, void delegate() event)
{
    return new EventDistance(distance, event);
}
