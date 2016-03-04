import item;
import enums;

abstract class ItemEquipable : Item
{
    this(string name, Material material, int[Attributes] stats, int value)
    {
        super(name, value);
        _material = material;
        _stats = cast(int[Attributes]) stats;
    }

    auto stats() const @property
    {
        return _stats;
    }

    auto material() const @property
    {
        return _material;
    }
private:
    int[Attributes] _stats;
    Material _material;
}
