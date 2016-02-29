///Updates per second
enum UPS = 30;
///Milliseconds between each update, which is determined by `enum UPS`
enum double updateInterval = 1000/UPS;

///Frames per second
enum FPS = 60;
///Milliseconds between each frame, which is determined by `enum FPS`
enum double frameInterval = 1000/FPS;


///Chunk's size
enum chunkSize = 100;
//World's size in chunks
enum worldSize = 20;

///General direction
enum Direction
{
    None = 0,
    Up = 1,
    Down = 2,
    Left = 4,
    Right = 8
}

///Colors
enum Color
{
    init,

    black,
    blue,
    blue_dark,
    cyan,
    cyan_dark,
    gray,
    gray_dark,
    green,
    green_dark,
    magenta,
    magenta_dark,
    red,
    red_dark,
    white,
    yellow,
    yellow_dark
}

///General attributes
enum Attributes
{
    ///A measure of how physically strong a character is. Strength often controls the maximum weight the character can carry, melee attack and/or damage, and sometimes hit points. Armor and weapons might also have a Strength requirement.
    Strength,
    ///A measure of how sturdy a character is. Constitution often influences hit points, resistances for special types of damage (poisons, illness, heat etc.) and fatigue.
    Constitution,
    ///A measure of how resilient a character is. Defense usually decreases taken damage by either a percentage or a fixed amount per hit. Occasionally combined with Constitution.
    Defense,
    ///A measure of how agile a character is. Dexterity controls attack and movement speed and accuracy, as well as evading an opponent's attack (see Armor Class).
    Dexterity,
    ///A measure of a character's problem-solving ability. Intelligence often controls a character's ability to comprehend foreign languages and their skill in magic. In some cases, intelligence controls how many skill points the character gets at "level up". In some games, it controls the rate at which experience points are earned, or the amount needed to level up. This is sometimes combined with wisdom and/or willpower.
    Intelligence,
    ///A measure of a character's social skills, and sometimes their physical appearance. Charisma generally influences prices while trading, and NPC reactions.
    Charisma,
    ///A measure of a character's common sense and/or spirituality. Wisdom often controls a character's ability to cast certain spells, communicate to mystical entities, or discern other characters' motives or feelings.
    Wisdom,
    ///A measure of the character's mental resistance (against pain, fear etc.) when falling victim to mind-altering magic, torture, or insanity. Many games combine willpower and wisdom.
    Willpower,
    ///A measure of a character's openness to their surroundings. Perception controls the chance to detect vital clues, traps, or hiding enemies, and might influence combat sequence, or the accuracy of ranged attacks. Perception-type attributes are more common in more modern games. Sometimes combined with wisdom.
    Perception,
    ///A measure of a character's luck. Luck might influence anything, but mostly random items, encounters and outstanding successes/failures (such as critical hits).
    Luck,
}

enum ArmorType
{
    Belt,
    Boots,
    Bracer,
    Cloak,
    Gauntlet,
    Glove,
    Helmet,
    Necklace,
    Ring,
    Robe,
}

enum WeaponType
{
    Sword,
    Bow,
    Staff,
    Sheild,
    Axe,
    Polearm
}

//General materials
enum Material
{
    Cloth,
    Leather,
    Wood,
    Stone,
    Bronze,
    Iron,
    Steel,
    Gold,
    Diamond,
}

enum Gender
{
    Female = 0, //0 looks like a vagina
    Male = 1,   //1 looks like a penis
}


//Broom,
//Hammer,
//Lockpick,
//Pickaxe,
//Pitchfork,
//Rake,
//Saw,
//Shovel,
//Sickle,
//Tong,

//Amulet,
//Armor,
//Belt,
//Boots,
//Bracer,
//Chain,
//Cloak,
//Gauntlet,
//Glove,
//Helmet,
//Necklace,
//Ring,
//Robe,
