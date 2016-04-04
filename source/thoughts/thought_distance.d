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

ThoughtDistance distanceThought(float distance, string thought)
{
    return new ThoughtDistance(distance, thought);
}
