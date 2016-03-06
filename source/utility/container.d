template Container(T)
{
    this(int size)
    {
        _container.length = size;
    }

    this(T startingContainer, uint size = 0)
    {
        _container = startingContainer;

        if (size > 0)
        {
            _container.length = size;
        }
    }

    auto content() @property
    {
        return _container;
    }

    auto size() @property
    {
        return _container.length;
    }

private:
    T _container;
}
