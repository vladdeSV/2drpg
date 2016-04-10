import std.typecons:Tuple;

alias ThoughtPart = Tuple!(int, string);

struct Thought
{
    @disable this();
    @disable this(this);

    this(ThoughtPart[] thoughts)
    {
        _thoughts = thoughts;
    }

    ThoughtPart[] thoughts() const @property
    {
        return _thoughts;
    }

    ThoughtPart[] _thoughts;
}

Though constructThought(ThoughtPart...)(ThoughtPart thoughts)
{
    return Thought(thoughts);
}
