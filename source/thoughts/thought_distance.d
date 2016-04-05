import game;
import thought;

class ThoughtDistance : Thought
{
    this(float distanceSinceCurrentDistance, string thought, void delegate() special = null)
    {
        _distance = distanceSinceCurrentDistance + Game.world.player.distanceMoved;
        super(thought, special);
    }

    override bool finalCheck()
    {
        return Game.world.player.distanceMoved >= _distance;
    }

    private float _distance;
}

auto distanceThought(float distance, string thought, void delegate() del = null)
{
    return new ThoughtDistance(distance, thought, del);
}
