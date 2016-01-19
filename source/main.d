import scone;
import std.stdio;

void main()
{
  writeln(" - works!");
}

class Game
{
  void start()
  {
    running = true;

    while(running)
    {
      tick();
      render();
    }
  }

  void tick()
  {

  }

  void render()
  {

  }

  bool running;
}
