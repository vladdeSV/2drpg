module probar;

import std.conv;

struct Probar
{
    @disable this();
    @disable this(this);

    //Stuff needed to function

    /**
     * The value of the status bar
     */
    public float value;

    /**
     * The amount of slots the entire bar should be
     */
    public int length;

    /**
     * The maximum value that `value` can be
     * Note: `value` can be bigger than bax, however the bar will not grow more
     */
    public int max;

    /**
     * The character that the bar will be filled with
     */
    public char fillSlot = '#';

    /**
     * What the empty slots in the bar are
     */
    public char emptySlot = ' ';

    /**
     * If the value of the should be visible ontop of the bar
     */
    public bool showValue;

    /**
     * If the maximum value of the should be visible ontop of the bar
     * Should be on by default, set to false only if maximum value should be hidden
     */
    public bool showMaxValue = true;

    /**
     * Character(s) that separates the value and maximum value ontop of the bar
     */
    public string divider = "/";

    /**
     * Character(s) that appears before the value and max value
     */
    public string openValue = "[";

    /**
     * Character(s) that appears after the value and max value
     */
    public string closeValue = "]";

    /**
     * Spacing is the minimum space needed around the shown value
     * Eg. "[10/20]" with spacing of 2 = "  [10/20]  " (Two spaces to the left and right)
     * This is to make sure it's possible to show some of the bar. Set to 0 if you don't like it >:(
     */
    public int spacing = 1;

    this(int length, int max, bool showValue = false)
    {
        this.length = length;
        this.max = max;
        this.showValue = showValue;
    }

    /**
     * Gives back a string of the bar
     * Returns: char[]
     */
    auto bar() @property const
    {
        char[] _bar = new char[](length);
        _bar[] = emptySlot;

        foreach(n, ref slot; _bar)
        {
            if(n <= length * (value / cast(float) max ) - 1)
            {
                slot = fillSlot;
                continue;
            }
            break;
        }

        if(showValue)
        {
            auto minimumLength = to!string(value).length + spacing * 2 + openValue.length + closeValue.length;
            if(showMaxValue){
                minimumLength += to!string(max).length + divider.length;
            }

            if(_bar.length > minimumLength)
            {
                string str;
                if(showMaxValue)
                {
                    str = openValue ~ to!string(value) ~ divider ~ to!string(max) ~ closeValue;
                }
                else
                {
                    str = openValue ~ to!string(value) ~ closeValue;
                }
                auto x1 = (_bar.length / 2) - (str.length / 2);
                auto x2 = (_bar.length / 2) - (str.length / 2) + str.length;
                _bar[x1 .. x2] = str;
            }
        }
        return _bar;
    }

    auto val(bool showMaxValue) const
    {
        if(showMaxValue)
        {
            return openValue ~ to!string(value) ~ divider ~ to!string(max) ~ closeValue;
        }
        else
        {
            return openValue ~ to!string(value) ~ closeValue;
        }
    }
}

unittest
{
    Probar bar = Probar(10, 20); // Creates a progress bar that is 10 slots wide, and has a maximum value of 20.

    assert(bar.bar() == "          ");
    bar.value = 5;
    assert(bar.bar() == "##        ");
    bar.value = 10;
    assert(bar.bar() == "#####     ");
    bar.value = 20;
    assert(bar.bar() == "##########");

    bar.value = 42;
    assert(bar.bar() == "##########");
    bar.value = -10;
    assert(bar.bar() == "          ");

    bar.value = 20;
    bar.length = 30;
    assert(bar.bar() == "##############################");

    bar.value = 10;
    assert(bar.bar() == "###############               ");

    bar.length = 10;
    bar.fillSlot = '$';
    bar.emptySlot = '-';
    bar.value = 10;
    assert(bar.bar() == "$$$$$-----");

    bar.showValue = true;
    assert(bar.bar() == "$$[10/20]-");

    bar.length = 20;
    assert(bar.bar() == "$$$$$$$[10/20]------");

    bar.divider = " of ";
    assert(bar.bar() == "$$$$$[10 of 20]-----");

    bar.openValue = "((";
    bar.closeValue = "))";
    assert(bar.bar() == "$$$$((10 of 20))----");

    bar.spacing = 5; //Spacing is too big
    assert(bar.bar() == "$$$$$$$$$$----------");
    bar.spacing = 1; //Reset spacing

    bar.value = 101;
    assert(bar.bar() == "$$$$((101 of 20))$$$");

    bar.showMaxValue = false;
    assert(bar.bar() == "$$$$$$$((101))$$$$$$");

    bar.showMaxValue = true;
    bar.showValue = false;
    assert(bar.bar() == "$$$$$$$$$$$$$$$$$$$$");

    bar.openValue = null;
    bar.closeValue = null;
    bar.showValue = true;
    bar.showMaxValue = true;
    bar.divider = "|";
    bar.fillSlot = '*';
    bar.emptySlot = ' ';
    bar.value = bar.max;
    assert(bar.bar() == "********20|20*******");

    bar.max = 40;
    assert(bar.bar() == "********20|40       ");
}
