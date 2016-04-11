//import std.typecons : Tuple;
//import enums : Color;

//alias ThoughtPart = Tuple!(Color, string);

//struct Thought
//{
//    @disable this();
//    @disable this(this);

//    this(ThoughtPart[] thoughts)
//    {
//        _thoughts = thoughts;
//    }

//    ThoughtPart[] thoughts()
//    {
//        return _thoughts;
//    }

//    ThoughtPart[] _thoughts;
//}

//Thought constructThought(ThoughtPart...)(ThoughtPart thoughts)
//{
//    return Thought(thoughts);
//}
