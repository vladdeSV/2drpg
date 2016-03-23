import entity_living;
import enums;

import scone;
import game;

import std.stdio;

class EntityPlayer : EntityLiving
{
    //this(int x, int y, char sprite, Color color, string name, int maxHealth, int[Attributes] stats)
    this(int x, int y)
    {
        super(x, y, char(1), Color.yellow, "Hermando", 10, [Attributes.strength : 150, Attributes.intelligence : -15]);
    }

    override void update()
    {
        foreach(input; getInputs())
        {
            if(input.key == SK.escape)
            {
                Game.running = false;
                break;
            }

            if(input.pressed)
            {
                if(input.key == SK.up)
                {
                    _movingDirection |= Direction.up;
                }
                else if(input.key == SK.down)
                {
                    _movingDirection |= Direction.down;
                }
                else if(input.key == SK.left)
                {
                    _movingDirection |= Direction.left;
                }
                else if(input.key == SK.right)
                {
                    _movingDirection |= Direction.right;
                }
            }
            else
            {
                if(input.key == SK.up)
                {
                    _movingDirection ^= Direction.up;
                }
                else if(input.key == SK.down)
                {
                    _movingDirection ^= Direction.down;
                }
                else if(input.key == SK.left)
                {
                    _movingDirection ^= Direction.left;
                }
                else if(input.key == SK.right)
                {
                    _movingDirection ^= Direction.right;
                }
            }
        }

        super.update();
    }
}
