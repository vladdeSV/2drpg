struct Rect
{
    int x, y, w, h;
}

auto hasFlag(E)(E check, E type)
{
    return (check & type) == type;
}

auto addFlag(E)(ref E original, E add)
{
     original |= add;
}

auto removeFlag(E)(ref E original, E remove)
{
     original ^= remove;
}

import std.random : uniform;
import game;
///One out of `oneOutOf´ chance of returning true
bool chance(int oneOutOf)
{
    return uniform(0, oneOutOf, Game.gen) == 0;
}

int random(int count)
{
    return uniform(0, count, Game.gen);
}
