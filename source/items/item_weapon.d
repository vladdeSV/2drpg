import item;
import item_equipable;
import enums;

class ItemWeapon : ItemEquipable
{
    this(string name, WeaponType type, Material material, int[Attributes] stats, bool twoHanded, int value)
    {
        super(name, material, stats, value);
        m_twoHanded = twoHanded;
    }

    auto twoHanded() const @property
    {
        return m_twoHanded;
    }

private:
    bool m_twoHanded;
}
