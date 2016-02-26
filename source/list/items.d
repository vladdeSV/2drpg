import enums;
import item;

//import item_equipable;
import item_weapon;
import item_armor;
import item_consumable;
import item_misc;

immutable static ItemWeapon[string]     ListItemWeapon;
immutable static ItemConsumable[string] ListItemConsumable;
immutable static ItemArmor[string]      ListItemArmor;
immutable static ItemMisc[string]       ListItemMisc;

shared static this()
{
    ListItemWeapon = cast(immutable)
    [
        "rapier" : createWeapon("Rapier", WeaponType.Sword, Material.Steel, [Attributes.Strength : 12], false, 100),
        "longsword" : createWeapon("Longsword", WeaponType.Sword, Material.Iron, [Attributes.Strength : 13], true, 50),
        "schythe" : createWeapon("Schythe", WeaponType.Sword, Material.Steel, [Attributes.Strength : 6], false, 30),
        "sabre" : createWeapon("Sabre", WeaponType.Sword, Material.Steel, [Attributes.Strength : 7], false, 20),
        "sword" : createWeapon("Sword", WeaponType.Sword, Material.Iron, [Attributes.Strength : 6], false, 10),
        "stave" : createWeapon("Stave", WeaponType.Staff, Material.Wood, [Attributes.Strength : 1, Attributes.Intelligence : 3], false, 5),
        "staff" : createWeapon("Staff", WeaponType.Staff, Material.Wood, [Attributes.Strength : 3, Attributes.Intelligence : 6], true, 7),
        "rod" : createWeapon("Rod", WeaponType.Staff, Material.Iron, [Attributes.Strength : 5], true, 6),
        "axe" : createWeapon("Axe", WeaponType.Axe, Material.Steel, [Attributes.Strength : 5], true, 4),
    ];

    ListItemConsumable = cast(immutable)
    [
        "apple" : new ItemConsumable("Apple", 3, 1),
        "beer" : new ItemConsumable("Beer", 0, 7),
        "blueberries" : new ItemConsumable("Blueberries", 4, 2),
        "bread" : new ItemConsumable("Bread", 3, 3),
        "bugmeat" : new ItemConsumable("Bugmeat", -1, 0),
        "bun" : new ItemConsumable("Bun", 4, 2),
        "carrot" : new ItemConsumable("Carrot", 3, 1),
        "chicken" : new ItemConsumable("Chicken", 7, 4),
        "coffee" : new ItemConsumable("Coffee", 7, 20),
        "egg" : new ItemConsumable("Egg", 4, 2),
        "fish" : new ItemConsumable("Fish", 4, 5),
        "grapes" : new ItemConsumable("Grapes", 3, 4),
        "grog" : new ItemConsumable("Grog", -1, 15),
        "herbs" : new ItemConsumable("Herbs", 11, 10),
        "honeycomb" : new ItemConsumable("Honeycomb", 3, 9),
        "meat" : new ItemConsumable("Meat", 4, 3),
        "milk" : new ItemConsumable("Milk", 9, 2),
        "mushroom" : new ItemConsumable("Mushroom", 2, 1),
        "nuts" : new ItemConsumable("Nuts", 4, 2),
        "onion" : new ItemConsumable("Onion", 2, 1),
        "pear" : new ItemConsumable("Pear", 3, 1),
        "pork" : new ItemConsumable("Pork", 2, 4),
        "potatoe" : new ItemConsumable("Potatoe", 3, 1),
        "healingPotion" : new ItemConsumable("Potion", 34, 20),
        "raspberries" : new ItemConsumable("Raspberries", 3, 2),
        "rice" : new ItemConsumable("Rice", 6, 5),
        "root" : new ItemConsumable("Root", 1, 7),
        "rum" : new ItemConsumable("Rum", 0, 25),
        "sausage" : new ItemConsumable("Sausage", 4, 2),
        "seed" : new ItemConsumable("Seed", 0, 1),
        "soup" : new ItemConsumable("Soup", 13, 7),
        "spices" : new ItemConsumable("Spices", 6, 5),
        "stew" : new ItemConsumable("Stew", 7, 5),
        "strawberries" : new ItemConsumable("Strawberries", 6, 4),
        "tea" : new ItemConsumable("Tea", 4, 11),
        "watermelon" : new ItemConsumable("Watermelon", 2, 5),
        "wine" : new ItemConsumable("Wine", 0, 24),
    ];

    ListItemMisc = cast(immutable)
    [
        "basket" : new ItemMisc("Basket", 2),
        "bellows" : new ItemMisc("Bellows", 3),
        "book" : new ItemMisc("Book", 1),
        "bottle" : new ItemMisc("Bottle", 2),
        "bowl" : new ItemMisc("Bowl", 3),
        "bucket" : new ItemMisc("Bucket", 5),
        "candlestick" : new ItemMisc("Candlestick", 3),
        "charcoal" : new ItemMisc("Charcoal", 4),
        "cup" : new ItemMisc("Cup", 1),
        "drum" : new ItemMisc("Drum", 2),
        "firewood" : new ItemMisc("Firewood", 6),
        "fishingPole" : new ItemMisc("FishingPole", 7),
        "flag" : new ItemMisc("Flag", 4),
        "flower" : new ItemMisc("Flower", 1),
        "flute" : new ItemMisc("Flute", 4),
        "fork" : new ItemMisc("Fork", 1),
        "gem" : new ItemMisc("Gem", 8),
        "goblet" : new ItemMisc("Goblet", 2),
        "jug" : new ItemMisc("Jug", 3),
        "kettle" : new ItemMisc("Kettle", 2),
        "lantern" : new ItemMisc("Lantern", 8),
        "plate" : new ItemMisc("Plate", 3),
        "pot" : new ItemMisc("Pot", 3),
        "rags" : new ItemMisc("Rags", 2),
        "spoon" : new ItemMisc("Spoon", 1),
        "statue" : new ItemMisc("Statue", 16),
        "tankard" : new ItemMisc("Tankard", 3),
    ];
}
