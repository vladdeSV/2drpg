import game;
import enums;
import slump;

abstract class Entity
{
    this(int x, int y, char sprite, Color color)
    {
        _gx = x;
        _gy = y;
        _ccx = chunkLocation[0];
        _ccy = chunkLocation[1];
        _sprite = sprite;
        _color = color;

        _lookingDirection = cast(Direction)(random(4) + 1);
    }

    void update() {}

    ///Returns: int[x, y]
    auto globalLocation() const @property
    {
        return [cast(int)_gx, cast(int)_gy];
    }

    auto chunkLocation() const @property
    {
        return [cast(int)(_gx / chunkSize), cast(int)(_gy / chunkSize)];
    }

    auto sprite() const @property
    {
        return _sprite;
    }

    Color color() const @property
    {
        return _color;
    }

    float velocity() const @property
    {
        return _moveVelocity;
    }

    Direction movingDirection() const @property
    {
        return _movingDirection;
    }

    Direction lookingDirection() const @property
    {
        return _lookingDirection;
    }

    ///Global x and y coordinates
    private float _gx, _gy;
    private char _sprite;
    private Color _color;
    private int _ccx, _ccy;

    ///Current chunk location
    private float _moveVelocity;
    private Direction _movingDirection;
    private Direction _lookingDirection;
}
