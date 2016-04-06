import item;
import enums;

class ItemMaterial : Item
{
    this(string name, Material material)
    {
        _material = material;
        super(name);
    }

    private Material _material;
}
