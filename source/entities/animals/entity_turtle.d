import entity_living;
import enums;

class EntityTurtle : EntityLiving
{
    this(int x, int y)
    {
        super("Ol' Man Bent", x, y, '@', Color.green);
    }
}
