import entity_animal;
import enums;

class EntityTurtle : EntityAnimal
{
    this(int x, int y)
    {
        super("Ol' Man Bent", x, y, '@', Color.green);
    }
}
