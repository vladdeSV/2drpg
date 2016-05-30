public import scone.color;

enum UPS = 60;

enum worldSize = 2;
enum chunkSize = 100;

enum Direction
{
    none  = 0,
    up    = 1,
    down  = 2,
    left  = 4,
    right = 8,
}

bool withinWorldBorder(float x, float y)
{
    return (x >= 0 && x < chunkSize * worldSize && y >= 0 && y < chunkSize * worldSize);
}

import std.ascii : isUpper;
import std.algorithm.searching : findSplitAfter;
import std.conv;
string nameFromTypeid(TypeInfo_Class c)
{
    string a = findSplitAfter(std.conv.to!string(c), "Item")[1];

    for(size_t i = 1; i < a.length; ++i)
    {
        if(isUpper(a[i]))
        {
            a = a[0 .. i] ~ ' ' ~ a[i .. $];

            ++i;
        }
    }

    return a;
}

