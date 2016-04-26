import std.typecons : Tuple;
import enums : Color;
import scone : Frame;

alias Element = Tuple!(int, int, Color, string);

struct UI
{
    this(int x, int y, int w, int h, char border, Element[] elemnts)
    {
        _x = x;
        _y = y;
        _w = w;
        _h = h;
        _border = border;
        _elements = elemnts;
    }

    void print(Frame frame)
    {
        foreach(y; 0 .. _h)
        {
            foreach(x; 0 .. _w)
            {
                frame.write(x + _x, y + _y, (!x || !y || x == _w - 1 || y == _h - 1) ? border : ' ');
            }
        }

        foreach(n, element; _elements)
        {
            frame.write(element[0], element[1], element[3], element[4]);
        }
    }

    private int _x, _y, _w, _h
    private char _border;
    private Element[] _elements;
}
