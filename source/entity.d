module drpg.entity;

enum EntityRace
{
  Human = 1,
  Orc = 2,
  Fishman = 4,
  Elf = 8,
  Dwarf = 16,
}

abstract class Entity
{
  int m_health;
  int m_focus;

  int m_x;
  int m_y;

  char m_appearance = '?';
}
