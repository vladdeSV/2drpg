import entity_living;
import enums;

import scone;
import game;

class EntityPlayer : EntityLiving
{
    //this(int x, int y, char sprite, Color color, string name, int maxHealth, int[Attributes] stats)
    this()
    {
        super(0, 0, 'c', Color.yellow, "Hermando", 10, [Attributes.strength : 10]);
    }

    override void update()
    {
        foreach(input; getInputs())
        {
            if(input.key == SK.escape)
            {
                Game.running = false;
            }
            else if(input.pressed)
            {
                if(input.key == SK.up)
                {
                    --_gy;
                }
                else if(input.key == SK.down)
                {
                    ++_gy;
                }
                else if(input.key == SK.left)
                {
                    --_gx;
                }
                else if(input.key == SK.right)
                {
                    ++_gx;
                }
            }
        }
    }
}
