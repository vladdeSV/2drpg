import enums : UPS;
int secondsFromTicks(real ticks)
{
    return cast(int)(ticks / UPS);
}
