import entity;
import enums;

import scone;
import game;

class EntityPlayer : Entity
{
    this()
    {
        super(0, 0, 'c', Color.yellow);
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
