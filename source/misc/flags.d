/**
 * Contains basic binary flag checking.
 */

auto hasFlag(E)(in E check, in E type)
{
    return (check & type) == type;
}

auto addFlag(E)(ref E original, in E add)
{
    original |= add;
}

auto removeFlag(E)(ref E original, in E remove)
{
    original ^= remove;
}
