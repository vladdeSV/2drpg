module list.items;

immutable static Item[string]           ListItemMisc;
immutable static ItemWeapon[string]     ListItemWeapon;
immutable static ItemConsumable[string] ListItemConsumable;
immutable static ItemArmor[string]      ListItemArmor;

shared static this()
{
    ListItemWeapon = cast(immutable)[
        "rapier" : new ItemWeapon("Rapier", Material.Steel, [Attributes.Strength : 12], false, 100),
        "longsword" : new ItemWeapon("Longsword", Material.Iron, [Attributes.Strength : 13], true, 50),
        "schythe" : new ItemWeapon("Schythe", Material.Steel, [Attributes.Strength : 6], false, 30),
        "sabre" : new ItemWeapon("Sabre", Material.Steel, [Attributes.Strength : 7], false, 20),
        "sword" : new ItemWeapon("Sword", Material.Iron, [Attributes.Strength : 6], false, 10),
        "stave" : new ItemWeapon("Stave", Material.Wood, [Attributes.Strength : 1, Attributes.Intelligence : 3], false, 5),
        "staff" : new ItemWeapon("Staff", Material.Wood, [Attributes.Strength : 3, Attributes.Intelligence : 6], true, 7),
        "axe" : new ItemWeapon("Axe", Material.Steel, [Attributes.Strength : 5], true, 4),
    ];

    ListItemConsumable = cast(immutable)[
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

    ListItem = cast(immutable)[
        "basket" : new Item("Basket", 2),
        "bellows" : new Item("Bellows", 3),
        "book" : new Item("Book", 1),
        "bottle" : new Item("Bottle", 2),
        "bowl" : new Item("Bowl", 3),
        "bucket" : new Item("Bucket", 5),
        "candlestick" : new Item("Candlestick", 3),
        "charcoal" : new Item("Charcoal", 4),
        "cup" : new Item("Cup", 1),
        "drum" : new Item("Drum", 2),
        "firewood" : new Item("Firewood", 6),
        "fishingPole" : new Item("FishingPole", 7),
        "flag" : new Item("Flag", 4),
        "flower" : new Item("Flower", 1),
        "flute" : new Item("Flute", 4),
        "fork" : new Item("Fork", 1),
        "gem" : new Item("Gem", 8),
        "goblet" : new Item("Goblet", 2),
        "jug" : new Item("Jug", 3),
        "kettle" : new Item("Kettle", 2),
        "lantern" : new Item("Lantern", 8),
        "plate" : new Item("Plate", 3),
        "pot" : new Item("Pot", 3),
        "rags" : new Item("Rags", 2),
        "spoon" : new Item("Spoon", 1),
        "statue" : new Item("Statue", 16),
        "tankard" : new Item("Tankard", 3),
    ];
}
