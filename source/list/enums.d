public import scone.color;

///Updates per second
enum UPS = 60;
///Milliseconds between each update, which is determined by `enum UPS`
enum double updateInterval = 1000/UPS;

///Frames per second
enum FPS = 60;
///Milliseconds between each frame, which is determined by `enum FPS`
enum double frameInterval = 1000/FPS;


///Chunk's size
enum chunkSize = 100;
///World's size in chunks
enum worldSize = 4;

///General direction
enum Direction
{
    none = 0,
    up = 1,
    down = 2,
    left = 4,
    right = 8,
}

///General attributes
enum Attributes
{
    ///A measure of how physically strong a character is. Strength often controls the maximum weight the character can carry, melee attack and/or damage, and sometimes hit points. Armor and weapons might also have a Strength requirement.
    strength,
    ///A measure of how sturdy a character is. Constitution often influences hit points, resistances for special types of damage (poisons, illness, heat etc.) and fatigue.
    constitution,
    ///A measure of how resilient a character is. Defense usually decreases taken damage by either a percentage or a fixed amount per hit. Occasionally combined with Constitution.
    defense,
    ///A measure of how agile a character is. Dexterity controls attack and movement speed and accuracy, as well as evading an opponent's attack (see Armor Class).
    dexterity,
    ///A measure of a character's problem-solving ability. Intelligence often controls a character's ability to comprehend foreign languages and their skill in magic. In some cases, intelligence controls how many skill points the character gets at "level up". In some games, it controls the rate at which experience points are earned, or the amount needed to level up. This is sometimes combined with wisdom and/or willpower.
    intelligence,
    ///A measure of a character's social skills, and sometimes their physical appearance. Charisma generally influences prices while trading, and NPC reactions.
    charisma,
    ///A measure of a character's common sense and/or spirituality. Wisdom often controls a character's ability to cast certain spells, communicate to mystical entities, or discern other characters' motives or feelings.
    wisdom,
    ///A measure of the character's mental resistance (against pain, fear etc.) when falling victim to mind-altering magic, torture, or insanity. Many games combine willpower and wisdom.
    willpower,
    ///A measure of a character's openness to their surroundings. Perception controls the chance to detect vital clues, traps, or hiding enemies, and might influence combat sequence, or the accuracy of ranged attacks. Perception-type attributes are more common in more modern games. Sometimes combined with wisdom.
    perception,
    ///A measure of a character's luck. Luck might influence anything, but mostly random items, encounters and outstanding successes/failures (such as critical hits).
    luck,
}

enum ArmorType
{
    head,
    neck,
    body_,
    arm,
    hand,
    hip,
    leg,
    boot,
}

enum WeaponType
{
    sword,
    bow,
    staff,
    sheild,
    axe,
    polearm,
}

//General materials
enum Material
{
    cloth,
    leather,
    wood,
    stone,
    bronze,
    iron,
    steel,
    gold,
    diamond,
}

enum Gender
{
    female = 0, //0 looks like a vagina
    male = 1,   //1 looks like a penis
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
