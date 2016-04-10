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
