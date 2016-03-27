bool hasFlag(Type)(Type check, Type type)
{
    return ((check & type) == type);
}

import std.random : uniform;
import game;
///One out of `oneOutOf´ chance of returning true
bool chance(int oneOutOf)
{
    return uniform(0, oneOutOf, Game.gen) == 0;
}
