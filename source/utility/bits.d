bool hasFlag(Type)(Type check, Type type)
{
    return ((check & type) == type);
}
