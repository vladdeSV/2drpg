import item;
import item_equipable;
import enums;

class ItemArmor : ItemEquipable
{
    this(string name, Material material, int[Attributes] stats, ArmorType type, int value)
    {
        super(name, material, stats, value);
        m_armorType = type;
    }

    auto armorType() const @property
    {
        return m_armorType;
    }

private:
    ArmorType m_armorType;
}
