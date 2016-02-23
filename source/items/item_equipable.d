import item;
import enums;

abstract class ItemEquipable : Item
{
    this(string name, Material material, int[Attributes] stats, int value)
    {
        super(name, value);
        m_material = material;
        m_stats = cast(int[Attributes]) stats;
    }

    auto stats() const @property
    {
        return m_stats;
    }

    auto material() const @property
    {
        return m_material;
    }

    int[Attributes] m_stats;
    Material m_material;
}
