import item;
import enums;
import thought;
import entity_player;
import slump;

class ItemWood : Item
{
    this()
    {
        super("Stick", '/', Color.red_dark, readText("source/list/inspect_wood.txt").split('\n')[random($)]);
    }
}

import std.algorithm.mutation : split;
import std.file : readText;
