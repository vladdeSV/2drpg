import std.random : uniform;
import game;

///One out of `oneOutOf´ probabilityOf of returning true
bool probabilityOf(int oneOutOf)
{
    return uniform(0, oneOutOf, Game.gen) == 0;
}

///Returns: random number within 0 and `count`
int random(int count)
{
    return uniform(0, count, Game.gen);
}

///Returns: random element in array
A random(A)(A[] arr)
{
   return arr[random($)];
}

///Returns: randomly true or false
bool coin()
{
    return cast(bool) uniform(0, 2, Game.gen);
}
