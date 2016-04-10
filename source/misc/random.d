import std.random : uniform;
import game;
///One out of `oneOutOf´ chance of returning true
bool chance(int oneOutOf)
{
    return uniform(0, oneOutOf, Game.gen) == 0;
}
///Random number between 0 and `count`
int random(int count)
{
    return uniform(0, count, Game.gen);
}
///True or false randomly
bool coin()
{
    return cast(bool) uniform(0, 2, Game.gen);
}
